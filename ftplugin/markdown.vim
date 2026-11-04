" auto open spell check if the file type is md
setlocal spell

" insert-mode snippets (,f jumps to next <++>)
inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
inoremap <buffer> ,n ---<Enter><Enter>
inoremap <buffer> ,b **** <++><Esc>F*hi
inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
inoremap <buffer> ,i ** <++><Esc>F*i
inoremap <buffer> ,u <u></u> <++><Esc>Fuhhi
inoremap <buffer> ,r <font color="#f00"></font><++><Esc>F/hi
inoremap <buffer> ,h <font style="background:yellow"></font><++><Esc>F/hi
inoremap <buffer> ,d `` <++><Esc>F`i
inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
inoremap <buffer> ,m - [ ] <Enter><++><ESC>kA
inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
inoremap <buffer> ,a [](<++>) <++><Esc>F[a
