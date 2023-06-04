scriptencoding utf-8

" AUTOCMD: Autocmd groups  {{{
  augroup ZACHARY_GROUP " {{{
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    " In addition open folds till the cursor is visible
    autocmd BufReadPost *
          \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
          \   execute "normal g`\"" |
          \   execute "normal zv" |
          \ endif

    " Disable linting and syntax highlighting for large files
    autocmd BufReadPre *
                \   if getfsize(expand("%")) > 10000000 |
                \   syntax off |
                \   let g:ale_enabled=0 |
                \   let g:coc_enabled=0 |
                \   endif

    " http://vim.wikia.com/wiki/Speed_up_Syntax_Highlighting
    autocmd Syntax * if 2000 < line('$') | syntax sync maxlines=200 | endif

    " Automatically remove fugitive buffers
    "autocmd BufReadPost fugitive://* set bufhidden=delete

    " Update filetype on save if empty
    autocmd BufWritePost * nested
      \ if &l:filetype ==# '' || exists('b:ftdetect')
      \ |   unlet! b:ftdetect
      \ |   filetype detect
      \ | endif

    " Auto change directory to the directory where the current file is located.
    "autocmd BufEnter * silent! lcd %:p:h

    " Auto disenble highlight cursorline in insert mode.
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline
  augroup END " }}}

" }}}

" vim: foldmethod=marker:sw=2:foldlevel=10
