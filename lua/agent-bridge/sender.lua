local M = {}
local utils = require('utils')
local result_mod = require('agent-bridge.result')

M.SENDERS = { 'auto', 'tmux', 'claude', 'clipboard' }

function M.detect_available()
    if vim.fn.executable('tmux') == 1 then
        if M._find_tmux_claude_pane() then
            return 'tmux'
        end
    end
    if vim.fn.executable('claude') == 1 then
        return 'claude'
    end
    if vim.fn.executable('pbcopy') == 1 or vim.fn.executable('xclip') == 1 then
        return 'clipboard'
    end
    return nil
end

function M.send(prompt, mode, opts)
    opts = opts or {}
    if mode == 'auto' then
        mode = M.detect_available() or 'clipboard'
    end

    local fn = M['_send_' .. mode]
    if fn then
        fn(prompt, opts)
    else
        utils.warn('agent-bridge: no available sender')
    end
end

function M._find_tmux_claude_pane()
    local ok, panes = pcall(vim.fn.system,
        "tmux list-panes -a -F '#{pane_id} #{pane_current_command}' 2>/dev/null")
    if not ok then
        return nil
    end
    for line in panes:gmatch('[^\r\n]+') do
        local id, cmd = line:match('^(%S+)%s+(%S+)')
        if cmd == 'claude' then
            return id
        end
    end
    return nil
end

function M._send_tmux(prompt)
    local target = M._find_tmux_claude_pane()
    if not target then
        utils.warn('agent-bridge: no tmux pane running claude, falling back')
        M.send(prompt, 'claude')
        return
    end

    -- tmux send-keys treats each argument as a single key sequence.
    -- A multi-line prompt must be split so newlines are sent as real Enter keys.
    local lines = vim.split(prompt, '\n')
    local args = { 'tmux', 'send-keys', '-t', target }
    for _, line in ipairs(lines) do
        table.insert(args, line)
        table.insert(args, 'Enter')
    end

    vim.fn.jobstart(args, {
        detach = true,
        on_exit = function(_, code)
            if code == 0 then
                utils.info('Sent to tmux pane %s (%d lines)', target, #lines)
            else
                utils.warn('tmux send-keys failed')
            end
        end,
    })
end

function M._send_claude(prompt, opts)
    local output = {}
    local stderr = {}
    local timeout_ms = opts.claude_timeout_ms

    utils.info('Dispatching to claude --continue...')

    local timer_id
    local job_id = vim.fn.jobstart({ 'claude', '-p', prompt, '--continue' }, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            if not data then
                return
            end
            for _, line in ipairs(data) do
                if line ~= '' then
                    table.insert(output, line)
                end
            end
        end,
        on_stderr = function(_, data)
            if not data then
                return
            end
            for _, line in ipairs(data) do
                if line ~= '' then
                    table.insert(stderr, line)
                end
            end
        end,
        on_exit = function(_, code)
            if timer_id then
                timer_id:stop()
                timer_id:close()
                timer_id = nil
            end
            vim.schedule(function()
                local text = table.concat(output, '\n')
                local err = table.concat(stderr, '\n')
                if code ~= 0 then
                    if err == '' then
                        err = 'claude exited with code ' .. code
                    end
                    result_mod.show('Agent Error', err, true)
                    return
                end
                if text == '' then
                    if err ~= '' then
                        result_mod.show('Agent Error', err, true)
                    else
                        utils.warn('claude returned empty output')
                    end
                    return
                end
                result_mod.show('Agent Result', text, false)
            end)
        end,
    })

    timer_id = vim.defer_fn(function()
        if job_id and vim.fn.jobwait({ job_id }, 0)[1] == -1 then
            vim.fn.jobstop(job_id)
            vim.schedule(function()
                result_mod.show('Agent Error',
                    'claude --continue timed out after ' .. (timeout_ms / 1000) .. 's', true)
            end)
        end
    end, timeout_ms)
end

function M._send_clipboard(prompt)
    if vim.fn.executable('pbcopy') == 1 then
        vim.fn.jobstart({ 'pbcopy' }, { writer = prompt, detach = true })
    elseif vim.fn.executable('xclip') == 1 then
        vim.fn.jobstart({ 'xclip', '-selection', 'clipboard' }, {
            writer = prompt,
            detach = true,
        })
    else
        vim.fn.setreg('+', prompt)
    end
    utils.info('Copied to clipboard. Paste into your agent chat.')
end

function M.cycle(current)
    for i, s in ipairs(M.SENDERS) do
        if s == current then
            return M.SENDERS[i % #M.SENDERS + 1]
        end
    end
    return M.SENDERS[1]
end

return M
