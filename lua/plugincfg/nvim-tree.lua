local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.map.on_attach.default(bufnr)

    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

require('nvim-tree').setup({
    on_attach = my_on_attach,
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
    renderer = {
        highlight_git = 'name',
        icons = {
            glyphs = {
                git = {
                    unstaged = '✗',
                    staged = '✓',
                    unmerged = '✖',
                    renamed = '➜',
                    untracked = '★',
                    deleted = '✖',
                    ignored = '◌',
                },
            },
        },
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

-- VS Code-style git status colors
local hl = vim.api.nvim_set_hl
hl(0, 'NvimTreeGitDirty',    { fg = '#e5c07b' }) -- modified: orange/yellow
hl(0, 'NvimTreeGitStaged',   { fg = '#98c379' }) -- staged: green
hl(0, 'NvimTreeGitNew',      { fg = '#98c379' }) -- untracked: green
hl(0, 'NvimTreeGitDeleted',  { fg = '#e06c75' }) -- deleted: red
hl(0, 'NvimTreeGitIgnored',  { fg = '#636e7b' }) -- ignored: gray
hl(0, 'NvimTreeGitRenamed',  { fg = '#61afef' }) -- renamed: blue
hl(0, 'NvimTreeGitMerge',    { fg = '#c678dd' }) -- conflict: purple
