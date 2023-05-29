"func ReplaceLine(src, trg)
    "exec ":s/" . a:src . "/" . a:trg . "/"
"endfunction

"func ReplaceG(src, trg)
    "exec ":s/" . a:src . "/" . a:trg . "/g"
"endfunction

func ReplaceCustom(src, trg, sLine, eLine)
    "echo ":".a:sLine.",".a:eLine."s/".a:src."/".a:trg."/g"
    exec ":"
            \.a:sLine . ","
            \.a:eLine . "s/"
            \.a:src . "/" . a:trg . "/g"
endfunction

func ReplaceSelc(src, trg)
    " Get the start and end line of selected.
    let l:start = line("'<")
    let l:end = line("'>")

    " Call replace func.
    call ReplaceCustom(a:src, a:trg, l:start, l:end)

endfunction


command -nargs=* RepSelc call ReplaceSelc(<f-args>)

" Replace part
vnoremap rp :<Del><Del><Del><Del><Del>RepSelc
