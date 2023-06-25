local utils = require('utils')
local map = utils.map

local g = vim.g

g.startify_files_number = 20
g.startify_lists = {
    { type= 'files',     header= {'   MRU'}            },
    { type= 'sessions',  header= {'   Sessions'}       },
    { type= 'bookmarks', header= {'   Bookmarks'}      },
}

g.startify_custom_header = vim.api.nvim_call_function('startify#center', {require('headers').ascii})


map("n", "<F5>", ":tabe<cr>:Startify<cr>")

