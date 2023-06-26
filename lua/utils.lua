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
---@param o string @option name
---@param v any @setting value
---@param scopes any @the scopes of option
function M.opt(o, v, scopes)
    scopes = scopes or { o_s }
    for _, s in pairs(scopes) do
        s[o] = v
    end
end

---Set custom vim key mapping.
---@param modes string | table @key map mode,`string` or `table`
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
---@param lhs string @wanted key map
---@param rhs string @source key map
---@param opts? table @key map options
function M.map(modes, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = opts.noremap == nil and true or opts.noremap

    if type(modes) == 'string' then
        modes = { modes }
    end

    for _, mode in ipairs(modes) do
        if type(mode) ~= 'string' then
            M.warn('Cannot key set with error mode type: ' .. type(mode))
        else
            map_key(mode, lhs, rhs, opts)
        end
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

---create colour gradient from hex values
---@param start string @"#DCA561", "#658594"
---@param finish string
---@param steps integer
---@return table
function M.create_gradient (start, finish, steps)
	local r1, g1, b1 = tonumber("0x" .. start:sub(2, 3)), tonumber("0x" .. start:sub(4, 5)), tonumber("0x" .. start:sub(6, 7))
	local r2, g2, b2 = tonumber("0x" .. finish:sub(2, 3)), tonumber("0x" .. finish:sub(4, 5)), tonumber("0x" .. finish:sub(6, 7))

	local r_step = (r2 - r1) / steps
	local g_step = (g2 - g1) / steps
	local b_step = (b2 - b1) / steps

	local gradient = {}
	for i = 1, steps do
		local r = math.floor(r1 + r_step * i)
		local g = math.floor(g1 + g_step * i)
		local b = math.floor(b1 + b_step * i)
		table.insert(gradient, string.format("#%02x%02x%02x", r, g, b))
	end

	return gradient
end

return M

