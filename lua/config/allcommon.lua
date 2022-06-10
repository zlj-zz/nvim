local g = vim.g

local utils = require('settings.utils')
local opt = utils.opt
local map = utils.map

---------
-- Style
---------
-- "colorscheme pink-moon
-- "set background=dark

-- "let g:deus_termcolors=256
-- "colorscheme deus

-- " theme: ['default', 'atlantis', 'andromeda', 'shusia', 'maia']
-- "let g:sonokai_style = 'andromeda'
-- "let g:sonokai_enable_italic = 1
-- "let g:sonokai_transparent_background = 1
-- "let g:sonokai_diagnostic_text_highlight = 1
-- "let g:sonokai_current_word = 'bold'
-- "let g:sonokai_better_performance = 1
-- "colorscheme sonokai

g.nord_italic = 1
g.nord_italic_comments = 1
g.nord_cursor_line_number_background = 1
vim.cmd [[colorscheme nord]]

------------------
-- vim-illuminate
------------------
opt('laststatus', 2)
-- g.airline_theme='atomic'
-- g.airline_theme='dark'
g.airline_theme = 'nord'
g['airline#extensions#tabline#enabled'] = 1
-- g.Illuminate_delay = 750

--------------
-- indentLine
--------------
g.indentLine_noConcealCursor = 1
g.indentLine_color_term = 238
g.indentLine_char = '┆'
g.indentLine_fileTypeExclude = {'startify'}
g.indentLine_bufTypeExclude = {'help', 'terminal'}
g.indentLine_faster = 1

-----------
-- rainbow
-----------
g.rainbow_active = 1

-------
-- jsx
-------
g.vim_jsx_pretty_colorful_config = 1 -- default 0

--------------------
-- vim-visual-multi <C-D>
--------------------
-- g.VM_theme = 'iceblue'
-- g.VM_default_mappings = 0
-- g.VM_custom_motions = {'h': 'h', 'l': 'l', 'k': 'k', 'j': 'j', '0': '0'}
g.VM_leader = {
    default = ',',
    visual = ',',
    buffer = ','
}
g.VM_maps = {
    ['Find Under'] = '<C-d>',
    ['Find Subword Under'] = '<C-d>',
    ['Find Prev'] = '-',
    ['Find Next'] = '=',
    ['Remove Region'] = 'Q',
    ['Skip Region'] = 'q',
    ["Undo"] = 'u',
    ["Redo"] = '<C-r>'
}
g.VM_mouse_mappings = 1

------------------
-- vim-easy-align
------------------
map('x', 'ga', '<Plug>(EasyAlign)')
map('n', 'ga', '<Plug>(EasyAlign)')

--------
-- Goyo
--------
map('', '<leader>gy', ':Goyo<cr>')

-- "if g:isWin == 0
--   "" \\\\\\
--   "" >>>>>>> Vista
--   "" //////
--   "" use `p` to preview
--   "" use `q` to quit
--   "let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
--   "let g:vista#renderer#enable_icon = 1
--   "nmap ti :Vista!!<CR>
-- "endif
