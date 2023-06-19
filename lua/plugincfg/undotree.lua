local g = vim.g

g.undotree_DiffAutoOpen = 1
g.undotree_SetFocusWhenToggle = 1
g.undotree_ShortIndicators = 1
g.undotree_WindowLayout = 2
g.undotree_DiffpanelHeight = 8
g.undotree_SplitWidth = 24

vim.cmd([[

function g:Undotree_CustomMap()
  nmap <buffer> k <plug>UndotreeNextState
  nmap <buffer> j <plug>UndotreePreviousState
  nmap <buffer> K 5<plug>UndotreeNextState
  nmap <buffer> J 5<plug>UndotreePreviousState
endfunc

nnoremap tu :UndotreeToggle<CR>

]])
