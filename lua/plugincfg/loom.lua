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
        which_key = true,
    },
})

-- Telescope extension
local ok, telescope = pcall(require, 'telescope')
if ok then
    telescope.load_extension('loom')
end
