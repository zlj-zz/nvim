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

map('n', ',g', '<cmd>Telescope live_grep<cr>')
map('n', ',f', '<cmd>Telescope find_files<cr>')
map('n', ',h', '<cmd>Telescope oldfiles<cr>')
map('n', ',b', '<cmd>Telescope buffers<cr>')
map('n', ',l', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
map('n', ',c', '<cmd>Telescope command_history<cr>')
map('n', ',k', '<cmd>Telescope keymaps<cr>')
