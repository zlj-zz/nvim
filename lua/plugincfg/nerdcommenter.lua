local utils = require('utils')
local map = utils.map

local g = vim.g

vim.cmd [[

" For vue
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction

function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

]]

g.NERDDefaultAlign = 'none'

-- Add your own custom formats or override the defaults
g.NERDCustomDelimiters = {
    python= {
        left= '# ',
        leftAlt= '""" ',
        rightAlt= ' """'
    }
}


map({"n", "x"}, "c/", "<Plug>NERDCommenterToggle")
