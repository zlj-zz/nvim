"===========================
"=                         =
"=      plugin             =
"=                         =
"===========================
call plug#begin(g:NHOME.'/plugged')
Plug 'KabbAmine/vCoolor.vim'
" === color theme ===
Plug 'ajmwagar/vim-deus'
" Pretty Dress
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" File manager
Plug 'voldikss/vim-floaterm'
Plug 'mhinz/vim-startify' " enter navigation menu
Plug 'mbbill/undotree',{'on': 'UndotreeToggle'} " Undo Tree, to see history
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] } " Find & Replace
" Editor Enhancement
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine' " show indentation line
Plug 'jaxbot/semantic-highlight.vim' " where every variable is a different color
Plug 'RRethy/vim-illuminate'   " illuminating the other uses of the current word under the cursor
" Editor Tools
Plug 'Konfekt/FastFold'
Plug 'junegunn/vim-easy-align' " ga= to align the = in paragraph,
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
Plug 'scrooloose/nerdcommenter'  " in <leader>cn to comment a line, <leader>cu to uncomment
"Plug 'AndrewRadev/splitjoin.vim'
" Snippets
"Plug 'SirVer/ultisnips' " Track the engine.
Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:
" Auto Complete Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " install [npm] [yarn]
Plug 'wellle/tmux-complete.vim'
" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'pangloss/vim-javascript', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'jelera/vim-javascript-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Python
Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim'
" Go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }
" Dart && Flutter
Plug 'tiagofumo/dart-vim-flutter-layout' " code indent
Plug 'dart-lang/dart-vim-plugin'
Plug 'f-person/pubspec-assist-nvim', { 'for' : ['pubspec.yaml']  }
" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }
Plug 'theniceboy/bullets.vim'
" Dependencies
Plug 'kana/vim-textobj-user'
" Other
Plug 'junegunn/goyo.vim',{'on': 'Goyo'} " For general writing-工作无忧

if g:isWin == 0
    if filereadable('/usr/bin/fcitx')
        Plug 'vim-scripts/fcitx.vim'  " let you can use fcitx in vim
    endif

    Plug 'ryanoasis/vim-devicons' " add icon to vim plug
    Plug 'liuchengxu/vista.vim' " like tagbar
    "Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    "Plug 'junegunn/vim-after-object' " da= to delete what's after =
endif
call plug#end()


"Plug 'bling/vim-bufferline'
"Plug 'mg979/vim-xtabline'     " top tabline
"Plug 'scrooloose/nerdtree',{'on': 'NERDTreeToggle'} " NerdTree, files tree to manage file
"Plug 'majutsushi/tagbar',{'on': 'TagbarToggle'}  " sudo pacman -S ctags,  Tagbar, easy read program, function bar
"Plug 'roxma/nvim-yarp' " a other vim plugin manager
"Plug 'Chiel92/vim-autoformat',{'on': 'Autoformat'}
"Plug 'wincent/terminus'
