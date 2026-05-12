local M = {}
local api = vim.api
local utils = require('utils')

function M.show(title, content, is_error)
    local width = math.min(100, math.floor(vim.o.columns * 0.8))
    local height = math.min(40, math.floor(vim.o.lines * 0.8))
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = api.nvim_create_buf(false, true)
    vim.bo[buf].bufhidden = 'wipe'
    vim.bo[buf].filetype = 'markdown'
    vim.bo[buf].modifiable = true

    local lines = vim.split(content, '\n')
    api.nvim_buf_set_lines(buf, 0, -1, true, lines)
    vim.bo[buf].modifiable = false

    local win = api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        style = 'minimal',
        border = 'rounded',
        title = ' ' .. title .. ' ',
        title_pos = 'center',
    })

    vim.wo[win].wrap = true
    vim.wo[win].cursorline = false
    if is_error then
        vim.wo[win].winhl = 'Normal:ErrorMsg'
    end

    local map = utils.map
    local opts = { buffer = buf, silent = true }
    local function close_win()
        pcall(api.nvim_win_close, win, true)
    end
    map('n', 'q', close_win, opts)
    map('n', '<Esc>', close_win, opts)
    map('n', 'y', function()
        vim.fn.setreg('+', content)
        utils.info('Result copied to clipboard')
    end, opts)
end

return M
