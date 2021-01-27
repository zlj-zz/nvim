" \\\\\\
" >>>>>>> vim-after-object 
" //////
"autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')


"" \\\\\\
"" >>>>>>> nerdtree 
"" //////
"map <F7> :NERDTreeToggle<CR>
"let NERDTreeIgnore = ['\.pyc$']
"let NERDTreeShowBookmarks=1
"function! s:initVariable(var, value)
    "if !exists(a:var)
        "exec 'let ' . a:var . ' = ' . "'" . substitute(a:value, "'", "''", "g") . "'"
        "return 1
    "endif
    "return 0
"endfunction
"call s:initVariable("g:NERDTreeMapOpenSplit", "h")


"" \\\\\\
"" >>>>>>> xtabline 
"" //////
"let g:xtabline_settings = {}
"let g:xtabline_settings.enable_mappings = 0
"let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
"let g:xtabline_settings.enable_persistance = 0
"let g:xtabline_settings.last_open_first = 1
"noremap \p :XTabInfo<CR>


" \\\\\\
" >>>>>>> vim-autoformat 
" //////
"nnoremap \f :Autoformat<CR>
