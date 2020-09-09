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
if g:isWin == 0
    let g:bg_transflag=0
    let g:bg_flag = 1
    func! ChangeGuibg() " transparent background toggle
        if g:bg_flag == 1
            exec "hi normal guibg=none"
            let g:bg_flag = 0
        else
            exec "hi normal guibg=#242a32"
            let g:bg_flag = 1
        endif
    endfunc
    map cbg :call ChangeGuibg()<CR>
endif

Plug 'mhinz/vim-startify' " enter navigation menu
Plug 'scrooloose/nerdtree',{'on': 'NERDTreeToggle'} " NerdTree, files tree to manage file
Plug 'mbbill/undotree',{'on': 'UndotreeToggle'} " Undo Tree, to see history
"" Editor Enhancement
Plug 'Chiel92/vim-autoformat',{'on': 'Autoformat'}
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine' " show indentation line
Plug 'jaxbot/semantic-highlight.vim' " where every variable is a different color
Plug 'scrooloose/nerdcommenter'  " in <leader>cn to comment a line, <leader>cu to uncomment
Plug 'jiangmiao/auto-pairs'
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
" Snippets
Plug 'SirVer/ultisnips' " Track the engine.
Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:


if g:isWin == 0
    Plug 'majutsushi/tagbar',{'on': 'TagbarToggle'}  " sudo pacman -S ctags " Tagbar, easy read program, function bar
    Plug 'ryanoasis/vim-devicons' " add icon to vim plug
    "Plug 'tiagofumo/dart-vim-flutter-layout' " code indent

    "Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    "Plug 'junegunn/fzf.vim',{'on': 'FZF'} " File navigation

    ""Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] } " Find & Replace
    "Plug 'junegunn/goyo.vim',{'on': 'Goyo'} " For general writing-工作无忧

    "Plug 'mg979/vim-visual-multi'

    "" Auto Complete Coc
    ""Plug 'neoclide/coc.nvim', {'branch': 'release'}  " install [npm] [yarn]
    "Plug 'wellle/tmux-complete.vim'

    "" Go
    ""Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }

    "Plug 'scrooloose/nerdcommenter' " in <space>cn to comment a line;<space>cu to uncomment a line
    "Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
    "Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
    "Plug 'junegunn/vim-after-object' " da= to delete what's after =
    "Plug 'tpope/vim-capslock'   " Ctrl+L (insert) to toggle capslock
    "Plug 'Konfekt/FastFold'
    "Plug 'wincent/terminus'
    "" Dependencies
    "Plug 'MarcWeber/vim-addon-mw-utils'
    "Plug 'kana/vim-textobj-user'
    "Plug 'roxma/nvim-yarp'

    "" Markdown
    "Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
    "Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
    "Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }
    "Plug 'theniceboy/bullets.vim'



endif
call plug#end()
