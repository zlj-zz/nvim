local g = vim.g

local utils = require('settings.utils')
local map = utils.map

g.floaterm_gitcommit = 'split'

map('n', '<c-t>', ':FloatermToggle<cr>')
map('t', '<c-t>', '<C-\\><C-N>:FloatermToggle<cr>')
