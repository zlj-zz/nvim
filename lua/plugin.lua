local g = vim.g
local utils = require('utils')

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
    { 'tiagofumo/dart-vim-flutter-layout', ft = { 'dart' } },
    { 'dart-lang/dart-vim-plugin',         ft = { 'dart' },        config = cfg('plugincfg.dart-vim') },
    { 'f-person/pubspec-assist-nvim',      ft = { 'pubspec.yaml' } },

    -- Editor Enhancement
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function()
            require('nvim-treesitter').setup({
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
                auto_install = true,
            })

            -- nvim-treesitter-textobjects v1.0+ requires manual keymap binding
            require('nvim-treesitter-textobjects').setup({
                select = { lookahead = true },
                move = { set_jumps = true },
            })

            local ts_select = require('nvim-treesitter-textobjects.select')
            vim.keymap.set({ 'x', 'o' }, 'af', function() ts_select.select_textobject('@function.outer') end)
            vim.keymap.set({ 'x', 'o' }, 'if', function() ts_select.select_textobject('@function.inner') end)
            vim.keymap.set({ 'x', 'o' }, 'ac', function() ts_select.select_textobject('@class.outer') end)
            vim.keymap.set({ 'x', 'o' }, 'ic', function() ts_select.select_textobject('@class.inner') end)
            vim.keymap.set({ 'x', 'o' }, 'aa', function() ts_select.select_textobject('@parameter.outer') end)
            vim.keymap.set({ 'x', 'o' }, 'ia', function() ts_select.select_textobject('@parameter.inner') end)
            vim.keymap.set({ 'x', 'o' }, 'al', function() ts_select.select_textobject('@loop.outer') end)
            vim.keymap.set({ 'x', 'o' }, 'il', function() ts_select.select_textobject('@loop.inner') end)
            vim.keymap.set({ 'x', 'o' }, 'ab', function() ts_select.select_textobject('@block.outer') end)
            vim.keymap.set({ 'x', 'o' }, 'ib', function() ts_select.select_textobject('@block.inner') end)

            local ts_move = require('nvim-treesitter-textobjects.move')
            vim.keymap.set({ 'n', 'x' }, ']f', function() ts_move.goto_next_start('@function.outer') end)
            vim.keymap.set({ 'n', 'x' }, ']c', function() ts_move.goto_next_start('@class.outer') end)
            vim.keymap.set({ 'n', 'x' }, '[f', function() ts_move.goto_previous_start('@function.outer') end)
            vim.keymap.set({ 'n', 'x' }, '[c', function() ts_move.goto_previous_start('@class.outer') end)

            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end,
    },
    { 'hiphish/rainbow-delimiters.nvim', event = 'VeryLazy' },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup({
                check_ts = true,
                ts_config = {
                    lua = { 'string' },
                    javascript = { 'template_string' },
                },
                disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
            })
        end,
    },
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
    { 'RRethy/vim-illuminate',           event = 'VeryLazy' },

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
    {
        'tpope/vim-commentary',
        config = function()
            vim.keymap.set('n', '<leader>cc', '<Plug>CommentaryLine')
            vim.keymap.set({ 'n', 'x' }, '<leader>c', '<Plug>Commentary')
        end,
    },
    'AndrewRadev/splitjoin.vim',

    -- Snippets
    'kana/vim-textobj-user',

    -- Other
    {
        'junegunn/goyo.vim',
        cmd = { 'Goyo' },
        keys = {
            { '<leader>gy', ':Goyo<cr>', mode = '' },
        },
    },

    -- File Manager / Terminal
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        config = cfg('plugincfg.toggleterm'),
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('alpha').setup(require('plugincfg.alpha-theme').config)
        end,
    },
    { 'mbbill/undotree',          config = cfg('plugincfg.undotree'), cmd = { 'UndotreeToggle' } },

    -- Loom (local)
    {
        'zlj-zz/loom.nvim',
        dir = utils.lazy_safe_dif('~/projects/loom.nvim'),
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = cfg('plugincfg.loom'),
    },

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
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').setup({})
            vim.cmd.colorscheme('nordic')
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
        'Isrothy/neominimap.nvim',
        version = "v3.x.x",
        lazy = false,
        init = function()
            -- The following options are recommended when layout == "float"
            vim.opt.wrap = false
            vim.opt.sidescrolloff = 36 -- Set a large value

            vim.g.neominimap = {
                auto_enable = true,
                width = 15,
                exclude_filetypes = { 'help', 'alpha', 'lazy', 'mason' },
            }
        end,
        keys = {
            { '<leader>nm', '<cmd>Neominimap Toggle<cr>',  desc = 'Toggle minimap' },
            { '<leader>nr', '<cmd>Neominimap Refresh<cr>', desc = 'Refresh minimap' },
        },
    },
    -- Disabled: which-key popups interrupt fast typing flow.
    -- {
    --     'folke/which-key.nvim',
    --     event = 'VeryLazy',
    --     config = cfg('plugincfg.which-key'),
    -- },
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
        ft = { 'dart' },
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

    -- Local plugin: agent-bridge
    {
        dir = vim.fn.stdpath('config') .. '/lua/agent-bridge',
        config = function()
            require('agent-bridge').setup()
        end,
    },

    -- AI completion
    {
        'supermaven-inc/supermaven-nvim',
        event = 'VeryLazy',
        config = function()
            require('supermaven-nvim').setup({
                keymaps = {
                    accept_suggestion = '<C-l>',
                    -- clear_suggestion = '<C-\\>',
                    accept_word = '<C-j>',
                },
                ignore_filetypes = { 'bigfile', 'snacks_input', 'snacks_notif' },
                color = {
                    suggestion_color = '#7c7c7c',
                    cterm = 244,
                },
                disable_inline_completion = false,
            })
        end,
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
        ft = { 'markdown' },
        config = cfg('plugincfg.markdownpreview'),
    },
    {
        'dhruvasagar/vim-table-mode',
        cmd = { 'TableModeToggle' },
        init = function()
            vim.g.table_mode_cell_text_object_i_map = 'k<Bar>'
        end,
        keys = {
            { '<leader>tm', ':TableModeToggle<cr>', mode = '' },
        },
    },
    { 'mzlogin/vim-markdown-toc', ft = { 'gitignore', 'markdown' } },
    {
        'theniceboy/bullets.vim',
        ft = { 'markdown' },
        init = function()
            vim.g.bullets_enabled_file_types = { 'markdown', 'text', 'gitcommit', 'scratch' }
        end,
    },
}, {
    ui = {
        border = 'single',
    },
    install = {
        colorscheme = { 'nordic' },
    },
})

-- macOS input method auto-switch (no plugin download, uses system im-select)
require('plugincfg.im-select')
