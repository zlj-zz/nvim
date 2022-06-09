local M = {}

local browsers = {
    chrome = 'open -a Google Chrome ',
    firefox = 'open -a Firefox '
}

M.open_curr_on_browser = function()

    vim.cmd('silent !' .. browsers.firefox .. vim.fn.expand('%:p'))

end

return M
