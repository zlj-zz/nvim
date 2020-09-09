"===========================
"=                         =
"=      plugin             =
"=                         =
"===========================
call plug#begin(g:NHOME.'/plugged')
"Plug 'https://github.com/vim-scripts/fcitx.vim.git'  " let you can use fcitx in vim
"Plug 'RRethy/vim-illuminate'   " illuminating the other uses of the current word under the cursor
"Plug 'AndrewRadev/splitjoin.vim'
Plug 'KabbAmine/vCoolor.vim'
" Pretty Dress
"Plug 'theniceboy/eleline.vim'
Plug 'bling/vim-bufferline'
Plug 'mg979/vim-xtabline'     " top tabline
"" === color theme ===
Plug 'ajmwagar/vim-deus'
" === Dress up my vim
set termguicolors   " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme deus
"let ayucolor="light"
"color ayu
"set background=light
"set background=dark
" hi Normal ctermfg=252 ctermbg=none guibg=none  " let bg transparent

" File manager
Plug 'mhinz/vim-startify' " enter navigation menu
Plug 'scrooloose/nerdtree',{'on': 'NERDTreeToggle'} " NerdTree, files tree to manage file
Plug 'mbbill/undotree',{'on': 'UndotreeToggle'} " Undo Tree, to see history
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] } " Find & Replace
" Editor Enhancement
Plug 'Chiel92/vim-autoformat',{'on': 'Autoformat'}
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine' " show indentation line
Plug 'jaxbot/semantic-highlight.vim' " where every variable is a different color
Plug 'scrooloose/nerdcommenter'  " in <leader>cn to comment a line, <leader>cu to uncomment
Plug 'jiangmiao/auto-pairs'
Plug 'Konfekt/FastFold'
" Snippets
Plug 'SirVer/ultisnips' " Track the engine.
Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:
" Auto Complete Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " install [npm] [yarn]
Plug 'wellle/tmux-complete.vim'
" HTML, CSS, JavaScript, PHP, JSON, etc.
"Plug 'elzr/vim-json'
"Plug 'hail2u/vim-css3-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"Plug 'pangloss/vim-javascript', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"Plug 'jelera/vim-javascript-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Python
Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim'
" Go
"Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }
" Markdown
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
" Dependencies
Plug 'kana/vim-textobj-user'
Plug 'junegunn/goyo.vim',{'on': 'Goyo'} " For general writing-工作无忧


if g:isWin == 0
    Plug 'majutsushi/tagbar',{'on': 'TagbarToggle'}  " sudo pacman -S ctags " Tagbar, easy read program, function bar
    Plug 'ryanoasis/vim-devicons' " add icon to vim plug
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    Plug 'junegunn/fzf.vim',{'on': 'FZF'} " File navigation

    "Plug 'tiagofumo/dart-vim-flutter-layout' " code indent
    "Plug 'mg979/vim-visual-multi'
    "Plug 'roxma/nvim-yarp'

    "Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
    "Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
    "Plug 'junegunn/vim-after-object' " da= to delete what's after =
    "Plug 'wincent/terminus'
    "Plug 'junegunn/vim-easy-align' " ga= to align the = in paragraph,

    "" Markdown
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
    Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }
    "Plug 'theniceboy/bullets.vim'
endif

call plug#end()
