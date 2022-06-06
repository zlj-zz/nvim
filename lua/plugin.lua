local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
                                  install_path})
end

local g = vim.g

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Code language
    use 'elzr/vim-json'
    use {
        'hail2u/vim-css3-syntax',
        ft = {'vim-plug', 'php', 'html', 'javascript', 'css', 'less'}
    }
    use {
        'MaxMEllon/vim-jsx-pretty',
        ft = {'vim-plug', 'php', 'html', 'javascript', 'css', 'less'}
    }
    use {
        'jelera/vim-javascript-syntax',
        ft = {'vim-plug', 'php', 'html', 'javascript', 'css', 'less'}
    }
    use {
        'tmhedberg/SimpylFold',
        ft = {'python', 'vim-plug'}
    }
    use {
        'Vimjas/vim-python-pep8-indent',
        ft = {'python', 'vim-plug'}
    }
    use 'tweekmonster/braceless.vim'
    use {
        'tiagofumo/dart-vim-flutter-layout',
        ft = {'dart'}
    }
    use {
        'dart-lang/dart-vim-plugin',
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
    use 'scrooloose/nerdcommenter'
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
    use 'voldikss/vim-floaterm'
    use 'mhinz/vim-startify'
    use {
        'mbbill/undotree',
        cmd = {'UndotreeToggle'}
    }

    -- Style
    use 'arcticicestudio/nord-vim'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'

    -- COC
    if g.useCoc == 1 then
        use {'neoclide/coc.nvim', branch='release'}
        use 'wellle/tmux-complete.vim'
    end

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
