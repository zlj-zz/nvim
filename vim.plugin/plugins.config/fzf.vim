" vim:set et sw=2 ts=2 fdm=marker fdl=1:

if g:isWin == 0
  " \\\\\\             (sudo pacman -S fzf)
  " >>>>>>> fzf.vim 
  " //////
  function! s:list_buffers()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
  endfunction

  function! s:delete_buffers(lines)
    execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
  endfunction

  command! BufferDel call fzf#run(fzf#wrap({
    \ 'source': s:list_buffers(),
    \ 'sink*': { lines -> s:delete_buffers(lines) },
    \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
  \ }))

  noremap ,d :BufferDel<cr>

  noremap ,f :Ag<CR>
  noremap ,h :History<cr>
  noremap ,b :Buffers<cr>
  noremap ,l :Lines<cr>
  noremap ,c :History:<cr>
  noremap \k :Maps<cr>
endif

