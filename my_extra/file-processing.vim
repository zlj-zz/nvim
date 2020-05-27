func! SetTitle()
    if &filetype == 'python'
        call setline(1,"#!/usr/bin/env python3")
        call append(line("."),"# -*- coding:UTF-8 -*-")
        call append(line(".")+1, "")
        call append(line(".")+2, '"""')
        call append(line(".")+3, "File Name: ".expand("%"))
        call append(line(".")+4, "Created Time: ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(line(".")+5, "Last Modified: ")
        call append(line(".")+6, "Description: <++>")
        call append(line(".")+7, '"""')
        call append(line(".")+8, "")
        call append(line(".")+9, "__author__ = 'zachary'")
        call append(line(".")+10, "<++>")

    elseif &filetype == 'c' || &filetype == 'cpp'
        call setline(1, "/*")
        call append(line("."), " * Copyright(C) 1997-".strftime("%Y").", Tech. Co.,Ltd.")
        call append(line(".")+1, " * FileName: ".expand("%"))
        call append(line(".")+2, " * Author: zachary")
        call append(line(".")+3, " * Version: <++>")
        call append(line(".")+4, " * Date: ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(line(".")+5, " * Last Modified: ")
        call append(line(".")+6, " * Description: <++>")
        call append(line(".")+7, " */")
        call append(line(".")+8, "")
        call append(line(".")+8, "#include <stdio.h>")
        call append(line(".")+9, "<++>")

    elseif &filetype == 'java'
        call setline(1, "/**")
        call append(line("."), "* @description <++>")
        call append(line(".")+1, "* @author zachary")
        call append(line(".")+2, "* @version <++>")
        call append(line(".")+3, "* @date ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(line(".")+4, "*/")
        call append(line(".")+5, "<++>")

    elseif &filetype == "sh"
        call setline(1, "\#!/bin/env bash")
        call append(line("."), "")
        call append(line(".")+1, "\# File Name: ".expand("%"))
        call append(line(".")+2, "\# Description: <++>")
        call append(line(".")+3, "\# Author: zachary")
        call append(line(".")+4, "\# Created Time: ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(line(".")+5, "\# Last Modified: ")
        call append(line(".")+6, "")
        call append(line(".")+7, "<++>")

    elseif &filetype == 'plaintex'
        call setline(1,"% -*- coding:UTF-8 -*-")
        call append(line("."),"% #########################################################################")
        call append(line(".")+1, "% File Name: ".expand("%"))
        call append(line(".")+2, "% Author: stubborn vegeta")
        call append(line(".")+3, "% Created Time: ".strftime("%c"))
        call append(line(".")+4, "% #########################################################################")
        call append(line(".")+5, "\\documentclass[UTF8]{<++>}")
        call append(line(".")+6, "\\usepackage{graphicx}")
        call append(line(".")+7, "\\usepackage{booktabs}")
        call append(line(".")+8, "\\usepackage{geometry}")
        call append(line(".")+9, "\\geometry{left=2.5cm,right=2.5cm,top=2.5cm,bottom=2.5cm}")
        call append(line(".")+10, "\\pagestyle{plain}")
        call append(line(".")+11, "\\begin{document}")
        call append(line(".")+12, "<++>")
        call append(line(".")+13, "\\end{document}")

    elseif &filetype == 'tex'
        call setline(1,"% -*- coding:UTF-8 -*-")
        call append(line("."),"% #########################################################################")
        call append(line(".")+1, "% File Name: ".expand("%"))
        call append(line(".")+2, "% Author: stubborn vegeta")
        call append(line(".")+3, "% Created Time: ".strftime("%c"))
        call append(line(".")+4, "% #########################################################################")
        call append(line(".")+5, "\\documentclass[UTF8]{<++>}")
        call append(line(".")+6, "\\usepackage{graphicx}")
        call append(line(".")+7, "\\usepackage{booktabs}")
        call append(line(".")+8, "\\usepackage{geometry}")
        call append(line(".")+9, "\\geometry{left=2.5cm,right=2.5cm,top=2.5cm,bottom=2.5cm}")
        call append(line(".")+10, "\\pagestyle{plain}")
        call append(line(".")+11, "\\begin{document}")
        call append(line(".")+12, "<++>")
        call append(line(".")+13, "\\end{document}")
    endif
    "     normal G
endfunc

func! SetLastModifiedTime(lineno)
    let modif_time = strftime("%Y-%m-%d %H:%M:%S")
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


func! CreateTmpFile()
    silent! exec "!mkdir ~/.config/nvim/demo"
    silent! exec "!touch ~/.config/nvim/demo/tmp.{c,py,java,js,html,css,sh}"
endfunc
