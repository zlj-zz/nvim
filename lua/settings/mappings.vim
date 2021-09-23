" vim:set et sw=2 ts=2 fdm=marker fdl=1:

" Opening a terminal window
"nnoremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +1<CR>:term<CR>
"tnoremap <C-N> <C-\><C-N>


let s:browsers = {}
let s:browsers['chrome'] = 'open -a Google\ Chrome '
let s:browsers['firefox'] = 'open -a Firefox '
function! UserFuncViewFile()
  exec 'silent !' . s:browsers['firefox'] . expand('%:p')
endfunction

noremap <leader>go :call UserFuncViewFile()<CR>
