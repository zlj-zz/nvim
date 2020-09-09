"
"    ██████╗  ██████╗  ██████╗ ██╗    ██╗██████╗ █████╗ ████╗
"   ██╔═══██╗██╔═══██╗██╔═══██╗██║    ██║  ██╔═╝██╔══███╔══██╗
"   ██║   ██║████████╝██║   ██║╚██╗  ██╔╝  ██║  ██║  ███║  ██║
"   ██║   ██║██║      ██║   ██║ ╚██ ██╔╝   ██╚═╗██║  ███║  ██║
"   ██║   ██║╚██████╗ ╚██████╔╝   ╚██╔╝  ██████║██║  ███║  ██║
"   ╚═╝   ╚═╝ ╚═════╝  ╚═════╝     ╚═╝   ╚═════╝╚═╝  ╚══╝  ╚═╝
"
"  _________________________________________
" / Here is my neovim configuration with    \
" | comments, remember to check befor using |
" | the configuration.                      |
" \                            --Zachary    /
"  -----------------------------------------
"          \   ,__,
"           \  (oo)____
"              (__)    )\
"                 ||--|| *
"
" === Auto load for first time uses
"let g:python_host_prog="/usr/bin/python2.7"
"let g:python3_host_prog="/usr/bin/python3.8"
if has(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:isWin = 1
else
    let g:isWin = 0
endif


let g:NHOME = join(split($MYVIMRC, '\')[:-2], '\')
exec 'source '.g:NHOME.'/config.vim'
exec 'source '.g:NHOME.'/keymap.vim'
exec 'source '.g:NHOME.'/environment.vim'
exec 'source '.g:NHOME.'/compile_run.vim'
exec 'source '.g:NHOME.'/custom_tool.vim'
autocmd FileType markdown exec 'source '.g:NHOME.'/my_extra/md-snippets.vim'

exec 'source '.g:NHOME.'/plugin_load.vim'
exec 'source '.g:NHOME.'/plugin_settings.vim'


" experimental
set lazyredraw

" === Necessary Commands to Execute
exec "nohlsearch"


" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
    exec "e ".g:NHOME."/_machine_specific.vim"
endif

