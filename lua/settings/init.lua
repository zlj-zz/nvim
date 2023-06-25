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

    local map = {
        leader = ' ',
        list = mappings or {},
        default_args = setmetatable({
            silent = true,
            noremap = true
        }, {
            __add = function(tbl_old, tbl_new)
                local new_table = vim.deepcopy(tbl_old)
                if tbl_new ~= nil then
                    vim.validate {
                        tbl_new = {tbl_new, 't'}
                    }
                    for k, v in pairs(tbl_new) do
                        new_table[k] = v
                    end
                end
                return new_table
            end
        })
    }

    -- set up mappings
    g.mapleader = map.leader
    for _, one_map in pairs(map.list) do
        utils.map(one_map[1], one_map[2], one_map[3], map.default_args + one_map[4])
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

