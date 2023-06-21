local utils = require('utils')
local g = vim.g
local fn = vim.fn

-----------------------------------------------------------------------------------------
-- Global parameters.
-----------------------------------------------------------------------------------------

-- neovim home path
g.home_path = vim.api.nvim_exec('echo $HOME', true)
g.nvim_path = fn.expand('<sfile>:p:h')

-- whether running in windows
g.isWin = 0
local win_lis = {'win32', 'win64', 'win95', 'win16'}
for _, v in pairs(win_lis) do
    if fn.has(v) == 1 then g.isWin = 1; break end
end

-- whether running in gui
g.is_gui = fn.has('gui_running')

-- whether use coc plugin
g.useCoc = 1

-----------------------------------------------------------------------------------------

-- Create a '_machine_specific.vim' file to adjust machine specific stuff
-- Some special configurations for different computers.
local specific_file = g.nvim_path .. '/lua/_machine_specific.lua'
local specific_file_template = [[
local g = vim.g

g.python3_host_prog = ''
g.python_host_prog = ''
]]

if fn.empty(fn.glob(specific_file)) == 1 then
    local f, err = io.open(specific_file, 'w')
    if not f then
        utils.warn('Can not create "_machine_specific"')
    else
        f:write(specific_file_template)
        f:close()

        vim.cmd('e ' .. specific_file)
    end

else
    require('_machine_specific')
end

-- create temp folder, create undo folder if have plugin persistent_undo
-- path = `~/.tmp`
local temps = {'backup', 'undo', 'sessions'}
local temp_dir = g.home_path .. '/.temp'

if fn.empty(fn.glob(temp_dir)) == 1 then
    for _, item in pairs(temps) do
        vim.cmd('silent !mkdir -p ' .. temp_dir .. '/' .. item)
    end
end
utils.opt('backupdir', g.home_path .. '/.tmp/backup')
utils.opt('directory', g.home_path .. '/.tmp/backup')
