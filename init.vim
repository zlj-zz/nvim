"
"    ██████╗  ██████╗  ██████╗ ██╗    ██╗██████╗ █████╗ ████╗
"   ██╔═══██╗██╔═══██╗██╔═══██╗██║    ██║  ██╔═╝██╔══███╔══██╗
"   ██║   ██║████████╝██║   ██║╚██╗  ██╔╝  ██║  ██║  ███║  ██║
"   ██║   ██║██║      ██║   ██║ ╚██ ██╔╝   ██╚═╗██║  ███║  ██║
"   ██║   ██║╚██████╗ ╚██████╔╝   ╚██╔╝  ██████║██║  ███║  ██║
"   ╚═╝   ╚═╝ ╚═════╝  ╚═════╝     ╚═╝   ╚═════╝╚═╝  ╚══╝  ╚═╝
"
"  __________________________________________
" / Here is my neovim configuration with     \
" | comments, remember to check before using |
" | the configuration.                       |
" \                            --Zachary     /
"  ------------------------------------------
"          \   ,__,
"           \  (oo)____
"              (__)    )\
"                 ||--|| *
"
" === Auto load for first time uses
"let g:python_host_prog="/usr/bin/python2.7"
"let g:python3_host_prog="/usr/bin/python3.8"
if (has("win32") || has("win64") || has("win95") || has("win16"))
    let g:isWin = 1
else
    let g:isWin = 0
endif

if has("gui_running")
    let g:isGUI = 1
    let g:NHOME = join(split($MYVIMRC, '\')[:-2], '\').'/nvim'
else
    let g:isGUI = 0
    if (isWin)
        let g:NHOME = join(split($MYVIMRC, '\')[:-2], '\')
    else
        let g:NHOME = '/'.join(split($MYVIMRC, '/')[:-2], '/')
    endif
endif


" load basic config
for _path in split(globpath(g:NHOME.'/vim.config', '*'), '\n')
    exec 'source '._path
endfor
" load plugin config
for _path in split(globpath(g:NHOME.'/plugin.config', '*'), '\n')
    exec 'source '._path
endfor
" load my tool or plugin
for _path in split(globpath(g:NHOME.'/customtools', '*'), '\n')
    exec 'source '._path
endfor
"autocmd FileType markdown exec 'source '.g:NHOME.'/md-snippets.vim'

" hi Normal ctermfg=252 ctermbg=none guibg=none  " let bg transparent


" experimental
set lazyredraw

" === Necessary Commands to Execute
exec "nohlsearch"


" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
    exec "e ".g:NHOME."/_machine_specific.vim"
endif

