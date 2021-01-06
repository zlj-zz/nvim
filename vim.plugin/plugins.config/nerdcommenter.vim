" vim:set et sw=2 ts=2 fdm=marker fdl=1:

" \\\\\\
" >>>>>>> nerdcommenter 
" //////
let g:NERDDefaultAlign = 'none'
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = {'python': {'left': '# ', 'leftAlt': '""" ', 'rightAlt': ' """'}}
nmap <leader>/ <Plug>NERDCommenterToggle
xmap <leader>/ <Plug>NERDCommenterToggle
