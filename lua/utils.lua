local M = {}

local o_s = vim.opt or vim.o

function M.warn(s, ...)
    local msg = string.format(s, ...)
    vim.defer_fn(function()
        vim.notify(msg, vim.log.levels.WARN)
    end, 50)
end

function M.error(s, ...)
    local msg = string.format(s, ...)
    vim.defer_fn(function()
        vim.notify(msg, vim.log.levels.ERROR)
    end, 50)
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

---Check if a path is a directory
---@param p string
---@return string | nil
function M.lazy_safe_dif(p)
    local local_path = vim.fn.expand(p)
    if vim.fn.isdirectory(local_path) then
        return local_path
    end
    return nil
end

return M
