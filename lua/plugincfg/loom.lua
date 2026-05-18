require('loom').setup({
    autosave = {
        enabled = false,
        interval_minutes = 30,
        on_events = { 'BufWritePost' },
        max_auto_snaps = 10,
    },
    cleanup = {
        max_snapshots = 50,
        auto_cleanup_after_days = 90,
    },
    integrations = {
        telescope = true,
        which_key = false,
    },
})

-- Manual keymaps (which-key is disabled)
local map = require('utils').map
map('n', '<leader>ls', '<cmd>LoomSave<cr>')
map('n', '<leader>ll', '<cmd>LoomLoad<cr>')
map('n', '<leader>lL', '<cmd>LoomList<cr>')
map('n', '<leader>lw', '<cmd>LoomWorkspaceSave<cr>')
map('n', '<leader>lW', '<cmd>LoomWorkspaceLoad<cr>')
map('n', '<leader>lc', '<cmd>LoomCleanup<cr>')
map('n', '<leader>lS', '<cmd>LoomSwitch<cr>')

-- Telescope extension
local ok, telescope = pcall(require, 'telescope')
if ok then
    telescope.load_extension('loom')
end
