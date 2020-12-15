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
else
    let g:isGUI = 0
endif

let g:home_path = expand('<sfile>:p:h')

let s:sourceList = [
      \ 'basic',
      \ 'plugin',
      \ 'customtools',
      \]

"" load basic config
for s:item in s:sourceList
  "exec 'source ' . s:script_path . '/viml/' . s:item . '.vim'
  for s:sub_path in split(globpath(g:home_path . '/' . s:item . '.config', '*'), '\n')
    exec 'source ' . s:sub_path
  endfor
endfor

"autocmd FileType markdown exec 'source '.g:NHOME.'/md-snippets.vim'

" experimental
set lazyredraw

" === Necessary Commands to Execute
exec "nohlsearch"


" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
    exec "e ".g:home_path."/_machine_specific.vim"
endif

