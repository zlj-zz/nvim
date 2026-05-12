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
    renderer = {
        group_empty = true,
        indent_markers = { enable = true },
        icons = {
            show = {
                git = true,
                file = true,
                folder = true,
                folder_arrow = true,
            },
        },
    },
    filters = {
        dotfiles = false,
        git_ignored = false,
        custom = { '__pycache__', '\\.git', 'node_modules', '\\.DS_Store' },
    },
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
