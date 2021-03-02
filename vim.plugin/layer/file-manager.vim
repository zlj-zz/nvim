" File manager
Plug 'voldikss/vim-floaterm'
Plug 'mhinz/vim-startify' " enter navigation menu
Plug 'mbbill/undotree',{'on': 'UndotreeToggle'} " Undo Tree, to see history
"Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] } " Find & Replace
"Plug 'junegunn/vim-after-object' " da= to delete what's after =

if g:isWin == 0
    "Plug 'liuchengxu/vista.vim' " like tagbar
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'majutsushi/tagbar',{'on': 'TagbarToggle'}  " sudo pacman -S ctags,  Tagbar, easy read program, function bar
endif
