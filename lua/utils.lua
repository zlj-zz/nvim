local M = {}

local o_s = vim.opt or vim.o
local map_key = vim.api.nvim_set_keymap
local cmd = vim.cmd

function M.info(s, ...)
    vim.notify(string.format(s, ...), vim.log.levels.INFO)
end

function M.warn(s, ...)
    vim.notify(string.format(s, ...), vim.log.levels.WARN)
end

function M.error(s, ...)
    vim.notify(string.format(s, ...), vim.log.levels.ERROR)
end

---Change vim option
---@param o string ;option name
---@param v any ;setting value
---@param scopes any ;the scopes of option
function M.opt(o, v, scopes)
    scopes = scopes or { o_s }
    for _, s in pairs(scopes) do
        s[o] = v
    end
end

---Set custom vim key mapping.
---@param modes any ; key map mode,`string` or `table`
--[[
         String value 	Help page	  Affected modes
         ''             mapmode-nvo   Normal, Visual, Select, Operator-pending
         'n'            mapmode-n 	  Normal
         'v'            mapmode-v 	  Visual and Select
         's'            mapmode-s 	  Select
         'x'            mapmode-x 	  Visual
         'o'            mapmode-o 	  Operator-pending
         '!'            mapmode-ic 	  Insert and Command-line
         'i'            mapmode-i 	  Insert
         'l'            mapmode-l 	  Insert, Command-line, Lang-Arg
         'c'            mapmode-c 	  Command-line
         't'            mapmode-t 	  Terminal
]]
---@param lhs string ;wanted key map
---@param rhs string ;source key map
---@param opts table
function M.map(modes, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = opts.noremap == nil and true or opts.noremap

    if type(modes) == 'string' then
        modes = { modes }
    end

    for _, mode in ipairs(modes) do
        map_key(mode, lhs, rhs, opts)
    end
end

function M.autocmd(group, cmds, clear)
    clear = clear == nil and false or clear
    if type(cmds) == 'string' then
        cmds = { cmds }
    end
    cmd('augroup ' .. group)
    if clear then
        cmd [[au!]]
    end
    for _, c in ipairs(cmds) do
        cmd('autocmd ' .. c)
    end
    cmd [[augroup END]]
end

return M
