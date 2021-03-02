" File manager
Plug 'voldikss/vim-floaterm'
Plug 'mhinz/vim-startify' " enter navigation menu
Plug 'mbbill/undotree',{'on': 'UndotreeToggle'} " Undo Tree, to see history

if g:isWin == 0
    "Plug 'liuchengxu/vista.vim' " like tagbar
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'majutsushi/tagbar',{'on': 'TagbarToggle'}  " sudo pacman -S ctags,  Tagbar, easy read program, function bar
endif
