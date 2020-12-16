"" \\\\\\
"" >>>>>>> vim-startity 
"" //////
let g:ascii = [
      \ '           __',
      \ '   .--.--.|__|.--------.',
      \ '   |  |  ||  ||        |',
      \ '    \___/ |__||__|__|__|',
      \ ''
      \]
let g:startify_custom_header = g:ascii
let g:startify_files_number = 20
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ ]
noremap <F5> :tabe<cr>:Startify<cr>
