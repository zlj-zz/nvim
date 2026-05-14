local api = vim.api
local funcs = require('funcs')

local group = api.nvim_create_augroup('ZACHARY_GROUP', { clear = true })

-- Restore last cursor position and open folds on BufReadPost.
api.nvim_create_autocmd('BufReadPost', {
    group = group,
    pattern = '*',
    callback = function()
        if vim.bo.filetype == 'gitcommit' then
            return
        end
        local mark = api.nvim_buf_get_mark(0, '"')
        local lcount = api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(api.nvim_win_set_cursor, 0, mark)
            vim.cmd('normal! zv')
        end
    end,
    desc = 'Restore cursor position and open folds',
})

-- Disable syntax and linting for very large files (>10 MB).
api.nvim_create_autocmd('BufReadPre', {
    group = group,
    pattern = '*',
    callback = function()
        local fsize = vim.fn.getfsize(vim.fn.expand('%'))
        if fsize > 10000000 then
            vim.cmd('syntax off')
            vim.g.ale_enabled = 0
        end
    end,
    desc = 'Disable syntax/linting for large files (>10MB)',
})

-- Speed up syntax highlighting for files with >2000 lines.
api.nvim_create_autocmd('Syntax', {
    group = group,
    pattern = '*',
    command = "if 2000 < line('$') | syntax sync maxlines=200 | endif",
    desc = 'Limit syntax sync for large files',
})

-- Re-detect filetype on save if it was empty.
api.nvim_create_autocmd('BufWritePost', {
    group = group,
    pattern = '*',
    nested = true,
    callback = function()
        if vim.bo.filetype == '' or vim.b.ftdetect then
            vim.b.ftdetect = nil
            vim.cmd('filetype detect')
        end
    end,
    desc = 'Re-detect filetype if empty on save',
})

-- Toggle cursorline based on mode.
api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
    group = group,
    pattern = '*',
    command = 'set cursorline',
    desc = 'Enable cursorline in normal mode',
})

api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
    group = group,
    pattern = '*',
    command = 'set nocursorline',
    desc = 'Disable cursorline in insert mode',
})

-- Close NvimTree if it's the last window.
api.nvim_create_autocmd({ "QuitPre" }, {
    callback = function() vim.cmd("NvimTreeClose") end,
})

-- Terminal: open file path on current line in editing area.
api.nvim_create_autocmd('TermOpen', {
    group = group,
    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        vim.keymap.set({ 't', 'n' }, '<C-o>', funcs.open_file_from_terminal, opts)

        -- macOS: Cmd+Click may be intercepted by the terminal; use Ctrl+Click as fallback.
        local mouse_fn = function()
            local pos = vim.fn.getmousepos()
            if pos.winid == 0 then
                return
            end
            local win_buf = api.nvim_win_get_buf(pos.winid)
            local lines = api.nvim_buf_get_lines(win_buf, pos.line - 1, pos.line, false)
            funcs.open_file_from_terminal_line(lines[1])
        end
        vim.keymap.set({ 't', 'n' }, '<C-LeftMouse>', mouse_fn, opts)
        vim.keymap.set({ 't', 'n' }, '<D-LeftMouse>', mouse_fn, opts)
    end,
    desc = 'Open file from terminal line in editing area',
})
