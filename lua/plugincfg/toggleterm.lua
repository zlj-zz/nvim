local map = require('utils').map

require('toggleterm').setup({
    size = function(term)
        if term.direction == 'horizontal' then
            return 15
        elseif term.direction == 'vertical' then
            return vim.o.columns * 0.3
        end
    end,
    open_mapping = nil,
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = 'horizontal',
    close_on_exit = true,
    shell = vim.o.shell,
})

local Terminal = require('toggleterm.terminal').Terminal

-- Default bottom terminal
local bottom_term = Terminal:new({ direction = 'horizontal', hidden = true })

-- Right-side terminal
local right_term = Terminal:new({ direction = 'vertical', hidden = true })

-- Toggle bottom terminal
map({ 'n', 't' }, '<C-t>', function()
    bottom_term:toggle()
end)

-- Toggle right terminal
map({ 'n', 't' }, '<C-l>', function()
    right_term:toggle()
end)

-- Escape terminal mode to normal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>')
