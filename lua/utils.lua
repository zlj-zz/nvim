local M = {}

local o_s = vim.opt or vim.o
local cmd = vim.cmd
local api = vim.api

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
---@param modes string | table @key map mode, `string` or `table`
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
---@param rhs string | function @source key map or Lua callback
---@param opts? table @key map options
function M.map(modes, lhs, rhs, opts)
    opts = opts or {}
    if opts.noremap == nil then
        opts.noremap = true
    end
    -- vim.keymap.set uses `remap` (inverse of `noremap`)
    local vk_opts = vim.deepcopy(opts)
    if vk_opts.noremap ~= nil then
        vk_opts.remap = not vk_opts.noremap
        vk_opts.noremap = nil
    end
    vim.keymap.set(modes, lhs, rhs, vk_opts)
end

---Create autocommands in a group using the modern Neovim API.
---@param group string
---@param cmds table @list of {event, opts} tables; opts may include pattern, command, callback, desc, etc.
---@param clear? boolean @default false; whether to clear existing autocmds in the group
function M.autocmd(group, cmds, clear)
    clear = clear == nil and false or clear
    if type(cmds) ~= 'table' then
        M.warn('autocmd cmds must be a table')
        return
    end
    local gid = api.nvim_create_augroup(group, { clear = clear })
    for _, c in ipairs(cmds) do
        if type(c) == 'table' then
            local event = c[1] or c.event
            local opts = vim.deepcopy(c)
            opts[1] = nil
            opts.event = nil
            opts.group = gid
            api.nvim_create_autocmd(event, opts)
        else
            M.warn('Each autocmd entry must be a table, got: ' .. type(c))
        end
    end
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

