local g = vim.g

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Source local vimscript plugins
for _, name in ipairs({
    'md_quickmap.vim',
    'compile_run.vim',
    'replace.vim',
}) do
    vim.cmd('source ' .. g.nvim_path .. '/customplugins/' .. name)
end

-- Helper: wrap a require call in a zero-arg function
local function cfg(mod)
    return function() require(mod) end
end

-- Load common configs that set globals/mappings before lazy.nvim resolves specs
require('plugincfg.style')
require('plugincfg.other-more')

require('lazy').setup({
    -- Code language
    { 'hail2u/vim-css3-syntax', ft = {'vim-plug', 'php', 'html', 'javascript', 'css', 'less'} },
    { 'tmhedberg/SimpylFold', ft = {'python', 'vim-plug'} },
    { 'Vimjas/vim-python-pep8-indent', ft = {'python', 'vim-plug'} },
    { 'tiagofumo/dart-vim-flutter-layout', ft = {'dart'} },
    { 'dart-lang/dart-vim-plugin', ft = {'dart'}, config = cfg('plugincfg.dart-vim') },
    { 'f-person/pubspec-assist-nvim', ft = {'pubspec.yaml'} },

    -- Editor Enhancement
    'luochen1990/rainbow',
    { 'jiangmiao/auto-pairs', event = 'VeryLazy', init = function() vim.g.AutoPairsMapCR = 0 end },
    'Yggdroot/indentLine',
    'RRethy/vim-illuminate',

    -- Editor Tools
    'junegunn/vim-easy-align',
    'mg979/vim-visual-multi',
    'gcmt/wildfire.vim',
    { 'scrooloose/nerdcommenter', config = cfg('plugincfg.nerdcommenter') },
    'AndrewRadev/splitjoin.vim',

    -- Snippets
    'honza/vim-snippets',
    'kana/vim-textobj-user',

    -- Other
    'KabbAmine/vCoolor.vim',
    { 'junegunn/goyo.vim', cmd = {'Goyo'} },

    -- File Manager / Terminal
    { 'voldikss/vim-floaterm', config = cfg('plugincfg.floaterm') },
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('alpha').setup(require('plugincfg.alpha-theme').config)
        end,
    },
    { 'mbbill/undotree', init = cfg('plugincfg.undotree'), cmd = {'UndotreeToggle'} },

    -- FZF & Tagbar (non-Windows only)
    {
        'junegunn/fzf',
        cond = function() return g.isWin == 0 end,
        build = function() vim.fn['fzf#install'](0) end,
    },
    {
        'junegunn/fzf.vim',
        cond = function() return g.isWin == 0 end,
        config = cfg('plugincfg.fzf'),
    },
    {
        'majutsushi/tagbar',
        cond = function() return g.isWin == 0 end,
        init = cfg('plugincfg.tagbar'),
        cmd = {'TagbarToggle'},
    },

    -- Style
    'arcticicestudio/nord-vim',
    'vim-airline/vim-airline',
    'vim-airline/vim-airline-themes',
    { 'ryanoasis/vim-devicons', cond = function() return g.isWin == 0 end },
    {
        'vim-scripts/fcitx.vim',
        cond = function() return g.isWin == 0 and vim.fn.filereadable('/usr/bin/fcitx') == 1 end,
    },

    -- COC
    {
        'neoclide/coc.nvim',
        cond = function() return g.useCoc == 1 end,
        branch = 'release',
        config = cfg('plugincfg.coc'),
    },
    { 'wellle/tmux-complete.vim', cond = function() return g.useCoc == 1 end },

    -- Markdown
    {
        'iamcco/markdown-preview.nvim',
        build = function() vim.fn['mkdp#util#install_sync']() end,
        ft = {'markdown', 'vim-plug'},
        config = cfg('plugincfg.markdownpreview'),
    },
    { 'dhruvasagar/vim-table-mode', cmd = {'TableModeToggle'} },
    { 'mzlogin/vim-markdown-toc', ft = {'gitignore', 'markdown'} },
    { 'theniceboy/bullets.vim', ft = {'markdown'} },
}, {
    ui = {
        border = 'single',
    },
    install = {
        colorscheme = { 'nord' },
    },
})
