return function()
    local is_ok, mappings = pcall(require, 'settings.mappings')
    if not is_ok then mappings = {} end

    local map = {
        leader = ' ',
        list = mappings or {},
        default_args = setmetatable({silent = true, noremap = true}, {
            __add = function(tbl_old, tbl_new)
                local new_table = vim.deepcopy(tbl_old)
                if tbl_new ~= nil then
                    vim.validate {tbl_new = {tbl_new, 't'}}
                    for k, v in pairs(tbl_new) do
                        new_table[k] = v
                    end
                end
                return new_table
            end
        })
    }

    -- set up mappings
    vim.g.mapleader = map.leader
    for _, one_map in pairs(map.list) do
        vim.api.nvim_set_keymap(one_map[1], one_map[2], one_map[3], map.default_args + one_map[4])
    end

    local is_ok, options = pcall(require, 'settings.options')
    if not is_ok then options = {} end

    local opt = vim.opt or vim.o
    -- set up options
    for o, v in pairs(options) do
        opt[o] = v
    end

    -- orignal
    local nvim_home = vim.fn.expand('<sfile>:p:h')
    vim.cmd('source '..nvim_home..'/lua/settings/mappings.vim')

end

-- "" Auto change directory to current dir
-- ""autocmd BufEnter * silent! lcd %:p:h
-- "
-- "" when you open file, back to last edit position
-- ""au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

