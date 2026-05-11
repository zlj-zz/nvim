local map = require('utils').map

require('telescope').setup({
    defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                prompt_position = 'top',
                preview_width = 0.55,
            },
        },
        sorting_strategy = 'ascending',
        winblend = 0,
    },
    pickers = {
        find_files = { theme = 'dropdown' },
        buffers = { theme = 'dropdown' },
    },
})

require('telescope').load_extension('fzf')

map('n', ',f', ':Telescope live_grep<cr>')
map('n', ',h', ':Telescope oldfiles<cr>')
map('n', ',b', ':Telescope buffers<cr>')
map('n', ',l', ':Telescope current_buffer_fuzzy_find<cr>')
map('n', ',c', ':Telescope command_history<cr>')
map('n', ',k', ':Telescope keymaps<cr>')
