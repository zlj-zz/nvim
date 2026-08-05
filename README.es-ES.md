

# Configuración de Neovim

Configuración personal de Neovim, migrada a **lazy.nvim** + **Lua**.

![demo](https://img-blog.csdnimg.cn/20210303002347402.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NDEwNDk0,size_16,color_FFFFFF,t_70#pic_center)

> Probado en macOS / Linux. El soporte para Windows es parcial (comprobaciones de `g.isWin`).

## Requisitos

- Neovim >= 0.10
- [Homebrew](https://brew.sh/) (macOS)

Instala las dependencias del sistema:

```bash
brew install ripgrep gopls ctags node python3
```

O usa el instalador incluido (macOS / Linux):

```bash
lua tools/install-dependent.lua
```

Instala los paquetes de Python y Node:

```bash
pip3 install pynvim
npm install -g neovim
```

Instala una [Nerd Font](https://www.nerdfonts.com/) para los iconos (opcional pero recomendado):

```bash
brew install --cask font-hack-nerd-font
```

Después de la instalación, ejecuta `checkhealth` en Neovim.

## Estructura

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
│       ├── toggleterm.lua
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

### Núcleo

| Plugin | Propósito |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Administrador de plugins |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Resaltado de sintaxis, plegado, sangría |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Configuraciones LSP integradas |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Motor de autocompletado |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Motor de fragmentos de código (snippets) |

### Interfaz de usuario (UI)

| Plugin | Propósito |
|--------|---------|
| [nordic.nvim](https://github.com/AlexvZyl/nordic.nvim) | Esquema de colores (Nord mejorado) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Línea de estado + línea de pestañas |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Panel de inicio |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Guías de sangría con resaltado de alcance |
| [rainbow-delimiters.nvim](https://github.com/hiphish/rainbow-delimiters.nvim) | Paréntesis arcoíris (Treesitter) |

### Editor

| Plugin | Propósito |
|--------|---------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Buscador difuso (archivos, grep, buffers, etc.) |
| [vim-commentary](https://github.com/tpope/vim-commentary) | Alternar comentarios |
| [vim-visual-multi](https://github.com/mg979/vim-visual-multi) | Edición con múltiples cursores |
| [vim-easy-align](https://github.com/junegunn/vim-easy-align) | Alineación de texto |
| [wildfire.vim](https://github.com/gcmt/wildfire.vim) | Selección rápida de objetos de texto |
| [splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim) | Dividir/unir bloques de código |

### Soporte de idiomas

| Plugin | Propósito |
|--------|---------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP integrado (Go, Vim, Bash, ...) |
| [flutter-tools.nvim](https://github.com/akinsho/flutter-tools.nvim) | Flutter / Dart (LSP, recarga en caliente, árbol de símbolos) |
| [vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax) | Sintaxis CSS3 |
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | Vista previa de Markdown en el navegador |

### Terminal e IA

| Plugin | Propósito |
|--------|---------|
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal (abajo / derecha / flotante) |
| [agent-bridge](lua/agent-bridge) | Envía contexto de código a agentes de IA (Claude / tmux / portapapeles) |
| [supermaven-nvim](https://github.com/supermaven-inc/supermaven-nvim) | Autocompletado de código en línea con IA |

### Otros

| Plugin | Propósito |
|--------|---------|
| [undotree](https://github.com/mbbill/undotree) | Árbol de historial de deshacer |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | Explorador de archivos |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | Esquema de código (LSP / Treesitter) |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Lista de diagnósticos / símbolos |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Decoraciones de Git, blame, acciones de hunk |
| [yanky.nvim](https://github.com/gbprod/yanky.nvim) | Historial de copiado, integración con Telescope |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formateo (prettier, black, stylua, etc.) |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Ventana emergente de descubrimiento de mapeos de teclas |
| [goyo.vim](https://github.com/junegunn/goyo.vim) | Modo sin distracciones |
| [vim-table-mode](https://github.com/dhruvasagar/vim-table-mode) | Edición de tablas Markdown |

## Mapeos de Teclas

`<LEADER>` se establece en `<Space>`.

### Básicos

| Tecla | Acción |
|-----|--------|
| `S` | Guardar (`:w`) |
| `Q` | Salir (`:q`) |
| `<C-q>` | Forzar salida (`:q!`) |
| `Y` | Copiar hasta el final de la línea (`y$`) |
| `<C-a>` | Seleccionar todo (`ggVG`) |
| `<leader>tr` | Eliminar espacios en blanco al final de línea |

### Movimiento del Cursor

| Tecla | Acción |
|-----|--------|
| `K` / `J` | Arriba / abajo 5 líneas |
| `H` / `L` | Izquierda / derecha 5 caracteres |
| `<C-k>` | Desplazar vista arriba 5 líneas (el cursor se mantiene) |

### Gestión de Ventanas

| Tecla | Acción |
|-----|--------|
| `sk` / `sj` | División horizontal |
| `sh` / `sl` | División vertical |
| `tk` / `tj` / `th` / `tl` | Moverse entre ventanas |
| `<Up>` / `<Down>` / `<Left>` / `<Right>` | Redimensionar ventana |
| `ck` / `ch` | Reorganizar divisiones |

### Pestaña / Buffer

| Tecla | Acción |
|-----|--------|
| `tn` | Nueva pestaña |
| `t-` / `t=` | Pestaña anterior / siguiente |
| `b-` / `b=` | Buffer anterior / siguiente |
| `b#` | Último buffer |
| `b1` ~ `b9` | Cambiar al buffer 1~9 |
| `<m-1>` ~ `<m-9>` | Cambiar a la pestaña 1~9 |

### Telescope (Búsqueda)

| Tecla | Acción |
|-----|--------|
| `,f` | Búsqueda en vivo (grep en el proyecto) |
| `,h` | Archivos recientes |
| `,b` | Buffers abiertos |
| `,l` | Buscar en el archivo actual |
| `,c` | Historial de comandos |
| `,k` | Mapeos de teclas |

En los selectores de Telescope, `<C-d>` elimina un buffer (en `:Telescope buffers`).

### Comentarios

| Tecla | Acción |
|-----|--------|
| `<leader>cc` | Alternar comentario (línea actual) |
| `<leader>c` + movimiento | Comentar movimiento (ej. `<leader>cip` para párrafo) |
| Visual `<leader>c` | Comentar líneas seleccionadas |

### LSP (archivos Go, integrado)

| Tecla | Acción |
|-----|--------|
| `gd` | Ir a definición |
| `gr` | Encontrar referencias |
| `gi` | Ir a implementación |
| `gy` | Ir a definición de tipo |
| `K` | Mostrar documentación al pasar el cursor |
| `<leader>rn` | Renombrar símbolo |
| `<leader>a` | Acción de código |
| `<leader>qf` | Solución rápida |
| `<Tab>` / `<S-Tab>` | Siguiente / anterior elemento de autocompletado |
| `<CR>` | Confirmar autocompletado |
| `<C-Space>` | Activar autocompletado |

### Trouble (Diagnósticos / Símbolos)

| Tecla | Acción |
|-----|--------|
| `<leader>xx` | Alternar panel de diagnósticos |
| `<leader>xs` | Alternar panel de símbolos |

### Gitsigns

| Tecla | Acción |
|-----|--------|
| `[h` / `]h` | Hunk anterior / siguiente |
| `<leader>hp` | Vista previa del hunk |
| `<leader>hb` | Ver blame de la línea |
| `<leader>hs` | Preparar (stage) hunk |
| `<leader>hr` | Restablecer hunk |
| `<leader>hd` | Ver diff de este archivo |

### IA (agent-bridge + Supermaven)

| Tecla | Acción |
|-----|--------|
| `<leader>ai` | Abrir ventana flotante de agent-bridge (visual / normal) |
| `<C-s>` | Enviar prompt desde la ventana flotante |
| `<Tab>` (en flotante) | Alternar modo de envío (auto → tmux → claude → portapapeles) |
| `<C-l>` | Aceptar sugerencia de Supermaven |
| `<C-j>` | Aceptar siguiente palabra de Supermaven |
| `<C-\>` | Borrar sugerencia de Supermaven |

### Formateo (conform.nvim)

| Tecla | Acción |
|-----|--------|
| `<leader>cf` | Formatear documento / selección |
| `:FormatToggle` | Alternar formateo al guardar |

### Yanky

| Tecla | Acción |
|-----|--------|
| `<space>y` | Historial de copiado (Telescope) |
| `<c-p>` / `<c-n>` | Alternar historial de copiado después de pegar |

### Flutter

| Tecla | Acción |
|-----|--------|
| `<leader>fr` | Ejecutar Flutter |
| `<leader>fR` | Reiniciar Flutter |
| `<leader>fq` | Detener Flutter |
| `<leader>fo` | Alternar esquema de Flutter |
| `<leader>fd` | DevTools de Flutter |
| `<leader>fe` | Emuladores de Flutter |

### Otros

| Tecla | Acción |
|-----|--------|
| `tt` | Alternar árbol de archivos (nvim-tree) |
| `<c-t>` | Alternar terminal inferior (toggleterm) |
| `<C-l>` | Alternar terminal lateral derecho |
| `<A-1>` ~ `<A-3>` | Alternar terminal 1~3 |
| `<Esc><Esc>` (en terminal) | Salir del modo terminal |
| `<f4>` | Alternar fondo transparente |
| `<leader>z` | Alternar pantalla completa (zoom de ventana) |
| `<leader>go` | Abrir archivo actual en el navegador |
| `<leader>sc` | Alternar corrector ortográfico |
| `<leader>pm` | Alternar modo pegado |
| `<leader>fc` | Buscar marcadores de conflicto de Git |
| `<leader><cr>` | Limpiar resaltado de búsqueda |
| `<leader>gy` | Alternar Goyo (modo de enfoque) |
| `<leader>tm` | Alternar modo tabla |
| `ga` | Alinear texto (visual/normal) |
| `<c-d>` | Seleccionar siguiente ocurrencia (multi-cursor) |
| `ga` + `<symbol>` | Alineación fácil alrededor de un símbolo |

## Configuración de LSP Integrado

Todos los servidores de idioma se gestionan a través del LSP integrado.

Instala los servidores de idioma:

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

Instala los formateadores (usados por conform.nvim):

```bash
brew install stylua shfmt
npm install -g prettier
pip3 install black
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
```

### Método de entrada de macOS (opcional)

Para el cambio automático de método de entrada (inglés en modo Normal, restaurar en modo Inserción):

```bash
brew tap daipeihust/tap && brew install im-select
```

Si `im-select` no está presente, Neovim mostrará una advertencia al iniciar. Ejecuta `:IMSelectInstall` para instalarlo automáticamente.

## Notas para macOS / Plataforma

- **Cambio automático de método de entrada**: `im-select` se utiliza para cambiar a la distribución ABC al salir del modo Inserción. Solo activo en macOS.
- **Integración de IA**: `agent-bridge` soporta tres modos de envío:
  - `tmux` — envía el prompt a un panel de tmux ejecutando `claude`
  - `claude` — ejecuta `claude -p --continue` y captura stdout en una ventana flotante de resultados
  - `clipboard` — copia el prompt al portapapeles del sistema
- **Supermaven**: Autocompletado de IA gratuito. Ejecuta `:SupermavenUseFree` la primera vez que lo uses.

## Configuración para vim

```bash
ln -s xxx/nvim ~/.vim
ln -s xxx/nvim/init.vim ./vimrc
```
