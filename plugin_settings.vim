"===============================================
"=                                             =
"=               plugin settings               =
"=                                             =
"===============================================

"" |||||||                ||||||
"" ||||||| vim-illuminate ||||||
"" |||||||                ||||||
"let g:Illuminate_delay = 750
"
"" |||||||             ||||||
"" ||||||| eleline.vim ||||||
"" |||||||             ||||||
"let g:airline_powerline_fonts = 0

" |||||||             ||||||
" |||||||   xtabline  ||||||
" |||||||             ||||||
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
noremap \p :XTabInfo<CR>

" |||||||              ||||||
" ||||||| vim-startity ||||||
" |||||||              ||||||
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
"if empty(glob('~/.config/nvim/tmp/demo/'))
"    silent! exec "!mkdir ~/.config/nvim/tmp/demo"
"    silent! exec "!touch ~/.config/nvim/tmp/demo/tmp.{c,py,java,js,html,css,sh}"
"endif
"function s:temporaryMenu()
"  return [
"        \ { 'line': 'c', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.c' },
"        \ { 'line': 'py', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.py' },
"        \ { 'line': 'java', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.java' },
"        \ { 'line': 'js', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.js' },
"        \ { 'line': 'html', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.html' },
"        \ { 'line': 'css', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.css' },
"        \ { 'line': 'bash', 'cmd': 'e ~/.config/nvim/tmp/demo/tmp.sh' },
"        \ ]
"endfunction
"let g:startify_lists = [
"      \ { 'type': 'files',     'header': ['   MRU']            },
"      \ { 'type': function('s:temporaryMenu'),  'header': ['   Temporary'] },
"      \ { 'type': 'sessions',  'header': ['   Sessions']       },
"      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
"      \ ]


" |||||||              ||||||
" |||||||   undotree   ||||||
" |||||||              ||||||
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


" |||||||             ||||||
" |||||||   nerdtree  ||||||
" |||||||             ||||||
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


"" |||||||             |||||| (sudo pacman -S fzf)
"" |||||||   fzf.vim   ||||||
"" |||||||             ||||||
"noremap <c-f> :FZF<CR>
"
" |||||||                ||||||
" ||||||| vim-autoformat ||||||
" |||||||                ||||||
nnoremap \f :Autoformat<CR>

" |||||||                        ||||||
" ||||||| semantic-highlight.vim ||||||
" |||||||                        ||||||
noremap \h :SemanticHighlightToggle<cr>

" |||||||             ||||||
" ||||||| indentLine  ||||||
" |||||||             ||||||
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 238
let g:indentLine_char = '|'

" |||||||             ||||||
" |||||||   rainbow   ||||||
" |||||||             ||||||
let g:rainbow_active = 1

"" |||||||             ||||||
"" |||||||  vim-anzu   ||||||
"" |||||||             ||||||
"set statusline=%{anzu#search_status()}
"

" |||||||             ||||||
" |||||||  goyo.vim   ||||||
" |||||||             ||||||
map <LEADER>gy :Goyo<CR>


" |||||||             ||||||
" |||||||      coc    ||||||
" |||||||             ||||||
" fix the most annoying bug that coc has
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
"set signcolumn=no  " no side bar
let g:coc_global_extensions = [
        \'coc-lists', 'coc-snippets', 'coc-explorer', 
        \'coc-python', 'coc-pyright', 
        \'coc-vimlsp', 'coc-sh', 
        \'coc-json', 
        \'coc-html', 'coc-css', 
        \'coc-java', 
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


"" |||||||             ||||||
"" |||||||     jsx     ||||||
"" |||||||             ||||||
"let g:vim_jsx_pretty_colorful_config = 1
"
"" |||||||                  ||||||
"" ||||||| vim-after-object ||||||
"" |||||||                  ||||||
"autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

" |||||||                  ||||||
" |||||||   vim-snippet    ||||||
" |||||||                  ||||||
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/']

"" |||||||                       ||||||
"" |||||||   vim-visual-multi    ||||||
"" |||||||                       ||||||
""let g:VM_theme             = 'iceblue'
""let g:VM_default_mappings = 0
"let g:VM_leader = {'default': ',', 'visual': ',', 'buffer': ','}
"let g:VM_maps = {}
"let g:VM_custom_motions  = {'h': 'h', 'l': 'l', 'k': 'k', 'j': 'j', '0': '0', '4': '$'}
"let g:VM_maps['i']         = 'i'
"let g:VM_maps['I']         = 'I'
"let g:VM_maps['Find Under']         = '<C-u>'
"let g:VM_maps['Find Subword Under'] = '<C-u>'
"let g:VM_maps['Find Next']         = ''
"let g:VM_maps['Find Prev']         = ''
"let g:VM_maps['Remove Region'] = 'q'
"let g:VM_maps['Skip Region'] = ''
"let g:VM_maps["Undo"]      = 'u'
"let g:VM_maps["Redo"]      = '<C-r>'


" |||||||               ||||||
" |||||||   FastFold    ||||||
" |||||||               ||||||
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


"" ===
"" === MarkdownPreview
"" ===
"let g:mkdp_auto_start = 0
"let g:mkdp_auto_close = 1
"let g:mkdp_refresh_slow = 0
"let g:mkdp_command_for_global = 0
"let g:mkdp_open_to_the_world = 0
"let g:mkdp_open_ip = ''
"let g:mkdp_echo_preview_url = 0
"let g:mkdp_browserfunc = ''
"let g:mkdp_preview_options = {
"            \ 'mkit': {},
"            \ 'katex': {},
"            \ 'uml': {},
"            \ 'maid': {},
"            \ 'disable_sync_scroll': 0,
"            \ 'sync_scroll_type': 'middle',
"            \ 'hide_yaml_meta': 1
"            \ }
"let g:mkdp_markdown_css = ''
"let g:mkdp_highlight_css = ''
"let g:mkdp_port = ''
"let g:mkdp_page_title = '「${name}」'
"let g:mkdp_browser = 'firefox'
"" ===


" |||||||                ||||||
" ||||||| vim-table-mode ||||||
" |||||||                ||||||
noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'


"" ===
"" === vim-easy-align
"xmap ga <Plug>(EasyAlign)
"nmap ga <Plug>(EasyAlign)



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
    " |||||||             ||||||
    " |||||||   tagbar    ||||||
    " |||||||             ||||||
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


    " |||||||             ||||||
    " |||||||   rnvimr    ||||||
    " |||||||             ||||||
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
endif
