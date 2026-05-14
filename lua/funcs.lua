local M = {}

local g = vim.g
local t = vim.t
local fn = vim.fn
local api = vim.api

-------------------------------
---Open current in a browsers.
-------------------------------
local browsers = {
    chrome = 'open -a Google Chrome ',
    firefox = 'open -a Firefox '
}

M.open_curr_on_browser = function()
    vim.cmd('silent !' .. browsers.firefox .. fn.expand('%:p'))
end

--------------------
---Switch bg color.
--------------------
g.bg_flag__ = 1

M.switch_transparent_bg = function()
    -- Capture original guibg on first call (after colorscheme is loaded)
    if g.record_guibg__ == nil then
        local hi = fn.execute('hi normal')
        g.record_guibg__ = fn.matchstr(hi, 'guibg=\\zs\\S*')
    end

    if g.bg_flag__ == 1 then
        g.bg_flag__ = 0
        vim.cmd [[hi normal guibg=none]]
    else
        g.bg_flag__ = 1
        vim.cmd('hi normal guibg=' .. g.record_guibg__)
    end
end

--------------------------------------------------
---toggle to make a screen full when split screen
--------------------------------------------------
M.switch_full_screen = function()
    if t.zoomed ~= nil and t.zoomed == 1 then
        vim.cmd(t.zoom_winrestcmd)
        t.zoomed = 0
    else
        t.zoom_winrestcmd = fn.winrestcmd()
        vim.cmd [[resize]]
        vim.cmd [[vertical resize]]
        t.zoomed = 1
    end
end

-----------------------------------
--- change current buffer by index
-----------------------------------
---@param num integer
M.buf_index = function(num)
    if num == nil then
        return
    end

    local buf_list = fn.filter(fn.range(1, fn.bufnr('$')), 'buflisted(v:val)')

    if num > #buf_list then
        return
    end

    local buf_id = buf_list[num]
    vim.cmd(':' .. buf_id .. 'b')
end

M.get_time = function()
    return fn.strftime('%Y-%m-%d %H:%M:%S')
end

---Split window then open telescope file picker (fallback to :e if no telescope).
---@param split_cmd string
M.telescope_split = function(split_cmd)
    local ok, builtin = pcall(require, 'telescope.builtin')
    if ok then
        vim.cmd(split_cmd)
        builtin.find_files()
    else
        vim.cmd(split_cmd .. ' | e')
    end
end

local function confirm_close(msg)
    local choice = fn.confirm(msg, '&Yes\n&No', 2)
    return choice == 1
end

---Close current buffer and switch to the previous one.
---If only one listed buffer remains, quit the window instead.
---Prompts for confirmation if the buffer has unsaved changes.
M.smart_close = function()
    local wins = vim.tbl_filter(function(w)
        local buf = api.nvim_win_get_buf(w)
        return vim.bo[buf].buflisted
    end, api.nvim_list_wins())

    -- In a split: just close the current window, keep the buffer
    if #wins > 1 then
        local cur = api.nvim_get_current_buf()
        local modified = fn.getbufvar(cur, '&modified') == 1
        if modified then
            if not confirm_close('Buffer has unsaved changes. Close window anyway?') then
                return
            end
            vim.cmd('q!')
        else
            vim.cmd('q')
        end
        return
    end

    local buf_list = fn.getbufinfo({ buflisted = 1 })
    local cur = api.nvim_get_current_buf()
    local modified = fn.getbufvar(cur, '&modified') == 1

    -- Only one buffer left: quit nvim
    if #buf_list <= 1 then
        if modified then
            if not confirm_close('Buffer has unsaved changes. Quit anyway?') then
                return
            end
            vim.cmd('q!')
        else
            vim.cmd('q')
        end
        return
    end

    if modified then
        if not confirm_close('Buffer has unsaved changes. Close anyway?') then
            return
        end
    end

    local alt = fn.bufnr('#')

    -- If alternate buffer is valid and listed, switch to it first
    if alt > 0 and fn.buflisted(alt) == 1 and alt ~= cur then
        vim.cmd('b#')
    else
        -- Fall back to previous buffer in the list
        vim.cmd('bp')
    end

    -- Delete the buffer we just left
    if modified then
        vim.cmd('bd! ' .. cur)
    else
        vim.cmd('bd ' .. cur)
    end
end

local function extract_path(line)
    line = line:match('^%s*(.-)%s*$')
    local path = line:match('^%S+%s+(.-)%s*$')
    if path then
        local renamed = path:match('^.-%s+->%s+(.-)%s*$')
        return renamed or path
    end
    if line:match('^[%w_%-%./]+$') then
        return line
    end
    return nil
end

local function find_editable_win(exclude_win)
    for _, win in ipairs(api.nvim_list_wins()) do
        if win ~= exclude_win then
            local buf = api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype ~= 'terminal' and vim.bo[buf].filetype ~= 'NvimTree' then
                return win
            end
        end
    end
    return nil
end

local function notify_and_restore(msg)
    vim.notify(msg, vim.log.levels.WARN)
    vim.cmd('startinsert')
end

local function open_path_in_editor(path)
    local abs_path = fn.filereadable(path) == 1 and path or (fn.getcwd() .. '/' .. path)
    if fn.filereadable(abs_path) ~= 1 then
        return nil, 'File not found: ' .. abs_path
    end

    local term_win = api.nvim_get_current_win()
    vim.cmd('wincmd p')
    local cur_buf = api.nvim_win_get_buf(0)
    if vim.bo[cur_buf].buftype == 'terminal' or vim.bo[cur_buf].filetype == 'NvimTree' then
        local win = find_editable_win(term_win)
        api.nvim_set_current_win(win or term_win)
    end

    vim.cmd('e ' .. fn.fnameescape(abs_path))
    return true
end

M.open_file_from_terminal = function()
    vim.cmd('stopinsert')
    local path = extract_path(fn.getline('.'))
    if not path then
        notify_and_restore('No file path found on current line')
        return
    end

    local ok, err = open_path_in_editor(path)
    if not ok then
        notify_and_restore(err)
    end
end

M.open_file_from_terminal_line = function(line_str)
    local path = extract_path(line_str)
    if not path then
        return
    end
    open_path_in_editor(path)
end

return M
