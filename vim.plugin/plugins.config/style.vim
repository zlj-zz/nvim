" vim:set et sw=2 ts=2 fdm=marker fdl=1:

"colorscheme pink-moon
"set background=dark

"let g:deus_termcolors=256
"colorscheme deus

" theme: ['default', 'atlantis', 'andromeda', 'shusia', 'maia']
"let g:sonokai_style = 'andromeda' 
"let g:sonokai_enable_italic = 1
"let g:sonokai_transparent_background = 1
"let g:sonokai_diagnostic_text_highlight = 1
"let g:sonokai_current_word = 'bold'
"let g:sonokai_better_performance = 1
"colorscheme sonokai

let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_cursor_line_number_background = 1
colorscheme nord



" \\\\\\
" >>>>>>> vim-illuminate 
" //////
set laststatus=2
"let g:airline_theme='atomic'
"let g:airline_theme='dark'
let g:airline_theme='nord'
let g:airline#extensions#tabline#enabled = 1
"let g:Illuminate_delay = 750



" \\\\\\
" >>>>>>> indentLine 
" //////
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term      = 238
let g:indentLine_char            = '┆'
let g:indentLine_fileTypeExclude = ['startify']
let g:indentLine_bufTypeExclude = ['help', 'terminal']
let g:indentLine_faster = 1


" \\\\\\
" >>>>>>> rainbow 
" //////
let g:rainbow_active = 1
