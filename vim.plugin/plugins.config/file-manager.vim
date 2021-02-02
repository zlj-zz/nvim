" vim:set et sw=2 ts=2 fdm=marker fdl=1:

let g:undotree_DiffAutoOpen       = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators    = 1
let g:undotree_WindowLayout       = 2
let g:undotree_DiffpanelHeight    = 8
let g:undotree_SplitWidth         = 24
function g:Undotree_CustomMap()
  nmap <buffer> k <plug>UndotreeNextState
  nmap <buffer> j <plug>UndotreePreviousState
  nmap <buffer> K 5<plug>UndotreeNextState
  nmap <buffer> J 5<plug>UndotreePreviousState
endfunc
nnoremap tu :UndotreeToggle<CR>


"if g:isWin == 0
  "" \\\\\\
  "" >>>>>>> Vista 
  "" //////
  "" use `p` to preview
  "" use `q` to quit
  "let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
  "let g:vista#renderer#enable_icon = 1
  "nmap ti :Vista!!<CR>
"endif


" \\\\\\
" >>>>>>> tagbar 
" //////
nmap ti :TagbarToggle<cr>
let g:tagbar_sort=0  " close auto sort
let g:tagbar_width=30  " set window width
"let g:tagbar_autopreview = 1
let g:tagbar_autofocus = 1
"autocmd bufreadpost *.py,*.cpp,*.c,*.java,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()  " where file auto open the window
function! s:init_var(var, value) abort
  if !exists('g:tagbar_' . a:var)
    execute 'let g:tagbar_' . a:var . ' = ' . string(a:value)
  endif
endfunction
function! s:setup_keymaps() abort
  let keymaps = [
              \ ['togglecaseinsensitive', ''],
              \ ]
  for [map, key] in keymaps
    call s:init_var('map_' . map, key)
    unlet key
  endfor
endfunction
call s:setup_keymaps()
