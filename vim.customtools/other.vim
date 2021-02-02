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
  silent! exec "!mkdir ~/.config/nvim/demo"
  silent! exec "!touch ~/.config/nvim/demo/tmp.{c,py,java,js,html,css,sh}"
endfunc




