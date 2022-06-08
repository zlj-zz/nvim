local g = vim.g
local fn = vim.fn

g.home_path = fn.expand('<sfile>:p:h')

-- whether running in windows
if fn.has('win32') == 1 or fn.has('win64') == 1  or fn.has('win95') == 1  or fn.has('win16') == 1  then
    g.isWin = 1
else
    g.isWin = 0
end

-- whether running in gui
g.is_gui = fn.has('gui_running')

-- whether use coc plugin
g.useCoc = 1
