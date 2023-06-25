local utils = require('utils')
local opt = utils.opt
local map = utils.map

local g = vim.g

---------
-- Style
---------
-- " theme: ['default', 'atlantis', 'andromeda', 'shusia', 'maia']
-- "let g:sonokai_style = 'andromeda'
-- "let g:sonokai_enable_italic = 1
-- "let g:sonokai_transparent_background = 1
-- "let g:sonokai_diagnostic_text_highlight = 1
-- "let g:sonokai_current_word = 'bold'
-- "let g:sonokai_better_performance = 1
-- "colorscheme sonokai


-- [deus]
--g.deus_termcolors = 256
--vim.cmd [[colorscheme deus]]
--g.airline_theme='atomic' -- vim-illuminate


-- [nord]
g.nord_italic = 1
g.nord_italic_comments = 1
g.nord_cursor_line_number_background = 1
vim.cmd [[colorscheme nord]]
g.airline_theme = 'nord'

-- [pink-moon]
-- opt('background', 'dark')
-- vim.cmd [[colorscheme pink-moon]]
--g.airline_theme='dark'


------------------
-- vim-illuminate
------------------
opt('laststatus', 2)
g['airline#extensions#tabline#enabled'] = 1
-- g.Illuminate_delay = 750

--------------
-- indentLine
--------------
g.indentLine_noConcealCursor = 1
g.indentLine_color_term = 238
g.indentLine_char = '┆'
g.indentLine_fileTypeExclude = { 'startify' }
g.indentLine_bufTypeExclude = { 'help', 'terminal' }
g.indentLine_faster = 1

-----------
-- rainbow
-----------
g.rainbow_active = 1

