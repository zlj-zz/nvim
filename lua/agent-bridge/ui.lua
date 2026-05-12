local M = {}
local api = vim.api
local utils = require('utils')
local sender_mod = require('agent-bridge.sender')

local state = {
    win = nil,
    sender_mode = 'auto',
    context = nil,
}

local function close_float()
    if state.win and api.nvim_win_is_valid(state.win) then
        pcall(api.nvim_win_close, state.win, true)
    end
    vim.cmd('stopinsert')
    state.win = nil
    state.context = nil
end

local function render_footer(mode)
    local parts = {}
    for _, m in ipairs(sender_mod.SENDERS) do
        if m == mode then
            table.insert(parts, '[' .. m .. ']')
        else
            table.insert(parts, ' ' .. m .. ' ')
        end
    end
    return '  ' .. table.concat(parts, ' | ') .. '  '
end

function M.open(ctx, config, on_send)
    M.close()
    state.context = ctx
    state.sender_mode = config.default_sender

    local width = math.min(80, math.floor(vim.o.columns * 0.7))
    local height = math.min(30, math.floor(vim.o.lines * 0.7))
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = api.nvim_create_buf(false, true)
    vim.bo[buf].bufhidden = 'wipe'
    vim.bo[buf].filetype = 'markdown'

    local lines = {
        '# ' .. vim.fn.fnamemodify(ctx.filepath, ':t') .. ' (L' .. ctx.start_line .. '-' .. ctx.end_line .. ')',
        '',
        '```' .. ctx.lang,
    }
    vim.list_extend(lines, vim.split(ctx.code, '\n'))
    vim.list_extend(lines, { '```', '', '---', '', 'Ask: ' })

    api.nvim_buf_set_lines(buf, 0, -1, true, lines)

    local ask_line = #lines - 1

    local win = api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        style = 'minimal',
        border = 'rounded',
        title = ' Agent Bridge ',
        title_pos = 'center',
        footer = render_footer(state.sender_mode),
        footer_pos = 'center',
    })

    vim.wo[win].wrap = true
    vim.wo[win].cursorline = true

    api.nvim_win_set_cursor(win, { ask_line + 1, 5 })

    local map = utils.map
    map({ 'n', 'i' }, '<Esc>', close_float, { buffer = buf, silent = true })
    map({ 'n', 'i' }, '<C-s>', function()
        M._submit(buf, ask_line, config, on_send)
    end, { buffer = buf, silent = true })
    map({ 'n', 'i' }, '<Tab>', function()
        state.sender_mode = sender_mod.cycle(state.sender_mode)
        api.nvim_win_set_config(win, {
            footer = render_footer(state.sender_mode),
            footer_pos = 'center',
        })
    end, { buffer = buf, silent = true })

    vim.cmd('startinsert!')

    state.win = win
end

function M._submit(buf, ask_line, config, on_send)
    local question_lines = api.nvim_buf_get_lines(buf, ask_line, -1, true)
    local question = table.concat(question_lines, '\n'):gsub('^%s*Ask:%s*', '')

    if question == '' then
        utils.warn('agent-bridge: empty question')
        return
    end

    local ctx = state.context
    local replacements = {
        filepath = ctx.filepath,
        start = tostring(ctx.start_line),
        ['end'] = tostring(ctx.end_line),
        lang = ctx.lang,
        code = ctx.code,
        question = question,
    }
    local prompt = config.prompt_template:gsub('{(%w+)}', replacements)

    close_float()
    on_send(prompt, state.sender_mode)
end

function M.close()
    close_float()
end

return M
