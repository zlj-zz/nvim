"" \\\\\\
"" >>>>>>> vim-startity 
"" //////
let g:ascii = [
    \'',
    \' ██████   █████ ██████████    ███████    █████   █████ █████ ██████   ██████',
    \'▒▒██████ ▒▒███ ▒▒███▒▒▒▒▒█  ███▒▒▒▒▒███ ▒▒███   ▒▒███ ▒▒███ ▒▒██████ ██████ ',
    \' ▒███▒███ ▒███  ▒███  █ ▒  ███     ▒▒███ ▒███    ▒███  ▒███  ▒███▒█████▒███ ',
    \' ▒███▒▒███▒███  ▒██████   ▒███      ▒███ ▒███    ▒███  ▒███  ▒███▒▒███ ▒███ ',
    \' ▒███ ▒▒██████  ▒███▒▒█   ▒███      ▒███ ▒▒███   ███   ▒███  ▒███ ▒▒▒  ▒███ ',
    \' ▒███  ▒▒█████  ▒███ ▒   █▒▒███     ██    ▒▒▒█████▒    ▒███  ▒███      ▒███  ',
    \' █████  ▒▒█████ ██████████ ▒▒▒███████▒      ▒▒███      █████ █████     █████',
    \'▒▒▒▒▒    ▒▒▒▒▒ ▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒         ▒▒▒      ▒▒▒▒▒ ▒▒▒▒▒     ▒▒▒▒▒ ',
    \ ''
    \]
let g:startify_custom_header = startify#center(g:ascii)
let g:startify_files_number = 20
let g:startify_lists = [
    \ { 'type': 'files',     'header': ['   MRU']            },
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ ]
noremap <F5> :tabe<cr>:Startify<cr>
