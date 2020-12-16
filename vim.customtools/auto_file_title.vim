func! s:SetTitle() abort
    if &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# -*- coding:UTF-8 -*-")
        call append(line(".")+1, "")
        call append(line(".")+2, '"""<++>')
        call append(line(".")+3, "")
        call append(line(".")+4, "File Name: ".expand("%"))
        call append(line(".")+5, "Last Modified: ")
        call append(line(".")+6, "Created Time: ".strftime("%Y-%m-%d"))
        call append(line(".")+7, "")
        call append(line(".")+8, "<++>")
        call append(line(".")+9, '"""')
        call append(line(".")+10, "")
        call append(line(".")+11, "__version__ = '<++>'")
        call append(line(".")+12, "__author__ = 'zachary'")
        call append(line(".")+13, "")
        call append(line(".")+14, "<++>")

    elseif &filetype == 'c' || &filetype == 'cpp'
        call setline(1, "/*")
        call append(line("."), " * Copyright(C) 1997-".strftime("%Y").", Tech. Co.,Ltd.")
        call append(line(".")+1, " * FileName: ".expand("%"))
        call append(line(".")+2, " * Author: zachary")
        call append(line(".")+3, " * Version: <++>")
        call append(line(".")+4, " * Date: ".strftime("%Y-%m-%d"))
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
        call append(line(".")+3, "* @date ".strftime("%Y-%m-%d"))
        call append(line(".")+4, "*/")
        call append(line(".")+5, "<++>")

    elseif &filetype == "sh"
        call setline(1, "\#!/bin/env bash")
        call append(line("."), "")
        call append(line(".")+1, "\# File Name: ".expand("%"))
        call append(line(".")+2, "\# Description: <++>")
        call append(line(".")+3, "\# Author: zachary")
        call append(line(".")+4, "\# Created Time: ".strftime("%Y-%m-%d"))
        call append(line(".")+5, "\# Last Modified: ")
        call append(line(".")+6, "")
        call append(line(".")+7, "<++>")

    endif
    "     normal G
endfunc

autocmd FileType c,cpp,python,java,sh command! AutoTitle call s:SetTitle()

"augroup fileTitle
    "autocmd FileType c,cpp,python,java,sh
    "command! AutoTitle :call SetTitle()<CR>
"augroup END
