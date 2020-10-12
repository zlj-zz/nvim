" ====================
" =                  =
" =    [config]      =
" =                  =
" ====================
set nocompatible          " close vi compatibility mode
if &t_Co > 1
  syntax enable
endif
filetype on               " open file classic check
filetype plugin indent on " turn on auto-completion
"set completeopt=longest,menu
filetype indent on       " 针对不同的文件类型采用不同的缩进格式
filetype plugin on       " allow plugin

set termguicolors        " enable true colors support
set number               " show line number
"set ruler                " show ruler
set relativenumber       " line number format
set cursorline           " highlight current line
set syntax=on            " turn on syntax highlight

set encoding=utf-8       " set coding is utf-8
if g:isWin == 0 
    set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
endif
set termencoding=utf-8
set pyxversion=3
set autoread

set ts=4                 " Tab's width
set softtabstop=4        " INSERT ident length
set shiftwidth=4         " ident length
set expandtab            " tab replace black space
autocmd FileType html,css setlocal ts=2 softtabstop=2 shiftwidth=2

set wrap                 " auto wrap
set showmatch            " bracket highlight
set matchtime=2          " bracket match highlight time(0.2s)

set wildmenu             " enable command-line completion in enhanced mode
set ignorecase           " ignore case when you search
set hlsearch             " highlight search result
set showcmd              " show input message
set mouse=a              " mouse set
set scrolloff=5          " reserve at least 5 lines when you scrol
set updatetime=100

" auto identation ===========
set autoindent
set cindent              " same ident with pre line, also can identify braces

" allow backspace to upper line or lower line-
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" code fold setting === za[one],zi[all]
set foldenable          " allow flod (help fold)
"set foldlevel=100       " does not automatically fold on startup
set foldmethod=marker   " option: [manual indent marker]
autocmd FileType python setlocal foldmethod=indent

" 设置空白字符的视觉提示
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:-

