local utils = require('utils')
local g = vim.g

local mapping_module = 'settings.mappings'
local options_module = 'settings.options'

return function()
    local is_ok, mappings = pcall(require, mapping_module)
    if not is_ok then
        mappings = {}
        utils.warn(('load "%s" faild!'):format(mapping_module))
    end

    local default_args = { silent = true, noremap = true }

    -- set up mappings
    g.mapleader = ' '
    for _, one_map in pairs(mappings or {}) do
        local opts = vim.tbl_deep_extend('force', default_args, one_map[4] or {})
        utils.map(one_map[1], one_map[2], one_map[3], opts)
    end

    -- set up options
    local load_optiosn, options = pcall(require, options_module)
    if not load_optiosn then
        options = {}
        utils.warn(('load "%s" faild!'):format(options_module))
    end

    for o, v in pairs(options) do
        utils.opt(o, v)
    end
end
