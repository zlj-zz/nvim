local g = vim.g

g.tagbar_sort = 0 -- close auto sort
g.tagbar_width = 30 -- set window width
-- g.tagbar_autopreview = 1
g.tagbar_autofocus = 1

-- autocmd bufreadpost *.py,*.cpp,*.c,*.java,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
-- where file auto open the window
vim.cmd([[

nmap ti :TagbarToggle<cr>

function! s:init_var(var, value) abort
  if !exists('g:tagbar_' . a:var)
    execute 'let g:tagbar_' . a:var . ' = ' . string(a:value)
  endif
endfunction

function! s:setup_keymaps() abort
  let keymaps = [
              \ ['togglecaseinsensitive', ''],
              \ ]
  for [map, key] in keymaps
    call s:init_var('map_' . map, key)
    unlet key
  endfor
endfunction

call s:setup_keymaps()

 ]])
