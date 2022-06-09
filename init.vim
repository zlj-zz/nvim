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



" Load enviroment.
lua require('env')

" Create a '_machine_specific.vim' file to adjust machine specific stuff
" :: like python interpreter location
let has_machine_specific_file = 1
if empty(glob(g:home_path.'/_machine_specific.vim'))
  let has_machine_specific_file = 0
  silent! exec "touch " . g:home_path . "/_machine_specific.vim"
else
  " Some special configurations for different computers.
  execute 'source '.g:home_path.'/_machine_specific.vim'
endif

" load nvim base setting.
lua require('settings')()

" load plugins.
"lua require('plugin')
command! PackerInstall packadd packer.nvim | lua require('plugin').install()
command! PackerUpdate packadd packer.nvim | lua require('plugin').update()
command! PackerSync packadd packer.nvim | lua require('plugin').sync()
command! PackerClean packadd packer.nvim | lua require('plugin').clean()
command! PackerCompile packadd packer.nvim | lua require('plugin').compile()

let s:sourceList = [
  \ 'plugin',
  \ 'customtools',
  \]

"" load all config module.
for s:item in s:sourceList
  for s:sub_path in split(globpath(g:home_path . '/vim.' . s:item , '*.vim'), '\n')
    exec 'source ' . s:sub_path
  endfor
endfor

unlet s:sourceList

" load auto groups.
exec 'source ' . g:home_path . '/augroups.vim'

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
" path = `~/.tmp`
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
