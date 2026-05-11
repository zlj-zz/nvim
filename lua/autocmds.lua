local api = vim.api

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
