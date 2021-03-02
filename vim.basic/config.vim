" vim:set et sw=2 ts=2 fdm=marker fdl=1:
" ====================
" =                  =
" =    [config]      =
" =                  =
" ====================

" close vi compatibility mode
set nocompatible
if &t_Co > 1
  syntax enable
endif

" open file classic check
filetype on

" turn on auto-completion
filetype plugin indent on 

" 针对不同的文件类型采用不同的缩进格式
filetype indent on

" allow plugin
filetype plugin on

" turn on syntax highlight
set syntax=on

" enable true colors support
set termguicolors

" show line number
set number

"set ruler                " show ruler

" line number format
set relativenumber

" highlight current line
set cursorline

" set coding is utf-8
set encoding=utf-8
if g:isWin == 0 
  set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
endif
set termencoding=utf-8
set pyxversion=3
set autoread


set ts=4                 " Tab's width
set shiftwidth=4         " ident length
set softtabstop=4        " INSERT ident length
set expandtab            " tab replace black space
autocmd FileType vim,sh,html,css,js,vue,dart setlocal ts=2 softtabstop=2 shiftwidth=2

" auto wrap
set wrap

" bracket highlight
set showmatch

" bracket match highlight time(0.2s)
set matchtime=2

set wildmenu             " enable command-line completion in enhanced mode
set showcmd              " show input message
set ignorecase           " ignore case when you search
set hlsearch             " highlight search result
set mouse=a              " mouse set
set scrolloff=5          " reserve at least 5 lines when you scrol
set updatetime=300

" auto identation ===========
set autoindent
set cindent              " same ident with pre line, also can identify braces

" allow backspace to upper line or lower line-
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" code fold setting === za[one],zi[all]
set foldenable          " allow flod (help fold)
"set foldlevel=100       " does not automatically fold on startup
set foldmethod=manual   " option: [manual indent marker]
autocmd FileType python setlocal foldmethod=indent

" 设置空白字符的视觉提示
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:-

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
"set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

