" download plug manager file 
" if not have it
"if empty(glob(g:NHOME.'/autoload/plug.vim'))
"    silent !curl -fLo ${NHOME}/autoload/plug.vim --create-dirs
"                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif
if empty(glob(g:home_path.'/plugged'))
    "silent !curl -fLo ${NHOME}/autoload/plug.vim --create-dirs
                "\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" === Create a '_machine_specific.vim' file to adjust machine specific stuff
" === like python interpreter location
let has_machine_specific_file = 1
if empty(glob(g:home_path.'/_machine_specific.vim'))
    let has_machine_specific_file = 0
    "silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
    silent! exec "touch ".g:home_path."/_machine_specific.vim"
endif
execute 'source '.g:home_path.'/_machine_specific.vim'


" === create temp folder
" === create undo folder if have plugin persistent_undo
" === path = ~/.tmp
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
