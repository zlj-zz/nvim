" vim:set et sw=2 ts=2 fdm=marker fdl=1:

"colorscheme pink-moon
"set background=dark

"let g:bg_c="#2C323B"
"let g:deus_termcolors=256
"colorscheme deus

" theme: ['default', 'atlantis', 'andromeda', 'shusia', 'maia']
let g:sonokai_style = 'andromeda' 
let g:sonokai_enable_italic = 1
"let g:sonokai_transparent_background = 1
"let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_current_word = 'bold'
let g:sonokai_better_performance = 1
colorscheme sonokai


let s:hi = execute('hi normal')
let s:guibg_ = matchstr(s:hi, 'guibg=\zs\S*')
unlet s:hi
let g:bg_flag_ = 1

func! ZToggleTransparent() " transparent background toggle
  if g:bg_flag_ == 1
    let g:bg_flag_ = 0
    exec "hi normal guibg=none"
  else
    let g:bg_flag_ = 1
    exec "hi normal guibg=".s:guibg_
  endif
endfunc
map <f4> :call ZToggleTransparent()<CR>



" \\\\\\
" >>>>>>> vim-illuminate 
" //////
set laststatus=2
"let g:airline_theme='atomic'
"let g:airline_theme='dark'
let g:airline_theme='sonokai'
let g:airline#extensions#tabline#enabled = 1
"let g:Illuminate_delay = 750



" \\\\\\
" >>>>>>> indentLine 
" //////
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term      = 238
let g:indentLine_char            = '|'
let g:indentLine_fileTypeExclude = ['startify']
let g:indentLine_bufTypeExclude = ['help', 'terminal']
let g:indentLine_faster = 1


" \\\\\\
" >>>>>>> rainbow 
" //////
let g:rainbow_active = 1
