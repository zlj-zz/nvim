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
    { 'hiphish/rainbow-delimiters.nvim' },
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

    -- Telescope (non-Windows only)
    {
        'nvim-telescope/telescope.nvim',
        cond = function() return g.isWin == 0 end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = cfg('plugincfg.telescope'),
    },
    {
        'stevearc/aerial.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        config = cfg('plugincfg.aerial'),
        cmd = { 'AerialToggle', 'AerialOpen', 'AerialNavToggle' },
    },

    -- Style
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                flavour = 'mocha',
            })
            vim.cmd.colorscheme('catppuccin')
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            vim.opt.laststatus = 2
            require('lualine').setup({
                options = {
                    theme = 'auto',
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
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = cfg('plugincfg.which-key'),
    },
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('trouble').setup({})
        end,
        cmd = { 'Trouble' },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = cfg('plugincfg.gitsigns'),
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = cfg('plugincfg.nvim-tree'),
    },
    {
        'gbprod/yanky.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        config = cfg('plugincfg.yanky'),
    },
    {
        'stevearc/conform.nvim',
        config = cfg('plugincfg.conform'),
    },
    {
        'akinsho/flutter-tools.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim',
        },
        config = cfg('plugincfg.flutter-tools'),
    },

    {
        'vim-scripts/fcitx.vim',
        cond = function() return g.isWin == 0 and vim.fn.filereadable('/usr/bin/fcitx') == 1 end,
    },

    -- LSP (built-in)
    {
        'neovim/nvim-lspconfig',
        config = cfg('plugincfg.lsp'),
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
        },
        config = cfg('plugincfg.cmp'),
    },

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
        colorscheme = { 'catppuccin' },
    },
})
