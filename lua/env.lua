local g = vim.g
local fn = vim.fn

g.home_path = fn.expand('<sfile>:p:h')

-- whether running in windows
g.isWin =
    fn.has('win32') == 1 and 1 or fn.has('win64') == 1 and 1 or fn.has('win95') == 1 and 1 or fn.has('win16') == 1 and 1 or
        0

-- whether running in gui
g.is_gui = fn.has('gui_running')

-- whether use coc plugin
g.useCoc = 1
