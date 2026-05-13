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

---Close current buffer and switch to the previous one.
---If only one listed buffer remains, quit the window instead.
M.buf_close = function()
    local buf_list = fn.filter(fn.range(1, fn.bufnr('$')), 'buflisted(v:val)')

    -- Only one buffer left: close the window (quit nvim if last window)
    if #buf_list <= 1 then
        vim.cmd('q')
        return
    end

    local cur = api.nvim_get_current_buf()
    local alt = fn.bufnr('#')

    -- If alternate buffer is valid and listed, switch to it first
    if alt > 0 and fn.buflisted(alt) == 1 and alt ~= cur then
        vim.cmd('b#')
    else
        -- Fall back to previous buffer in the list
        vim.cmd('bp')
    end

    -- Delete the buffer we just left
    vim.cmd('bd ' .. cur)
end

return M

