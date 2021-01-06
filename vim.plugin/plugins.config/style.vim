" vim:set et sw=2 ts=2 fdm=marker fdl=1:

"colorscheme gruvbox
"colorscheme zenburn
"colorscheme pink-moon
"set background=dark
colorscheme deus
let g:deus_termcolors=256
let g:bg_flag = 1
"let g:bg_c="#242a32"
let g:bg_c="#2C323B"
"let g:bg_c="#000000"

exec "hi normal guibg=".bg_c
func! ChangeGuibg() " transparent background toggle
    if g:bg_flag == 1
        exec "hi normal guibg=none"
        let g:bg_flag = 0
    else
        exec "hi normal guibg=".g:bg_c
        let g:bg_flag = 1
    endif
endfunc
map <f4> :call ChangeGuibg()<CR>



" \\\\\\
" >>>>>>> vim-illuminate 
" //////
set laststatus=2
"let g:airline_theme='atomic'
"let g:airline_theme='dark'
let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1
"let g:Illuminate_delay = 750



" \\\\\\
" >>>>>>> indentLine 
" //////
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term      = 238
let g:indentLine_char            = '|'


" \\\\\\
" >>>>>>> rainbow 
" //////
let g:rainbow_active = 1
