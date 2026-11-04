require('config.env')
require('config.options')
require('config.keymaps')
require('config.autocmds')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = { { import = 'plugins' } },
    ui = { border = 'single' },
    install = { colorscheme = { 'nordfox' } },
})

-- Apply colorscheme after nightfox is on the rtp.
require('config.theme')
require('config.im_select')

vim.cmd('nohlsearch')
