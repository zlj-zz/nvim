" vim:set et sw=2 ts=2 fdm=marker fdl=1:

" Opening a terminal window
"nnoremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +1<CR>:term<CR>
"tnoremap <C-N> <C-\><C-N>

" find two same word
nmap <LEADER>fd /\(\<\w\+\>\)\_s*\1

" Press space twice to jump to the next ':' and edit it
nnoremap <LEADER><LEADER> <ESC>/<++><CR>:nohlsearch<CR>c4l

" lazygit
if g:isWin == 0
  noremap <c-g> :tabe<CR>:-tabmove<CR>:term lazygit<CR>a
endif

" find the conflict line of git
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

let s:browsers = {}
let s:browsers['chrome'] = 'open -a Google\ Chrome '
let s:browsers['firefox'] = 'open -a Firefox '
function! UserFuncViewFile()
  exec 'silent !' . s:browsers['firefox'] . expand('%:p')
endfunction

noremap <leader>go :call UserFuncViewFile()<CR>
