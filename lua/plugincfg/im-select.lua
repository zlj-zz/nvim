-- macOS implementations auto select
-- deps: im-select (https://github.com/daipeihust/im-select)

-- only enable at macOS
local sysname = vim.loop.os_uname().sysname
if sysname ~= 'Darwin' then
    return
end

local im_select = 'im-select'
local utils = require('utils')

-- check im-select  is usable
if vim.fn.executable(im_select) == 0 then
    local install_cmd = 'brew tap daipeihust/tap && brew install im-select'

    vim.api.nvim_create_autocmd('VimEnter', {
        once = true,
        callback = function()
            utils.warn(
                'im-select not found. Input method auto-switch disabled.\n'
                .. 'Install with: ' .. install_cmd
            )
        end,
    })

    -- 提供 :IMSelectInstall 命令一键安装
    vim.api.nvim_create_user_command('IMSelectInstall', function()
        vim.notify('Running: ' .. install_cmd, vim.log.levels.INFO)
        local job = vim.fn.jobstart({ 'sh', '-c', install_cmd }, {
            on_exit = function(_, code)
                if code == 0 then
                    utils.info('im-select installed. Please restart Neovim.')
                else
                    utils.error('im-select install failed. Run manually:\n' .. install_cmd)
                end
            end,
            on_stderr = function(_, data)
                if data and data[1] ~= '' then
                    vim.notify(table.concat(data, '\n'), vim.log.levels.WARN)
                end
            end,
        })
        if job <= 0 then
            utils.error('Failed to start install job')
        end
    end, { desc = 'Install im-select for input method switching' })

    return
end

-- 默认英文输入法标识（macOS ABC）
local default_im = 'com.apple.keylayout.ABC'

-- 记录上次 Insert 模式使用的输入法
local last_im = default_im

-- 离开 Insert 模式 → 切回英文
vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function()
        -- 先记录当前输入法（如果是中文会被记录）
        local current = vim.fn.system(im_select):gsub('%s+$', '')
        if current ~= default_im then
            last_im = current
        end
        -- 切到英文
        vim.fn.system(im_select .. ' ' .. default_im)
    end,
})

-- 进入 Insert 模式 → 恢复之前的输入法
vim.api.nvim_create_autocmd('InsertEnter', {
    callback = function()
        -- 如果上次记录的是非英文输入法，恢复它
        if last_im and last_im ~= default_im then
            vim.fn.system(im_select .. ' ' .. last_im)
        end
    end,
})

-- 启动/焦点回到 nvim 时确保英文
vim.api.nvim_create_autocmd({ 'VimEnter', 'FocusGained' }, {
    callback = function()
        vim.fn.system(im_select .. ' ' .. default_im)
    end,
})
