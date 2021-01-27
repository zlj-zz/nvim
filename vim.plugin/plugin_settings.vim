" vim:set et sw=2 ts=2 fdm=marker fdl=1:
"===============================================
"=                                             =
"=               plugin settings               =
"=                                             =
"===============================================
scriptencoding utf-8

let s:script_cwd = expand('<sfile>:p:h')

for s:plug_config in split(globpath(s:script_cwd . '/plugins.config', '*.vim'), '\n')
  if filereadable(s:plug_config)
    execute 'source ' . s:plug_config
  endif
endfor


