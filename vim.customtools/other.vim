" vim:set et sw=2 ts=2 fdm=marker fdl=1:

func! SetLastModifiedTime(lineno)
  let modif_time = strftime("%Y-%m-%d")
  if a:lineno == "-1"
    let line = getline(7)
  else
    let line = getline(a:lineno)
  endif
  if line =~ 'Last Modified:'
    let line = strpart(line, 0, stridx(line, ":")).": ".modif_time
  endif
  if a:lineno == "-1"
    call setline(7, line)
  else
    call append(a:lineno, line)
  endif
endfunc

func! GetTimeInfo()
  return strftime('%Y-%m-%d %H:%M:%S')
endfunc

nmap upd :call SetLastModifiedTime(-1)<CR>

func! CreateTmpFile()
  silent! exec "!mkdir -p ~/.config/nvim/demo"
  silent! exec "!touch ~/.config/nvim/demo/tmp.{c,py,java,js,html,css,sh}"
endfunc


let s:hi = execute('hi normal')
let g:record_guibg_ = matchstr(s:hi, 'guibg=\zs\S*')
unlet s:hi
let g:bg_flag_ = 1

func! Switch_transparent_bg() abort " transparent background toggle
  if g:bg_flag_ == 1
    let g:bg_flag_ = 0
    exec "hi normal guibg=none"
  else
    let g:bg_flag_ = 1
    exec "hi normal guibg=".g:record_guibg_
  endif
endfunc

func! Switch_buf_by_index(num) abort
  let l:buf_idx = a:num
  let l:buf_list = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  let l:buf_len = len(l:buf_list)
  if l:buf_idx > l:buf_len | return | endif
  let l:buf_id = l:buf_list[l:buf_idx - 1]
  execute ':'.l:buf_id.'b'
endfunc

func! Switch_full_screen() abort
  if exists('t:zoomed') && t:oomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunc

command! ZoomToggle call Switch_full_screen()
command! -nargs=1 SwitchBuffer call Switch_buf_by_index(<args>)

map <f4> :call Switch_transparent_bg()<CR>
nnoremap b1 :SwitchBuffer 1<cr>
nnoremap b2 :SwitchBuffer 2<cr>
nnoremap b3 :SwitchBuffer 3<cr>
nnoremap b4 :SwitchBuffer 4<cr>
nnoremap b5 :SwitchBuffer 5<cr>
nnoremap b6 :SwitchBuffer 6<cr>
nnoremap b7 :SwitchBuffer 7<cr>
nnoremap b8 :SwitchBuffer 8<cr>
nnoremap b9 :SwitchBuffer 9<cr>
" before buffer
nnoremap b- :bp<cr>
" next buffer
nnoremap b= :bn<cr>
" Last buffer
nnoremap b# :b#<cr>
" toggle to make a screen full when split screen
nnoremap <silent> <leader>z :ZoomToggle<cr>z

