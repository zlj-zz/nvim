" === color theme ===
"Plug 'ajmwagar/vim-deus'
"Plug 'sainnhe/sonokai'
Plug 'arcticicestudio/nord-vim'

"Plug 'sts10/vim-pink-moon'
"Plug 'morhetz/gruvbox'
" Pretty Dress
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if g:isWin == 0
    if filereadable('/usr/bin/fcitx')
        Plug 'vim-scripts/fcitx.vim'  " let you can use fcitx in vim
    endif

    Plug 'ryanoasis/vim-devicons' " add icon to vim plug
endif
