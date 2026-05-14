require('nvim-tree').setup({
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
    },
    sort_by = 'case_sensitive',
    view = {
        width = 39,
        side = 'left',
        number = false,
        relativenumber = false,
    },
    filters = {},
    git = {
        enable = true,
        ignore = false,
    },
    actions = {
        open_file = {
            quit_on_open = false,
            resize_window = true,
        },
    },
})
