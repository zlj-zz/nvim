" vim:set et sw=2 ts=2 fdm=marker fdl=1:

" \\\\\\\\\\\\\\\
" =============== undotree
" ///////////////
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


" \\\\\\\\\\\\\\\
" =============== tagbar
" ///////////////
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


" \\\\\\\\\\\\\\\
" =============== nerdcommenter
" ///////////////
let g:NERDDefaultAlign = 'none'
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = {'python': {'left': '# ', 'leftAlt': '""" ', 'rightAlt': ' """'}}
" For vue
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
nmap <leader>/ <Plug>NERDCommenterToggle
xmap <leader>/ <Plug>NERDCommenterToggle


" \\\\\\\\\\\\\\\
" =============== floaterm
" ///////////////
let g:floaterm_gitcommit = 'split'
nnoremap <c-t> :FloatermToggle<cr>
tnoremap <c-t> <C-\><C-N>:FloatermToggle<cr>


" \\\\\\\\\\\\\\\
" =============== vim-easy-align 
" ///////////////
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" \\\\\\\\\\\\\\\
" =============== vim-visual-multi 
" ///////////////
"let g:VM_theme             = 'iceblue'
"let g:VM_default_mappings = 0
let g:VM_leader                     = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_maps                       = {}
let g:VM_custom_motions             = {'h': 'h', 'l': 'l', 'k': 'k', 'j': 'j', '0': '0'}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
let g:VM_maps['Find Prev']          = '-'
let g:VM_maps['Find Next']          = '='
let g:VM_maps['Remove Region']      = 'Q'
let g:VM_maps['Skip Region']        = 'q'
let g:VM_maps["Undo"]               = 'u'
let g:VM_maps["Redo"]               = '<C-r>'
let g:VM_mouse_mappings             = 1


" \\\\\\\\\\\\\\\
" =============== Goyo
" ///////////////
map <LEADER>gy :Goyo<CR>

