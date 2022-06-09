local g = vim.g
local fn = vim.fn

-- neovim home path
g.home_path = fn.expand('<sfile>:p:h')

-- whether running in windows
g.isWin =
    fn.has('win32') == 1 and 1 or fn.has('win64') == 1 and 1 or fn.has('win95') == 1 and 1 or fn.has('win16') == 1 and 1 or
        0

-- whether running in gui
g.is_gui = fn.has('gui_running')

-- whether use coc plugin
g.useCoc = 1

-- Create a '_machine_specific.vim' file to adjust machine specific stuff
local specific_file = g.home_path .. '/_machine_specific.vim'
local specific_content = {'let g:python3_host_prog=""',
                          'let g:python_host_prog=""'}

if fn.empty(fn.glob(specific_file)) == 1 then
    for _, line in pairs(specific_content) do
        vim.cmd('silent! !echo -e ' .. line .. ' >> ' .. specific_file)
    end
    vim.cmd('e ' .. specific_file)
else
    -- Some special configurations for different computers.
    vim.cmd('source ' .. specific_file)
end
