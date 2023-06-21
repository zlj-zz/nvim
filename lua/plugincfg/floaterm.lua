local utils = require('utils')
local map = utils.map

local g = vim.g

g.floaterm_gitcommit = 'split'

map('n', '<c-t>', ':FloatermToggle<cr>')
map('t', '<c-t>', '<C-\\><C-N>:FloatermToggle<cr>')
