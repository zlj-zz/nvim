local g = vim.g

local utils = require('utils')
local map = utils.map

if g.isWin == 0 then
    vim.cmd([[
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
    ]])

    map('n', ',d', ':BufferDel<cr>')
    map('n', ',f', ':Ag<cr>')
    map('n', ',h', ':History<cr>')
    map('n', ',b', ':Buffers<cr>')
    map('n', ',l', ':Lines<cr>')
    map('n', ',c', ':History:<cr>')
    map('n', ',k', ':Maps<cr>')

end

