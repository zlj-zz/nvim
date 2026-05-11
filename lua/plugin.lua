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

require('lazy').setup({
    -- Code language
    { 'hail2u/vim-css3-syntax', ft = {'vim-plug', 'php', 'html', 'javascript', 'css', 'less'} },
    { 'tiagofumo/dart-vim-flutter-layout', ft = {'dart'} },
    { 'dart-lang/dart-vim-plugin', ft = {'dart'}, config = cfg('plugincfg.dart-vim') },
    { 'f-person/pubspec-assist-nvim', ft = {'pubspec.yaml'} },

    -- Editor Enhancement
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            local ok, configs = pcall(require, 'nvim-treesitter.configs')
            if not ok then
                return
            end
            configs.setup({
                ensure_installed = {
                    'python', 'lua', 'vim', 'vimdoc',
                    'javascript', 'typescript',
                    'vue', 'css', 'html', 'scss',
                    'json', 'yaml',
                    'dart', 'markdown', 'markdown_inline',
                    'c', 'cpp', 'java', 'go',
                    'bash',
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end,
    },
    {
        'luochen1990/rainbow',
        init = function()
            vim.g.rainbow_active = 1
        end,
    },
    { 'jiangmiao/auto-pairs', event = 'VeryLazy', init = function() vim.g.AutoPairsMapCR = 0 end },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        config = function()
            require('ibl').setup({
                indent = { char = '┆' },
                scope = { enabled = true },
                exclude = {
                    filetypes = { 'help', 'terminal', 'alpha', 'lazy' },
                },
            })
        end,
    },
    'RRethy/vim-illuminate',

    -- Editor Tools
    {
        'junegunn/vim-easy-align',
        keys = {
            { 'ga', '<Plug>(EasyAlign)', mode = { 'x', 'n' } },
        },
    },
    {
        'mg979/vim-visual-multi',
        init = function()
            vim.g.VM_leader = { default = ',', visual = ',', buffer = ',' }
            vim.g.VM_maps = {
                ['Find Under'] = '<C-d>',
                ['Find Subword Under'] = '<C-d>',
                ['Find Prev'] = '-',
                ['Find Next'] = '=',
                ['Remove Region'] = 'Q',
                ['Skip Region'] = 'q',
                ["Undo"] = 'u',
                ["Redo"] = '<C-r>',
            }
            vim.g.VM_mouse_mappings = 1
        end,
    },
    'gcmt/wildfire.vim',
    {
        'tpope/vim-commentary',
        config = function()
            vim.keymap.set('n', '<leader>cc', '<Plug>CommentaryLine')
            vim.keymap.set({'n', 'x'}, '<leader>c', '<Plug>Commentary')
        end,
    },
    'AndrewRadev/splitjoin.vim',

    -- Snippets
    'honza/vim-snippets',
    'kana/vim-textobj-user',

    -- Other
    'KabbAmine/vCoolor.vim',
    {
        'junegunn/goyo.vim',
        cmd = {'Goyo'},
        keys = {
            { '<leader>gy', ':Goyo<cr>', mode = '' },
        },
    },

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
    {
        'arcticicestudio/nord-vim',
        priority = 1000,
        init = function()
            vim.g.nord_italic = 1
            vim.g.nord_italic_comments = 1
            vim.g.nord_cursor_line_number_background = 1
        end,
        config = function()
            vim.cmd [[colorscheme nord]]
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            vim.opt.laststatus = 2
            require('lualine').setup({
                options = {
                    theme = 'nord',
                    component_separators = '',
                    section_separators = '',
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                tabline = {
                    lualine_a = { { 'buffers', mode = 2 } },
                    lualine_z = { 'tabs' },
                },
            })
        end,
    },
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
    {
        'dhruvasagar/vim-table-mode',
        cmd = {'TableModeToggle'},
        init = function()
            vim.g.table_mode_cell_text_object_i_map = 'k<Bar>'
        end,
        keys = {
            { '<leader>tm', ':TableModeToggle<cr>', mode = '' },
        },
    },
    { 'mzlogin/vim-markdown-toc', ft = {'gitignore', 'markdown'} },
    {
        'theniceboy/bullets.vim',
        ft = {'markdown'},
        init = function()
            vim.g.bullets_enabled_file_types = { 'markdown', 'text', 'gitcommit', 'scratch' }
        end,
    },
}, {
    ui = {
        border = 'single',
    },
    install = {
        colorscheme = { 'nord' },
    },
})
