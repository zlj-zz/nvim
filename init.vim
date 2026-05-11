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

" load nvim base setting.
lua require('settings')()

" load plugins.
lua require('plugin')
" lazy.nvim commands (optional convenience aliases)
"command! LazySync lua require('lazy').sync()
"command! LazyUpdate lua require('lazy').update()
"command! LazyInstall lua require('lazy').install()
"command! LazyClean lua require('lazy').clean()
"command! LazyProfile lua require('lazy').profile()

" load auto groups.
lua require('autocmds')

" experimental
set lazyredraw
exec "nohlsearch"


if has('persistent_undo')
  set undofile
  set undodir=$HOME/.tmp/undo
endif
