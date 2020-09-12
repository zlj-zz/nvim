"===========================
"=                         =
"=      plugin             =
"=                         =
"===========================
call plug#begin(g:NHOME.'/plugged')
Plug 'KabbAmine/vCoolor.vim'
" Pretty Dress
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'bling/vim-bufferline'
"Plug 'mg979/vim-xtabline'     " top tabline
"" === color theme ===
Plug 'ajmwagar/vim-deus'
" === Dress up my vim
set termguicolors   " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme deus
"let ayucolor="light"
"set background=light
"set background=dark
" hi Normal ctermfg=252 ctermbg=none guibg=none  " let bg transparent

" File manager
Plug 'voldikss/vim-floaterm'
"let g:floaterm_keymap_toggle = 'F4'
map <c-\> :FloatermToggle<cr>
let g:floaterm_gitcommit = 'split'
Plug 'mhinz/vim-startify' " enter navigation menu
Plug 'scrooloose/nerdtree',{'on': 'NERDTreeToggle'} " NerdTree, files tree to manage file
Plug 'mbbill/undotree',{'on': 'UndotreeToggle'} " Undo Tree, to see history
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] } " Find & Replace
" Editor Enhancement
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine' " show indentation line
Plug 'RRethy/vim-illuminate'   " illuminating the other uses of the current word under the cursor
Plug 'jaxbot/semantic-highlight.vim' " where every variable is a different color
Plug 'scrooloose/nerdcommenter'  " in <leader>cn to comment a line, <leader>cu to uncomment
Plug 'Chiel92/vim-autoformat',{'on': 'Autoformat'}
Plug 'jiangmiao/auto-pairs'
Plug 'Konfekt/FastFold'
"Plug 'AndrewRadev/splitjoin.vim'
"Plug 'mg979/vim-visual-multi'
" Snippets
Plug 'SirVer/ultisnips' " Track the engine.
Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:
" Auto Complete Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " install [npm] [yarn]
Plug 'wellle/tmux-complete.vim'
" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
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
" Dart && Flutter
Plug 'tiagofumo/dart-vim-flutter-layout' " code indent
Plug 'dart-lang/dart-vim-plugin'
Plug 'f-person/pubspec-assist-nvim', { 'for' : ['pubspec.yaml']  }

let g:dart_style_guide = 2
let g:dart_format_on_save = 1
let g:dartfmt_options = ["-l 100"]
" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }
" Dependencies
Plug 'kana/vim-textobj-user'
Plug 'junegunn/goyo.vim',{'on': 'Goyo'} " For general writing-工作无忧

if g:isWin == 0
    Plug 'https://github.com/vim-scripts/fcitx.vim.git'  " let you can use fcitx in vim
    Plug 'majutsushi/tagbar',{'on': 'TagbarToggle'}  " sudo pacman -S ctags " Tagbar, easy read program, function bar
    Plug 'ryanoasis/vim-devicons' " add icon to vim plug
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    Plug 'junegunn/fzf.vim',{'on': 'FZF'} " File navigation

    "Plug 'roxma/nvim-yarp' " a other vim plugin manager

    "Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
    "Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
    "Plug 'junegunn/vim-after-object' " da= to delete what's after =
    "Plug 'junegunn/vim-easy-align' " ga= to align the = in paragraph,
    "Plug 'wincent/terminus'

    "" Markdown
    "Plug 'theniceboy/bullets.vim'
endif

call plug#end()
