"                          _
"    _ __   ___  _____   _(_)_ __ ___
"   | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
"   | | | |  __/ (_) \ V /| | | | | | |
"   |_| |_|\___|\___/ \_/ |_|_| |_| |_|
"
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
"let g:python_host_prog="/usr/bin/python2.7"
"let g:python3_host_prog="/usr/bin/python3.8"
let g:home_path = expand('<sfile>:p:h')
let g:if_use_coc = 1

" download plug manager file, if not have it
if empty(glob(g:home_path.'/plugged'))
  "silent !curl -fLo ${NHOME}/autoload/plug.vim --create-dirs
              "\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Create a '_machine_specific.vim' file to adjust machine specific stuff
" === like python interpreter location
let has_machine_specific_file = 1
if empty(glob(g:home_path.'/_machine_specific.vim'))
  let has_machine_specific_file = 0
  silent! exec "touch ".g:home_path."/_machine_specific.vim"
endif
execute 'source '.g:home_path.'/_machine_specific.vim'

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

let s:sourceList = [
  \ 'basic',
  \ 'plugin',
  \ 'customtools',
  \]

"" load basic config
for s:item in s:sourceList
  for s:sub_path in split(globpath(g:home_path . '/vim.' . s:item , '*.vim'), '\n')
    exec 'source ' . s:sub_path
  endfor
endfor

unlet s:sourceList

" experimental
set foldmethod=manual   " option: [manual indent marker]
set re=1
set ttyfast
set lazyredraw
exec "nohlsearch"

" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
    exec "e ".g:home_path."/_machine_specific.vim"
endif
unlet has_machine_specific_file


" create temp folder, create undo folder if have plugin persistent_undo
" path = ~/.tmp
if empty(glob($HOME.'/.tmp'))
  silent !mkdir -p $HOME/.tmp/backup
  silent !mkdir -p $HOME/.tmp/undo
  silent !mkdir -p $HOME/.tmp/sessions
endif
set backupdir=$HOME/.tmp/backup
set directory=$HOME/.tmp/backup
if has('persistent_undo')
  set undofile
  set undodir=$HOME/.tmp/undo
endif
