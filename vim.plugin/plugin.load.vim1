" vim:set et sw=2 ts=2 fdm=marker fdl=1:
scriptencoding utf-8

let s:script_path = expand('<sfile>:p:h')

function! s:source(layer) abort
  execute 'source ' . s:script_path . '/layer/' . a:layer . '.vim'
endfunction

call plug#begin(g:home_path.'/plugged')

if g:used_coc
  Plug 'neoclide/coc.nvim', {'branch': 'release'}  " install [npm] [yarn]
endif
" Auto Complete Coc
Plug 'wellle/tmux-complete.vim'

call s:source('code-language')
call s:source('edit')
call s:source('file-manager')
call s:source('markdown')
call s:source('style')

call plug#end()

" Free memory
delfunction s:source
unlet s:script_path

