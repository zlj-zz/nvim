local utils = require('settings.utils')
local g = vim.g

return function()
    local is_ok, mappings = pcall(require, 'settings.mappings')
    if not is_ok then
        mappings = {}
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

    local load_optiosn, options = pcall(require, 'settings.options')
    if not load_optiosn then
        options = {}
    end

    -- set up options
    for o, v in pairs(options) do
        utils.opt(o, v)
    end

end

