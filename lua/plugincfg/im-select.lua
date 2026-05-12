-- macOS input method auto-switch
-- deps: im-select (https://github.com/daipeihust/im-select)

local uv = vim.uv or vim.loop
if uv.os_uname().sysname ~= 'Darwin' then
    return
end

local im_select = 'im-select'
local utils = require('utils')

-- check im-select is usable
if vim.fn.executable(im_select) == 0 then
    local install_cmd = 'brew tap daipeihust/tap && brew install im-select'

    utils.autocmd('IMSelectMissing', {
        { 'VimEnter', once = true, callback = function()
            utils.warn(
                'im-select not found. Input method auto-switch disabled.\n'
                .. 'Install with: ' .. install_cmd
            )
        end },
    }, true)

    vim.api.nvim_create_user_command('IMSelectInstall', function()
        utils.info('Running: %s', install_cmd)
        local job = vim.fn.jobstart({ 'sh', '-c', install_cmd }, {
            on_exit = function(_, code)
                if code == 0 then
                    utils.info('im-select installed. Please restart Neovim.')
                else
                    utils.error('im-select install failed. Run manually:\n%s', install_cmd)
                end
            end,
            on_stderr = function(_, data)
                if data and #data > 0 and data[1] ~= '' then
                    utils.warn('%s', table.concat(data, '\n'))
                end
            end,
        })
        if job <= 0 then
            utils.error('Failed to start install job')
        end
    end, { desc = 'Install im-select for input method switching' })

    return
end

local default_im = 'com.apple.keylayout.ABC'
local last_im = default_im

local function im_select_set(im)
    vim.fn.jobstart({ im_select, im }, { detach = true })
end

local function im_select_get(callback)
    local output = {}
    vim.fn.jobstart({ im_select }, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.list_extend(output, data)
            end
        end,
        on_exit = function()
            local result = table.concat(output, ''):gsub('%s+$', '')
            callback(result)
        end,
    })
end

utils.autocmd('IMSelect', {
    { 'InsertLeave', callback = function()
        im_select_get(function(current)
            if current ~= default_im then
                last_im = current
            end
            im_select_set(default_im)
        end)
    end },
    { 'InsertEnter', callback = function()
        if last_im ~= default_im then
            im_select_set(last_im)
        end
    end },
    { { 'VimEnter', 'FocusGained' }, callback = function()
        im_select_set(default_im)
    end },
}, true)
