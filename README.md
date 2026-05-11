# Neovim Config

Personal Neovim configuration, migrated to **lazy.nvim** + **Lua**.

![demo](https://img-blog.csdnimg.cn/20210303002347402.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NDEwNDk0,size_16,color_FFFFFF,t_70#pic_center)

> Tested on macOS / Linux. Windows support is partial (`g.isWin` checks).

## Requirements

- Neovim >= 0.10
- [Homebrew](https://brew.sh/) (macOS)

Install system dependencies:

```bash
brew install ripgrep gopls ctags node python3
```

Or use the bundled installer (macOS / Linux):

```bash
lua tools/install-dependent.lua
```

Install Python & Node packages:

```bash
pip3 install pynvim
npm install -g neovim
```

Install a [Nerd Font](https://www.nerdfonts.com/) for icons (optional but recommended):

```bash
brew install --cask font-hack-nerd-font
```

After installation, run `:checkhealth` in Neovim.

## Structure

```
.
├── init.vim                  # Entry point
├── lua/
│   ├── env.lua               # Environment, paths, machine-specific config
│   ├── utils.lua             # Utility functions (map, opt, autocmd, etc.)
│   ├── funcs.lua             # Custom functions (browser open, transparent bg, etc.)
│   ├── plugin.lua            # lazy.nvim plugin specs
│   ├── settings/
│   │   ├── init.lua          # Load options + mappings
│   │   ├── options.lua       # Vim options
│   │   └── mappings.lua      # Key mappings
│   └── plugincfg/            # Per-plugin configurations
│       ├── alpha-theme.lua
│       ├── floaterm.lua
│       ├── lsp.lua           # Built-in LSP configs
│       ├── cmp.lua           # nvim-cmp completion
│       ├── telescope.lua
│       └── ...
├── augroups.vim              # Autocmd groups (vimscript)
├── customplugins/            # Local vimscript plugins
│   ├── compile_run.vim
│   ├── md_quickmap.vim
│   └── replace.vim
└── tools/
    └── install-dependent.lua
```

## Plugins

### Core

| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting, folding, indentation |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Built-in LSP configurations |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |

### UI

| Plugin | Purpose |
|--------|---------|
| [catppuccin](https://github.com/catppuccin/nvim) | Color scheme (Catppuccin mocha) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line + tabline |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Startup dashboard |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides with scope highlighting |
| [rainbow-delimiters.nvim](https://github.com/hiphish/rainbow-delimiters.nvim) | Rainbow parentheses (Treesitter) |

### Editor

| Plugin | Purpose |
|--------|---------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder (files, grep, buffers, etc.) |
| [vim-commentary](https://github.com/tpope/vim-commentary) | Toggle comments |
| [vim-visual-multi](https://github.com/mg979/vim-visual-multi) | Multi-cursor editing |
| [vim-easy-align](https://github.com/junegunn/vim-easy-align) | Text alignment |
| [wildfire.vim](https://github.com/gcmt/wildfire.vim) | Fast text object selection |
| [splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim) | Split/join code blocks |

### Language Support

| Plugin | Purpose |
|--------|---------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Built-in LSP (Go, Vim, Bash, ...) |
| [flutter-tools.nvim](https://github.com/akinsho/flutter-tools.nvim) | Flutter / Dart (LSP, hot reload, outline) |
| [vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax) | CSS3 syntax |
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | Markdown preview in browser |

### Other

| Plugin | Purpose |
|--------|---------|
| [vim-floaterm](https://github.com/voldikss/vim-floaterm) | Floating terminal |
| [undotree](https://github.com/mbbill/undotree) | Undo history tree |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | Code outline (LSP / Treesitter) |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics / symbols list |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git decorations, blame, hunk actions |
| [yanky.nvim](https://github.com/gbprod/yanky.nvim) | Yank history, telescope integration |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting (prettier, black, stylua, etc.) |
| [goyo.vim](https://github.com/junegunn/goyo.vim) | Distraction-free mode |
| [vim-table-mode](https://github.com/dhruvasagar/vim-table-mode) | Markdown table editing |

## Key Mappings

`<LEADER>` is set to `<Space>`.

### Basic

| Key | Action |
|-----|--------|
| `S` | Save (`:w`) |
| `Q` | Quit (`:q`) |
| `<C-q>` | Force quit (`:q!`) |
| `Y` | Yank to end of line (`y$`) |
| `<C-a>` | Select all (`ggVG`) |
| `<leader>tr` | Trim trailing whitespace |

### Cursor Movement

| Key | Action |
|-----|--------|
| `K` / `J` | Up / down 5 lines |
| `H` / `L` | Left / right 5 chars |
| `<C-k>` / `<C-j>` | Scroll view up / down 5 lines (cursor stays) |

### Window Management

| Key | Action |
|-----|--------|
| `sk` / `sj` | Horizontal split |
| `sh` / `sl` | Vertical split |
| `tk` / `tj` / `th` / `tl` | Move between windows |
| `<Up>` / `<Down>` / `<Left>` / `<Right>` | Resize window |
| `ck` / `ch` | Rearrange splits |

### Tab / Buffer

| Key | Action |
|-----|--------|
| `tn` | New tab |
| `t-` / `t=` | Previous / next tab |
| `b-` / `b=` | Previous / next buffer |
| `b#` | Last buffer |
| `b1` ~ `b9` | Switch to buffer 1~9 |
| `<m-1>` ~ `<m-9>` | Switch to tab 1~9 |

### Telescope (Search)

| Key | Action |
|-----|--------|
| `,f` | Live grep (search in project) |
| `,h` | Recent files |
| `,b` | Open buffers |
| `,l` | Search in current file |
| `,c` | Command history |
| `,k` | Keymaps |

In telescope pickers, `<C-d>` deletes a buffer (in `:Telescope buffers`).

### Comments

| Key | Action |
|-----|--------|
| `<leader>cc` | Toggle comment (current line) |
| `<leader>c` + motion | Comment motion (e.g. `<leader>cip` for paragraph) |
| Visual `<leader>c` | Comment selected lines |

### LSP (Go files, built-in)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gi` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Show hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>a` | Code action |
| `<leader>qf` | Quick fix |
| `<Tab>` / `<S-Tab>` | Next / prev completion item |
| `<CR>` | Confirm completion |
| `<C-Space>` | Trigger completion |

### Trouble (Diagnostics / Symbols)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle diagnostics panel |
| `<leader>xs` | Toggle symbols panel |

### Gitsigns

| Key | Action |
|-----|--------|
| `[h` / `]h` | Prev / next hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hd` | Diff this file |

### Format (conform.nvim)

| Key | Action |
|-----|--------|
| `<leader>cf` | Format document / selection |

### Yanky

| Key | Action |
|-----|--------|
| `<space>y` | Yank history (Telescope) |
| `<c-p>` / `<c-n>` | Cycle yank history after paste |

### Flutter

| Key | Action |
|-----|--------|
| `<leader>fr` | Flutter run |
| `<leader>fR` | Flutter restart |
| `<leader>fq` | Flutter quit |
| `<leader>fo` | Toggle Flutter outline |
| `<leader>fd` | Flutter DevTools |
| `<leader>fe` | Flutter emulators |

### Other

| Key | Action |
|-----|--------|
| `tt` | Toggle file tree (nvim-tree) |
| `<c-t>` | Toggle floating terminal |
| `<f4>` | Toggle transparent background |
| `<leader>z` | Toggle full screen (zoom window) |
| `<leader>go` | Open current file in browser |
| `<leader>sc` | Toggle spell check |
| `<leader>pm` | Toggle paste mode |
| `<leader>fc` | Find git conflict markers |
| `<leader><cr>` | Clear search highlight |
| `<leader>gy` | Toggle Goyo (focus mode) |
| `<leader>tm` | Toggle table mode |
| `ga` | Align text (visual/normal) |
| `<c-d>` | Select next occurrence (multi-cursor) |
| `ga` + `<symbol>` | Easy align around symbol |

## Built-in LSP Setup

All language servers are managed via built-in LSP.

Install language servers:

```bash
# Go
brew install gopls

# Lua
brew install lua-language-server

# Python
npm install -g pyright

# Vimscript, Bash
npm install -g vim-language-server bash-language-server

# HTML, CSS, JSON (single package)
npm install -g vscode-langservers-extracted

# TypeScript
npm install -g typescript-language-server

# YAML
npm install -g yaml-language-server

# Swift (macOS, comes with Xcode CLI)
xcode-select --install
# or: brew install sourcekit-lsp
```

Install formatters (used by conform.nvim):

```bash
brew install stylua shfmt
npm install -g prettier
pip3 install black
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
```

## Configuration for vim

```bash
ln -s xxx/nvim ~/.vim
ln -s xxx/nvim/init.vim ./vimrc
```
