local utils = require('utils')
local map = utils.map

require('yanky').setup({
    ring = {
        history_length = 100,
        storage = 'shada',
        sync_with_numbered_registers = true,
        cancel_event = 'update',
    },
    picker = {
        select = {
            action = nil,
        },
        telescope = {
            use_default_mappings = true,
            mappings = nil,
        },
    },
    system_clipboard = {
        sync_with_ring = true,
    },
    highlight = {
        on_put = true,
        on_yank = true,
        timer = 500,
    },
    preserve_cursor_position = {
        enabled = true,
    },
})

-- Cycle through yank history with <c-p> / <c-n> in normal mode after paste
map('n', '<c-p>', '<Plug>(YankyPreviousEntry)')
map('n', '<c-n>', '<Plug>(YankyNextEntry)')

-- Open yank history via telescope
map('n', '<space>y', ':Telescope yank_history<cr>')
