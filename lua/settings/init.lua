local utils = require('utils')
local g = vim.g

return function()
    local mappings = require('settings.mappings')
    local options = require('settings.options')
    local default_args = { silent = true, noremap = true }

    g.mapleader = ' '
    for _, one_map in pairs(mappings) do
        local opts = vim.tbl_deep_extend('force', default_args, one_map[4] or {})
        utils.map(one_map[1], one_map[2], one_map[3], opts)
    end

    for o, v in pairs(options) do
        utils.opt(o, v)
    end
end
