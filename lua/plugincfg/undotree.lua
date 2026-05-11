local g = vim.g

g.undotree_DiffAutoOpen = 1
g.undotree_SetFocusWhenToggle = 1
g.undotree_ShortIndicators = 1
g.undotree_WindowLayout = 2
g.undotree_DiffpanelHeight = 8
g.undotree_SplitWidth = 24

-- Buffer-local keymaps for undotree windows
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'undotree',
    callback = function()
        local opts = { buffer = true, remap = true, silent = true }
        vim.keymap.set('n', 'k', '<plug>UndotreeNextState', opts)
        vim.keymap.set('n', 'j', '<plug>UndotreePreviousState', opts)
        vim.keymap.set('n', 'K', '5<plug>UndotreeNextState', opts)
        vim.keymap.set('n', 'J', '5<plug>UndotreePreviousState', opts)
    end,
})

vim.keymap.set('n', 'tu', ':UndotreeToggle<CR>', { silent = true })
