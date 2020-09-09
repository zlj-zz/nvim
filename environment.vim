" download plug manager file 
" if not have it
if empty(glob(g:NHOME.'/autoload/plug.vim'))
    silent !curl -fLo ${NHOME}/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" === Create a '_machine_specific.vim' file to adjust machine specific stuff
" === like python interpreter location
let has_machine_specific_file = 1
if empty(glob(g:NHOME.'/_machine_specific.vim'))
    let has_machine_specific_file = 0
    "silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
    silent! exec "touch ".g:NHOME."/_machine_specific.vim"
endif
execute 'source '.g:NHOME.'/_machine_specific.vim'


" === create temp folder
" === create undo folder if have plugin persistent_undo
if empty(glob(g:NHOME.'/tmp'))
  silent execute '!mkdir -p '.g:NHOME.'/tmp/backup'
  silent execute '!mkdir -p '.g:NHOME.'/tmp/undo'
  silent execute '!mkdir -p '.g:NHOME.'/tmp/sessions'
endif
set backupdir=g:NHOME.'/tmp/backup'
set directory=g:NHOME.'/tmp/backup'
if has('persistent_undo')
   set undofile
   set undodir=g:NHOME.'/tmp/undo'
endif
