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
" sudo save
cmap w!! w !sudo tee >/dev/null %
" quit
map Q :q<CR>
" force exit without saving
map <c-q> :q!<CR>
" make Y to copy till the end of the line
"nnoremap Y y$
" Indentation
nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv
" Copy to system clipboard
vnoremap <c-c> "+y
" Past from system clipboard
"vnoremap <c-v> "+p
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
nnoremap ; :
"nnoremap ` ~
" +1 and -1
nnoremap <leader>k <c-a>
nnoremap <leader>j <c-x>


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
map c <nop>
" Place the two screens up and down
noremap cj <C-w>t<C-w>K
" Place the two screens side by side
noremap ck <C-w>t<C-w>H
" toggle to make a screen full when split screen
nnoremap <silent> <leader>z :ZoomToggle<cr>


"===========================
"=                         =
"=    tabe management      =
"=                         =
"===========================
" new tab, 'w' filepath_and_name
map st :tabe<CR>
" before tab
map t- :-tabnext<CR>
" next tab
map t= :+tabnext<CR>
" before buffer
map b- :bp<CR>
" next buffer
map b= :bn<CR>
" jump to 1~9 tab
noremap <silent><m-1> 1gt
noremap <silent><m-2> 2gt
noremap <silent><m-3> 3gt
noremap <silent><m-4> 4gt
noremap <silent><m-5> 5gt
noremap <silent><m-6> 6gt
noremap <silent><m-7> 7gt
noremap <silent><m-8> 8gt
noremap <silent><m-9> 9gt


"===========================
"=                         =
"=      other              =
"=                         =
"===========================
" Spelling Check with <space>sc
nnoremap <LEADER>sc :set spell!<CR>
"  paste mode
nnoremap <leader>pm :set paste!<cr>
" cancel the highlight search
nnoremap <LEADER><CR> :nohlsearch<CR>
" Open the vimrc file anytime
nnoremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>
" resource neovim config
nnoremap ,rc :source $MYVIMRC<CR>
" Opening a terminal window
nnoremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +1<CR>:term<CR>
tnoremap <C-N> <C-\><C-N>
" find two same word
nmap <LEADER>fd /\(\<\w\+\>\)\_s*\1
" Press space twice to jump to the next ':' and edit it
nnoremap <LEADER><LEADER> <ESC>/<++><CR>:nohlsearch<CR>c4l
if g:isWin == 0
    " lazygit
    noremap gl :tabe<CR>:-tabmove<CR>:term lazygit<CR>a
endif


" Auto change directory to current dir
"autocmd BufEnter * silent! lcd %:p:h

" when you open file, back to last edit position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

