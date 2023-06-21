local fn = vim.fn
local g = vim.g

-- Check `Packer` wether installed, or installing.
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
                                  install_path})
end

local cfg_partten = [[require('%s')]]

return require('packer').startup({
    function(use)

        ---Help to load local plugin file.
        ---@param op table
        local local_use = function(op)

            local home = op.home or g.nvim_path .. '/customplugins'
            local use_source = op.use_source or false

            op[1] = string.format('%s/%s', home, op[1])

            if use_source then
                vim.cmd('source ' .. op[1])
            else
                use({op[1], op.opts or {}})
            end
        end

        -- Local plugin
        local_use {
            'md_quickmap.vim',
            use_source = true
        }
        local_use {
            'compile_run.vim',
            use_source = true
        }
        local_use {
            'tools.vim',
            use_source = true
        }

        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        -- Code language
        use {
            'hail2u/vim-css3-syntax',
            ft = {'vim-plug', 'php', 'html', 'javascript', 'css', 'less'}
        }
        --use {
            --'MaxMEllon/vim-jsx-pretty',
            --ft = {'vim-plug', 'php', 'html', 'javascript', 'css', 'less'}
        --}
        --use {
            --'jelera/vim-javascript-syntax',
            --ft = {'vim-plug', 'php', 'html', 'javascript', 'css', 'less'}
        --}
        use {
            'tmhedberg/SimpylFold',
            ft = {'python', 'vim-plug'}
        }
        use {
            'Vimjas/vim-python-pep8-indent',
            ft = {'python', 'vim-plug'}
        }
        --use 'tweekmonster/braceless.vim'
        use {
            'tiagofumo/dart-vim-flutter-layout',
            ft = {'dart'}
        }
        use {
            'dart-lang/dart-vim-plugin',
            config = cfg_partten:format('plugincfg.dart-vim'),
            ft = {'dart'}
        }
        use {
            'f-person/pubspec-assist-nvim',
            ft = {'pubspec.yaml'}
        }

        -- Editor Enhancement
        use 'luochen1990/rainbow'
        use 'jiangmiao/auto-pairs'
        use 'Yggdroot/indentLine'
        use 'RRethy/vim-illuminate'

        -- Editor Tools
        use 'junegunn/vim-easy-align'
        use 'mg979/vim-visual-multi'
        use 'gcmt/wildfire.vim'
        use {
            'scrooloose/nerdcommenter',
            config = cfg_partten:format('plugincfg.nerdcommenter')
        }
        use 'AndrewRadev/splitjoin.vim'

        -- Snippets
        use 'honza/vim-snippets'
        use 'kana/vim-textobj-user'

        -- Other
        use 'KabbAmine/vCoolor.vim'
        use {
            'junegunn/goyo.vim',
            cmd = {'Goyo'}
        }

        -- File Manager
        use {
            'voldikss/vim-floaterm',
            config = cfg_partten:format('plugincfg.floaterm')
        }
        use {
            'mhinz/vim-startify',
            config = cfg_partten:format('plugincfg.startify')
        }
        use {
            'mbbill/undotree',
            setup = cfg_partten:format('plugincfg.undotree'),
            cmd = {'UndotreeToggle'}
        }
        if g.isWin == 0 then
            use {
                'junegunn/fzf',
                run = function()
                    fn['fzf#install'](0)
                end
            }
            use {
                'junegunn/fzf.vim',
                config = cfg_partten:format('plugincfg.fzf')
            }
            use {
                'majutsushi/tagbar',
                setup = cfg_partten:format('plugincfg.tagbar'),
                cmd = {'TagbarToggle'}
            }
            -- use 'liuchengxu/vista.vim'
        end

        -- Style
        -- use 'sainnhe/sonokai'
        -- use 'sts10/vim-pink-moon'
        --use 'ajmwagar/vim-deus'
        use 'arcticicestudio/nord-vim'
        use 'vim-airline/vim-airline'
        use 'vim-airline/vim-airline-themes'
        if g.isWin == 0 then
            use 'ryanoasis/vim-devicons'
            if fn.filereadable('/usr/bin/fcitx') == 1 then
                use 'vim-scripts/fcitx.vim'
            end
        end

        -- COC
        if g.useCoc == 1 then
            use {
                'neoclide/coc.nvim',
                branch = 'release',
                config = cfg_partten:format('plugincfg.coc')
            }
            use 'wellle/tmux-complete.vim'
        end

        -- Markdown
        use {
            'iamcco/markdown-preview.nvim',
            run = function()
                fn['mkdp#util#install_sync']()
            end,
            ft = {'markdown', 'vim-plug'},
            config = cfg_partten:format('plugincfg.markdownpreview')
        }
        use {
            'dhruvasagar/vim-table-mode',
            cmd = {'TableModeToggle'}
        }
        use {
            'mzlogin/vim-markdown-toc',
            ft = {'gitignore', 'markdown'}
        }
        use {
            'theniceboy/bullets.vim',
            ft = {'markdown'}
        }

        -- Load some common plugins config
        require('plugincfg.style')
        require('plugincfg.allcommon')

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end
    end,

    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({
                    border = 'single'
                })
            end
        }
    }
})

-- "Plug 'bling/vim-bufferline'
-- "Plug 'mg979/vim-xtabline'     " top tabline
-- "Plug 'scrooloose/nerdtree',{'on': 'NERDTreeToggle'} " NerdTree, files tree to manage file
-- "Plug 'Chiel92/vim-autoformat',{'on': 'Autoformat'}
-- "Plug 'jaxbot/semantic-highlight.vim' " where every variable is a different color
-- "Plug 'SirVer/ultisnips' " Track the engine.
-- "Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
-- "Plug 'junegunn/vim-after-object' " da= to delete what's after =

