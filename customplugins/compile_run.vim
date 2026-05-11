" vim:set et sw=2 ts=2 fdm=marker fdl=1:

func! CompileRunGcc()
  exec "w"

  if &filetype == 'c'
    exec "!gcc % -o %<"
    exec "!time ./%<"

  elseif &filetype == 'cpp'
    exec "!g++ -std=c++11 % -Wall -o %<"
    belowright sp
    :res -15
    :term ./%<

  elseif &filetype == 'java'
    belowright sp
    :res -5
    term javac % && time java %<

  elseif &filetype == 'sh'
    :!time bash %

  elseif &filetype == 'python'
    belowright sp
    :term python3 %

  elseif &filetype == 'lua'
    belowright sp
    :term lua %

  elseif &filetype == 'html'
    silent! exec "!".g:mkdp_browser." % &"

  elseif &filetype == 'markdown'
    exec "MarkdownPreview"

  elseif &filetype == 'tex'
    silent! exec "VimtexStop"
    silent! exec "VimtexCompile"

  elseif &filetype == 'javascript'
    belowright sp
    :term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .

  elseif &filetype == 'dart'
    CocCommand flutter.run

  elseif &filetype == 'go'
    belowright sp
    :term go run .

  endif
endfunc

map <F9> :call CompileRunGcc()<CR>

" =============== ipython run ================
"noremap ,i :sp<CR><C-w>j:term ipython<CR> i %run
" --------------------------------------------
" Open up pudb, a python debug,(pip install --user pudb)
"noremap <c-d> :tab sp<CR>:term python3 -m pudb %<CR>
