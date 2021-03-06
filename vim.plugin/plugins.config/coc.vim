" vim:set et sw=2 ts=2 fdm=marker fdl=1:

" \\\\\\
" >>>>>>> coc 
" //////
if g:if_use_coc
  set signcolumn=no  " no side bar
  if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
  else
    set signcolumn=yes
  endif
  let g:coc_global_extensions = [
      \'coc-lists',
      \'coc-explorer',
      \'coc-diagnostic',
      \'coc-snippets',
      \'coc-git',
      \'coc-gitignore',
      \'coc-vimlsp',
      \'coc-sh',
      \'coc-highlight',
      \'coc-python',
      \'coc-pyright',
      \'coc-flutter-tools',
      \'coc-json',
      \'coc-html',
      \'coc-css',
      \'coc-vetur',
      \'coc-prettier',
      \'coc-yaml',
      \'coc-sourcekit',
      \'coc-tsserver',
      \'coc-tslint',
      \'coc-tailwindcss',
      \'coc-yank',
      \'coc-translator',
    \]
          "\'coc-java',
          "\'coc-ccls',

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
  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif
  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
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
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gt <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  "           获取并执行 language server 给出的当前选择区间
  "           内的可用操作。
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Use <C-j> for trigger snippet expand.
  imap <C-j> <Plug>(coc-snippets-expand)
  " Use <C-j> for select text for visual placeholder of snippet.
  vmap <C-j> <Plug>(coc-snippets-select)
  " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<c-j>'
  " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  let g:coc_snippet_prev = '<c-k>'
  " Use <C-j> for both expand and jump (make expand higher priority.)
  imap <C-j> <Plug>(coc-snippets-expand-jump)

  " Formatting selected code.
  xmap \f  <Plug>(coc-format-selected)
  nmap \f  <Plug>(coc-format-selected)
  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')
  xmap \F  :Format<cr>
  nmap \F  :Format<cr>

  " Open up coc-commands
  nnoremap <c-c> :CocCommand<CR>
  " Use K to show documentation in preview window.
  nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  nmap tt :CocCommand explorer<CR>
  " coc-translator 翻译
  nmap ts <Plug>(coc-translator-p)
  vmap ts <Plug>(coc-translator-pv)



  " \\\\\\
  " >>>>>>> vim-snippet 
  " //////
  " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
  let g:UltiSnipsExpandTrigger="<c-j>"
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"
  let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/']


  " \\\\\\
  " >>>>>>> dart-lang/dart-vim-plugin 
  " //////
  let g:dart_style_guide    = 2
  let g:dart_format_on_save = 1
  let g:dartfmt_options     = ["-l 100"]
  " for dart format
  let g:dart_format_on_save = 1
endif
