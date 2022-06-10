" vim:set et sw=2 ts=2 fdm=marker fdl=1:

func! GetTimeInfo()
  return strftime('%Y-%m-%d %H:%M:%S')
endfunc

func! CreateTmpFile()
  silent! exec "!mkdir -p ~/.config/nvim/demo"
  silent! exec "!touch ~/.config/nvim/demo/tmp.{c,py,java,js,html,css,sh}"
endfunc

