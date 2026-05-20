local M = {}

local function get_greeting(name)
    local hour = tonumber(os.date("%H"))
    local greetings = {
        [1] = "Sleep well",
        [2] = "Good morning",
        [3] = "Good afternoon",
        [4] = "Good evening",
        [5] = "Good night",
    }
    local idx
    if hour == 23 or hour < 7 then
        idx = 1
    elseif hour < 12 then
        idx = 2
    elseif hour < 18 then
        idx = 3
    elseif hour < 22 then
        idx = 4
    else
        idx = 5
    end
    return greetings[idx] .. ", " .. name
end

local function get_footer()
    local stats = require('lazy').stats()
    local plugins_str = stats.loaded .. "/" .. stats.count .. " plugins loaded"
    local ver = vim.version()
    local nvim_ver = "v" .. ver.major .. "." .. ver.minor .. "." .. ver.patch
    return get_greeting("zachary") .. "  " .. plugins_str .. "  " .. nvim_ver
end

require('dashboard').setup({
    theme = 'hyper',
    config = {
        header = require('headers').showdow,
        shortcut = {
            { desc = 'New file',       icon = ' ', group = 'Number',   action = 'ene',                                    key = 'e' },
            { desc = 'Sync plugins',   icon = ' ', group = 'String',   action = 'Lazy sync',                              key = 's' },
            { desc = 'Configuration',  icon = ' ', group = 'Operator', action = 'e $MYVIMRC | cd %:p:h | pwd',            key = 'c' },
            { desc = 'Quit',           icon = '󰅚 ', group = 'Keyword',  action = 'qa',                                     key = 'q' },
        },
        packages = { enable = true },
        project = { enable = false },
        mru = { limit = 10, cwd_only = true, label = 'MRU ' .. vim.fn.getcwd() },
        footer = { get_footer() },
    },
})

return M
