local M = {}

local config_mod = require('agent-bridge.config')
local context_mod = require('agent-bridge.context')
local ui_mod = require('agent-bridge.ui')
local sender_mod = require('agent-bridge.sender')
local utils = require('utils')

function M.setup(opts)
    local config = config_mod.merge(opts)

    utils.map({ 'n', 'x' }, config.keymap, function()
        M.open(config)
    end)
end

function M.open(config)
    local ctx = context_mod.get_selection()
    if not ctx.code or ctx.code == '' then
        utils.warn('agent-bridge: no code context')
        return
    end

    ui_mod.open(ctx, config, function(prompt, mode)
        sender_mod.send(prompt, mode, config)
    end)
end

return M
