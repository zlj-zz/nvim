local g = vim.g

local utils = require('utils')
local map = utils.map

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

------------------
---vim-table-mode
------------------
-- g.table_mode_disable_mappings = 1
g.table_mode_cell_text_object_i_map = 'k<Bar>'
map('', '<leader>tm', ':TableModeToggle<cr>')

---------------
---Bullets.vim
---------------
g.bullets_enabled_file_types = { 'markdown', 'text', 'gitcommit', 'scratch' }

---------------
---vim-autoformat
---------------
--map('n', '\\f', ':Autoformat<CR>')

---------------
---vim-after-object
---------------
-- "autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

---------------
---nerdtree
---------------
-- "map <F7> :NERDTreeToggle<CR>
-- "let NERDTreeIgnore = ['\.pyc$']
-- "let NERDTreeShowBookmarks=1
-- "function! s:initVariable(var, value)
--     "if !exists(a:var)
--         "exec 'let ' . a:var . ' = ' . "'" . substitute(a:value, "'", "''", "g") . "'"
--         "return 1
--     "endif
--     "return 0
-- "endfunction
-- "call s:initVariable("g:NERDTreeMapOpenSplit", "h")

---------------
---xtabline
---------------
-- "let g:xtabline_settings = {}
-- "let g:xtabline_settings.enable_mappings = 0
-- "let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
-- "let g:xtabline_settings.enable_persistance = 0
-- "let g:xtabline_settings.last_open_first = 1
-- "noremap \p :XTabInfo<CR>
