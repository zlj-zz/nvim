" vim:set et sw=2 ts=2 fdm=marker fdl=1:
"===============================================
"=                                             =
"=               plugin settings               =
"=                                             =
"===============================================
scriptencoding utf-8

let s:script_cwd = expand('<sfile>:p:h')

for s:plug_config in split(globpath(s:script_cwd . '/plugins.config', '*.vim'), '\n')
  if filereadable(s:plug_config)
    execute 'source ' . s:plug_config
  endif
endfor



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


"" \\\\\\
"" >>>>>>> tagbar 
"" //////
"nmap <F8> :TagbarToggle<CR>
"let g:tagbar_sort=0  " close auto sort
"let g:tagbar_width=30  " set window width
""let g:tagbar_autopreview = 1
"let g:tagbar_autofocus = 1
""autocmd BufReadPost *.py,*.cpp,*.c,*.java,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()  " where file auto open the window
"function! s:init_var(var, value) abort
    "if !exists('g:tagbar_' . a:var)
        "execute 'let g:tagbar_' . a:var . ' = ' . string(a:value)
    "endif
"endfunction
"function! s:setup_keymaps() abort
    "let keymaps = [
                "\ ['togglecaseinsensitive', ''],
                "\ ]
    "for [map, key] in keymaps
        "call s:init_var('map_' . map, key)
        "unlet key
    "endfor
"endfunction
"call s:setup_keymaps()


" \\\\\\
" >>>>>>> vim-autoformat 
" //////
"nnoremap \f :Autoformat<CR>
