require('aerial').setup({
    backends = { 'lsp', 'treesitter', 'markdown', 'man' },
    layout = {
        default_direction = 'prefer_right',
        min_width = 20,
    },
    show_guides = true,
    filter_kind = false,
    guides = {
        mid_item = '├─',
        last_item = '└─',
        nested_top = '│ ',
        whitespace = '  ',
    },
})
