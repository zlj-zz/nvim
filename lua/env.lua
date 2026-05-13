local utils = require('utils')
local g = vim.g
local fn = vim.fn
local uv = vim.uv or vim.loop

-----------------------------------------------------------------------------------------
-- Global parameters.
-----------------------------------------------------------------------------------------

-- neovim home path
g.home_path = os.getenv('HOME') or uv.os_homedir()
g.nvim_path = fn.stdpath('config')

-- whether running in windows
g.isWin = 0
local win_lis = {'win32', 'win64', 'win95', 'win16'}
for _, v in pairs(win_lis) do
    if fn.has(v) == 1 then g.isWin = 1; break end
end

-- whether running in gui
g.is_gui = fn.has('gui_running')

-- Ensure Homebrew binaries are in PATH (for GUI-launched nvim on macOS)
if uv.fs_stat('/opt/homebrew/bin') then
    vim.env.PATH = '/opt/homebrew/bin:' .. (vim.env.PATH or '')
end

-----------------------------------------------------------------------------------------

-- Create a '_machine_specific.vim' file to adjust machine specific stuff
-- Some special configurations for different computers.
local specific_file = g.nvim_path .. '/lua/_machine_specific.lua'
local specific_file_template = [[
local g = vim.g

g.python3_host_prog = ''
g.python_host_prog = ''
]]

if uv.fs_stat(specific_file) == nil then
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
local temp_dir = g.home_path .. '/.tmp'

if uv.fs_stat(temp_dir) == nil then
    for _, item in pairs(temps) do
        fn.mkdir(temp_dir .. '/' .. item, 'p')
    end
end
utils.opt('backupdir', g.home_path .. '/.tmp/backup')
utils.opt('directory', g.home_path .. '/.tmp/backup')
