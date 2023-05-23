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
g.isWin =
    fn.has('win32') == 1 and 1 or fn.has('win64') == 1 and 1 or fn.has('win95') == 1 and 1 or fn.has('win16') == 1 and 1 or
        0

-- whether running in gui
g.is_gui = fn.has('gui_running')

-- whether use coc plugin
g.useCoc = 1

-----------------------------------------------------------------------------------------

-- Create a '_machine_specific.vim' file to adjust machine specific stuff
local specific_file = g.nvim_path .. '/_machine_specific.vim'
local specific_content = {'let g:python3_host_prog=""', 'let g:python_host_prog=""'}

if fn.empty(fn.glob(specific_file)) == 1 then
    for _, line in pairs(specific_content) do
        vim.cmd('silent! !echo -e ' .. line .. ' >> ' .. specific_file)
    end
    vim.cmd('e ' .. specific_file)
else
    -- Some special configurations for different computers.
    vim.cmd('source ' .. specific_file)
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
