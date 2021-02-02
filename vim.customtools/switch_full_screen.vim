" vim:set et sw=2 ts=2 fdm=marker fdl=1:

func! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunc

command! ZoomToggle call s:ZoomToggle()


