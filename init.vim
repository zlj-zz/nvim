"
"    ██████╗  ██████╗  ██████╗ ██╗    ██╗██████╗ █████╗ ████╗
"   ██╔═══██╗██╔═══██╗██╔═══██╗██║    ██║  ██╔═╝██╔══███╔══██╗
"   ██║   ██║████████╝██║   ██║╚██╗  ██╔╝  ██║  ██║  ███║  ██║
"   ██║   ██║██║      ██║   ██║ ╚██ ██╔╝   ██╚═╗██║  ███║  ██║
"   ██║   ██║╚██████╗ ╚██████╔╝   ╚██╔╝  ██████║██║  ███║  ██║
"   ╚═╝   ╚═╝ ╚═════╝  ╚═════╝     ╚═╝   ╚═════╝╚═╝  ╚══╝  ╚═╝
"
"  _________________________________________
" / Here is my neovim configuration with    \
" | comments, remember to check befor using |
" | the configuration.                      |
" \                            --Zachary    /
"  -----------------------------------------
"          \   ,__,
"           \  (oo)____
"              (__)    )\
"                 ||--|| *
"
" === Auto load for first time uses
" ==={{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

" === Create a '_machine_specific.vim' file to adjust machine specific stuff, like python interpreter location
" ==={{{
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
    let has_machine_specific_file = 0
    silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim
" }}}

" === basic Set =============================={{{

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

set number               " show line number
"set ruler                " show ruler
set relativenumber       " line number format
set cursorline           " highlight current line
set syntax=on            " turn on syntax highlight

set encoding=utf-8       " set coding is utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set pyxversion=3
set autoread

set ts=2                 " Tab's width
set softtabstop=2        " INSERT ident length
set shiftwidth=2         " ident length
set expandtab            " tab replace black space
autocmd FileType python,markdown setlocal ts=4 softtabstop=4 shiftwidth=4

set wrap                 " auto wrap
set showmatch            " bracket highlight
set matchtime=2          " bracket match highlight time(0.2s)

set wildmenu             " enable command-line completion in enhanced mode
set ignorecase           " ignore case when you search
set hlsearch             " highlight search result
set showcmd              " show input message
set mouse=a              " mouse set
set scrolloff=5          " reserve at least 5 lines when you scrol

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

" 设置空白字符的视觉提示
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:▫
" --------------------------------------------}}}

" === KEY MAP ================================{{{
" set leader is <space>
let mapleader=" "
"map <LEADER>    :retab!<CR>

" ==========================
" =                        =
" =     file option        =
" =                        =
" ==========================
" save
map S :w<CR>
" quit
map Q :q<CR>
" force exit without saving
map <c-q> :q!<CR>
" make Y to copy till the end of the line
nnoremap Y y$
" Copy to system clipboard
vnoremap <c-c> "+y
" Indentation
nnoremap < <<
nnoremap > >>
" select all
map <c-a> ggVG


"===========================
"=                         =
"=     cursor movement     =
"=                         =
"===========================
"     ^
"     k
" < h   l >
"     j
"     v
"  faster navigation
noremap <silent> K 5k
noremap <silent> J 5j
noremap <silent> H 5h
noremap <silent> L 5l
" Ctrl + K or J will move up/down the view port without moving the cursor
nnoremap <C-k> 5<C-y>
nnoremap <C-j> 5<C-e>
" Insert and Command Mode Cursor Movement
noremap! <m-a> <Home>
noremap! <m-s> <End>
noremap! <m-k> <Up>
noremap! <m-j> <Down>
noremap! <m-h> <Left>
noremap! <m-l> <Right>
"noremap! <M-j> <S-Left>
"noremap! <M-l> <S-Right>
" jump to sentence tail
noremap 4 $
noremap 6 ^
noremap ; :


"===========================
"=                         =
"=   window management     =
"=                         =
"===========================
" Disable the default s key
map s <nop>
" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
map sk :set nosplitbelow<CR>:split<CR>:e
map sj :set splitbelow<CR>:split<CR>:e
map sh :set nosplitright<CR>:vsplit<CR>:e
map sl :set splitright<CR>:vsplit<CR>:e
" Disable the default t key
noremap t <nop>
" Use t + arrow keys for moving the cursor around windows
noremap tl <C-w>l
noremap tk <C-w>k
noremap tj <C-w>j
noremap th <C-w>h
" Resize splits with arrow keys
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>
" Disable the default c key
"map c <nop>
" Place the two screens up and down
noremap ch <C-w>t<C-w>K
" Place the two screens side by side
noremap cv <C-w>t<C-w>H


