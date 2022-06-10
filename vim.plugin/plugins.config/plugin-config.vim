" vim:set et sw=2 ts=2 fdm=marker fdl=1:

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

