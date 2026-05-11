local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
    s('pt', fmt(
        [[" \\\\\\\\\\\\\\\
" =============== {}
" ///////////////{}]],
        { i(1, 'todo'), i(0) }
    )),

    s('pyenv', fmt(
        [[let g:python3_host_prog="{}"
let g:python_host_prog=""{}]],
        { i(1), i(0) }
    )),
}