"===========================
"=                         =
"=    tabe management      =
"=                         =
"===========================
" new tab, 'w' filepath_and_name
map <c-t> :tabe<CR>
" before tab
map t- :-tabnext<CR>
" next tab
map t= :+tabnext<CR>
" before buffer
map b- :bp<CR>
" next buffer
map b= :bn<CR>


"===========================
"=                         =
"=      other              =
"=                         =
"===========================
" cancel the highlight search
nnoremap <LEADER><CR> :nohlsearch<CR>
" Open the vimrc file anytime
nnoremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>
" resource neovim config
map rc :source $MYVIMRC<CR>
" Opening a terminal window
nnoremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>
tnoremap <C-N> <C-\><C-N>
" find two same word
nmap <LEADER>fd /\(\<\w\+\>\)\_s*\1
" Press space twice to jump to the next ':' and edit it
nnoremap <LEADER><LEADER> <ESC>/<++><CR>:nohlsearch<CR>c4l
" Spelling Check with <space>sc
nnoremap <LEADER>sc :set spell!<CR>
"  paste mode
nnoremap <leader>pm :set paste!<cr>

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h
" --------------------------------------------}}}

" when you open file, back to last edit position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" === set temp directory ===================={{{
if empty(glob('~/.config/nvim/tmp'))
  silent !mkdir -p ~/.config/nvim/tmp/backup
  silent !mkdir -p ~/.config/nvim/tmp/undo
  silent !mkdir -p ~/.config/nvim/tmp/sessions
endif
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
   set undofile
   set undodir=~/.config/nvim/tmp/undo,.
endif
" --------------------------------------------}}}


" =============== ipython run ================
"noremap ,i :sp<CR><C-w>j:term ipython<CR> i %run
" --------------------------------------------
" Open up pudb, a python debug,(pip install --user pudb)
"noremap <c-d> :tab sp<CR>:term python3 -m pudb %<CR>

"let g:python_host_prog="/usr/bin/python2.7"
"let g:python3_host_prog="/usr/bin/python3.8"


" === my extra ==============================={{{
source ~/.config/nvim/my_extra/compile_run.vim
map <F9> :call CompileRunGcc()<CR>

"autocmd BufNewFile * call SetTitle()
augroup fileTitle
  autocmd FileType c,cpp,python,java,sh source ~/.config/nvim/my_extra/file-processing.vim
  nmap tit :call SetTitle()<CR>
  nmap upd :call SetLastModifiedTime(-1)<CR>
augroup END
" -------------------------------------------}}}

" === Widgets ================================{{{
call plug#begin('~/.config/nvim/plugged')
"call plug#begin()
Plug 'tiagofumo/dart-vim-flutter-layout' " code indent
" ===
" === vim-illuminate
Plug 'RRethy/vim-illuminate'   " illuminating the other uses of the current word under the cursor
let g:Illuminate_delay = 750
Plug 'AndrewRadev/splitjoin.vim'
Plug 'KabbAmine/vCoolor.vim'
"Plug 'pechocrin/any-jump.vim'

" Pretty Dress
Plug 'theniceboy/eleline.vim'
" === eleline.vim
let g:airline_powerline_fonts = 0

Plug 'bling/vim-bufferline'

Plug 'skywind3000/vim-keysound', {'on': 'KeysoundEnable'}
let g:keysound_enable = 0
" options [default, typewriter, mario, bubble, sword]
let g:keysound_theme = 'default' 
let g:keysound_volume = 1000
let g:keysound_py_version = 3




" ======= color theme {{{
"Plug 'liuchengxu/space-vim-theme'
"Plug 'ayu-theme/ayu-vim'
"Plug 'rakr/vim-one'
Plug 'ajmwagar/vim-deus'
"Plug 'arzg/vim-colors-xcode'
"Plug 'altercation/vim-colors-solarized'
"Plug 'morhetz/gruvbox'
set t_Co=256  " open 256 color suppor
" ===
" === Dress up my vim
set termguicolors   " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"let ayucolor="mirage"
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"let g:one_allow_italics = 1
"color dracula
"color one
colorscheme deus
"color gruvbox
"let ayucolor="light"
"color ayu
"set background=light
"set background=dark
"color xcodedark
" hi Normal ctermfg=252 ctermbg=none guibg=none  " let bg transparent
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


" let you can use fcitx in vim
Plug 'https://github.com/vim-scripts/fcitx.vim.git'
" }}}

" +++Sidebar++++++++++++++++++++++++++++++++++{{{


Plug 'mhinz/vim-startify'
nmap <F5> <c-t>:Startify<cr>
let g:ascii = [
      \ '           __',
      \ '   .--.--.|__|.--------.',
      \ '   |  |  ||  ||        |',
      \ '    \___/ |__||__|__|__|',
      \ ''
      \]
let g:startify_custom_header = g:ascii
let g:startify_files_number = 15
if empty(glob('~/.config/nvim/tmp/demo/'))
    silent! exec "!mkdir ~/.config/nvim/tmp/demo"
    silent! exec "!touch ~/.config/nvim/tmp/demo/tmp.{c,py,java,js,html,css,sh}"
endif
function s:temporaryMenu()
  return [
        \ { 'line': 'c', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.c' },
        \ { 'line': 'py', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.py' },
        \ { 'line': 'java', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.java' },
        \ { 'line': 'js', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.js' },
        \ { 'line': 'html', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.html' },
        \ { 'line': 'css', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.css' },
        \ { 'line': 'bash', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.sh' },
        \ ]
endfunction
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': function('s:temporaryMenu'),  'header': ['   Temporary'] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ ]

" NerdTree, files tree to manage file
Plug 'scrooloose/nerdtree',{'on': 'NERDTreeToggle'}
" Tagbar, easy read program, function bar
Plug 'majutsushi/tagbar',{'on': 'TagbarToggle'}  " sudo pacman -S ctags
" Undo Tree, to see history
Plug 'mbbill/undotree',{'on': 'UndotreeToggle'}
" ===
" === Undotree
noremap <F6> :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeNextState
    nmap <buffer> j <plug>UndotreePreviousState
    nmap <buffer> K 5<plug>UndotreeNextState
    nmap <buffer> J 5<plug>UndotreePreviousState
endfunc
"===
"=== NERDTree
map <F7> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeShowBookmarks=1
function! s:initVariable(var, value)
    if !exists(a:var)
        exec 'let ' . a:var . ' = ' . "'" . substitute(a:value, "'", "''", "g") . "'"
        return 1
    endif
    return 0
endfunction
call s:initVariable("g:NERDTreeMapOpenSplit", "h")
"===
"=== Tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_sort=0  " close auto sort
let g:tagbar_width=30  " set window width
"let g:tagbar_autopreview = 1
let g:tagbar_autofocus = 1
"autocmd BufReadPost *.py,*.cpp,*.c,*.java,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()  " where file auto open the window
function! s:init_var(var, value) abort
    if !exists('g:tagbar_' . a:var)
        execute 'let g:tagbar_' . a:var . ' = ' . string(a:value)
    endif
endfunction
function! s:setup_keymaps() abort
    let keymaps = [
                \ ['togglecaseinsensitive', ''],
                \ ]
    for [map, key] in keymaps
        call s:init_var('map_' . map, key)
        unlet key
    endfor
endfunction
call s:setup_keymaps()
" }}}


Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
" === rnvimr {{{
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
nnoremap <silent> ra :RnvimrSync<CR>:RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}] 
" }}}

" File navigation
Plug 'junegunn/fzf.vim',{'on': 'FZF'}
" === FZF (sudo pacman -S fzf)
noremap <c-f> :FZF<CR>

" Formatter
Plug 'Chiel92/vim-autoformat',{'on': 'AutoFormat'}
" === AutoFormat
nnoremap \f :Autoformat<CR>

" NerdCommenter
Plug 'scrooloose/nerdcommenter' " in <space>cn to comment a line

" Genreal Highlighter
Plug 'jaxbot/semantic-highlight.vim'

" show indentation line
Plug 'Yggdroot/indentLine'
"=== indentLine
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 238
let g:indentLine_char = '|'

Plug 'luochen1990/rainbow'
" === rainbow
let g:rainbow_active = 1


"" Find & Replace
"" Press SPACE f r to search in cwd.
"Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }
"" ===
"" === Far.vim, batch modifying
"nnoremap <LEADER>f :F  **/*<left><left><left><left><left>
"let g:far#mapping = {
            "\ "replace_undo" : ["l"],
            "\ }

Plug 'osyo-manga/vim-anzu' " show search position
" === Anzu
set statusline=%{anzu#search_status()}


" For general writing-工作无忧
Plug 'junegunn/goyo.vim',{'on': 'Goyo'}
" === goyo
map <LEADER>gy :Goyo<CR>
" Vim Applications-日历
Plug 'itchyny/calendar.vim',{'on': ['Calendar -position=tab', 'Calendar -view=clock -position=here']}
" === vim-calendar {{{
noremap \c :Calendar -position=tab<CR>
noremap \\ :Calendar -view=clock -position=here<CR> " open clock
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
augroup calendar-mappings
    autocmd!
    " diamond cursor
    autocmd FileType calendar nmap <buffer> k <Plug>(calendar_up)
    autocmd FileType calendar nmap <buffer> h <Plug>(calendar_left)
    autocmd FileType calendar nmap <buffer> j <Plug>(calendar_down)
    autocmd FileType calendar nmap <buffer> l <Plug>(calendar_right)
    autocmd FileType calendar nmap <buffer> <c-k> <Plug>(calendar_move_up)
    autocmd FileType calendar nmap <buffer> <c-h> <Plug>(calendar_move_left)
    autocmd FileType calendar nmap <buffer> <c-j> <Plug>(calendar_move_down)
    autocmd FileType calendar nmap <buffer> <c-l> <Plug>(calendar_move_right)
    autocmd FileType calendar nmap <buffer> a <Plug>(calendar_start_insert)
    autocmd FileType calendar nmap <buffer> A <Plug>(calendar_start_insert_head)
    " unmap <C-n>, <C-p> for other plugins
    autocmd FileType calendar nunmap <buffer> <C-n>
    autocmd FileType calendar nunmap <buffer> <C-p>
augroup END
" }}}


" Auto Complete Coc {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " install [npm] [yarn]
Plug 'wellle/tmux-complete.vim'
" === coc
" fix the most annoying bug that coc has
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
"set signcolumn=no  " no side bar
let g:coc_global_extensions = [
        \'coc-lists', 'coc-snippets', 'coc-explorer', 
        \'coc-python', 'coc-pyright', 
        \'coc-vimlsp', 'coc-sh', 'coc-json', 
        \'coc-java', 'coc-html', 'coc-css', 'coc-stylelint', 
        \'coc-tsserver', 'coc-tslint', 'coc-tailwindcss', 
        \'coc-git', 'coc-gitignore', 
        \'coc-sourcekit', 'coc-flutter', 
        \'coc-yank',  'coc-translator', 
    \]
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<c-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
" previous one
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" use <shift>+<space> mandatory completion
inoremap <silent><expr> <s-space> coc#refresh()
" use <enter> confirmation completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
" Open up coc-commands
nnoremap <c-c> :CocCommand<CR>
" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" 选择函数内所有行
xmap yf <Plug>(coc-funcobj-i)
omap yf <Plug>(coc-funcobj-i)
" 选择当前函数所在区间
xmap tf <Plug>(coc-funcobj-a)
omap tf <Plug>(coc-funcobj-a)
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
" GoTo code navigation. 代码导航
" 跳转到定义处。如有多个定义，使用 |coc-list| 展示
nmap <silent> gd <Plug>(coc-definition)
" 跳转到类型定义位置
nmap <silent> gt <Plug>(coc-type-definition)
" 跳转到实现处
nmap <silent> gi <Plug>(coc-implementation)
" 跳转到引用位置
nmap <silent> gr <Plug>(coc-references)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

nmap tt :CocCommand explorer<CR>
" coc-translator 翻译
nmap ts <Plug>(coc-translator-p)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"           获取并执行 language server 给出的当前选择区间
"           内的可用操作。
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Use <C-l> for trigger snippet expand.
imap <C-j> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" }}}


" Snippets {{{
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/']
" }}}


" Python {{{
Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim'
" }}}


" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }

"Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
Plug 'pangloss/vim-javascript', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" === jsx
let g:vim_jsx_pretty_colorful_config = 1

Plug 'jelera/vim-javascript-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }


"" Go {{{
"Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }
"" ===
"" === vim-go
"let g:go_def_mapping_enabled = 0
"let g:go_template_autocreate = 0
"let g:go_textobj_enabled = 0
"let g:go_auto_type_info = 1
"let g:go_def_mapping_enabled = 0
"let g:go_highlight_array_whitespace_error = 1
"let g:go_highlight_build_constraints = 1
"let g:go_highlight_chan_whitespace_error = 1
"let g:go_highlight_extra_types = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_format_strings = 1
"let g:go_highlight_function_calls = 1
"let g:go_highlight_function_parameters = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_generate_tags = 1
"let g:go_highlight_methods = 1
"let g:go_highlight_operators = 1
"let g:go_highlight_space_tab_error = 1
"let g:go_highlight_string_spellcheck = 1
"let g:go_highlight_structs = 1
"let g:go_highlight_trailing_whitespace_error = 1
"let g:go_highlight_types = 1
"let g:go_highlight_variable_assignments = 0
"let g:go_highlight_variable_declarations = 0
"let g:go_doc_keywordprg_enabled = 0
" }}}


" Editor Enhancement
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi'
" === vim-visual-multi {{{
"let g:VM_theme             = 'iceblue'
"let g:VM_default_mappings = 0
let g:VM_leader = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_maps = {}
let g:VM_custom_motions  = {'h': 'h', 'l': 'l', 'k': 'k', 'j': 'j', '0': '0', '4': '$'}
let g:VM_maps['i']         = 'i'
let g:VM_maps['I']         = 'I'
let g:VM_maps['Find Under']         = '<C-u>'
let g:VM_maps['Find Subword Under'] = '<C-u>'
let g:VM_maps['Find Next']         = ''
let g:VM_maps['Find Prev']         = ''
let g:VM_maps['Remove Region'] = 'q'
let g:VM_maps['Skip Region'] = ''
let g:VM_maps["Undo"]      = 'u'
let g:VM_maps["Redo"]      = '<C-r>'
" }}}

Plug 'scrooloose/nerdcommenter' " in <space>cn to comment a line;<space>cu to uncomment a line
"Plug 'AndrewRadev/switch.vim' " gs to switch
Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
Plug 'junegunn/vim-after-object' " da= to delete what's after =
" === vim-after-object
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

Plug 'tpope/vim-capslock'   " Ctrl+L (insert) to toggle capslock
Plug 'easymotion/vim-easymotion'
" === vim-easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_smartcase = 1
map ' <Plug>(easymotion-bd-f)
nmap ' <Plug>(easymotion-bd-f)
"map E <Plug>(easymotion-j)
"map U <Plug>(easymotion-k)
"nmap f <Plug>(easymotion-overwin-f)
"map \; <Plug>(easymotion-prefix)
"nmap ' <Plug>(easymotion-overwin-f2)
"map 'l <Plug>(easymotion-bd-jk)
"nmap 'l <Plug>(easymotion-overwin-line)
"map  'w <Plug>(easymotion-bd-w)
"nmap 'w <Plug>(easymotion-overwin-w)


Plug 'Konfekt/FastFold'
" === fastfold f
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'ze', 'zu']
let g:markdown_folding = 1
let g:tex_fold_enabled = 1
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1
let g:r_syntax_folding = 1
let g:rust_fold = 1
let g:php_folding = 1


" Other visual enhancement
Plug 'ryanoasis/vim-devicons' " add icon to vim plug
Plug 'luochen1990/rainbow'    " rainbow brackets
" === xtabline
Plug 'mg979/vim-xtabline'     " top tabline
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
noremap \p :XTabInfo<CR>

Plug 'wincent/terminus'
" Dependencies
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'kana/vim-textobj-user'
Plug 'roxma/nvim-yarp'


" Markdown {{{
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }
Plug 'theniceboy/bullets.vim'
" ===
" Markdown Snippets
autocmd FileType markdown source ~/.config/nvim/my_extra/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell
" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1
            \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let g:mkdp_browser = 'firefox'
" ===
" === vim-table-mode
noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'
Plug 'junegunn/vim-easy-align' " ga= to align the = in paragraph,
" ===
" === vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}


" Swift
"Plug 'keith/swift.vim'

call plug#end()
" --------------------------------------------}}}

" experimental
set lazyredraw


" === Necessary Commands to Execute
exec "nohlsearch"


" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
    exec "e ~/.config/nvim/_machine_specific.vim"
endif

