<!-- vim-markdown-toc GFM -->

* [This is my neovim](#this-is-my-neovim)
    * [After Installation, You Need To](#after-installation-you-need-to)
    * [After Installation, You Might Want To](#after-installation-you-might-want-to)
        * [First of all(neovim)](#first-of-allneovim)
        * [For Python Debugger (via `vimspector`)](#for-python-debugger-via-vimspector)
        * [Config Python path](#config-python-path)
        * [For Taglist:](#for-taglist)
        * [For FZF](#for-fzf)
        * [And may also...](#and-may-also)
    * [Keyboard Shortcuts](#keyboard-shortcuts)
        * [Curosr movement](#curosr-movement)
        * [Remapped cursor movement](#remapped-cursor-movement)
        * [Remapped commands in Normal Mode](#remapped-commands-in-normal-mode)
        * [Window management](#window-management)
        * [Tab management](#tab-management)
        * [Other](#other)
    * [Plugin](#plugin)
        * [vim-startify](#vim-startify)
        * [COC](#coc)
        * [Vista.vim](#vistavim)
        * [fzf.vim](#fzfvim)
        * [vim-visual-multi](#vim-visual-multi)
        * [~~vim-easymotion~~](#vim-easymotion)
        * [~~vim-after-object~~](#vim-after-object)
        * [vim-easy-align](#vim-easy-align)
        * [nerdcommenter](#nerdcommenter)
        * [vim-markdown-toc](#vim-markdown-toc)
        * [vim-table-mode](#vim-table-mode)
        * [~~vim-keysound~~](#vim-keysound)
* [Use for vim](#use-for-vim)

<!-- vim-markdown-toc -->

# This is my neovim

**This is just my configuration of NEOVIM, for reference only.**

> now can use the configuration in windows easyly.

![demo](https://img-blog.csdnimg.cn/20200512091003564.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NDEwNDk0,size_16,color_FFFFFF,t_70)

## After Installation, You Need To

Install `pynvim` (pip)

Install `nodejs`, and do `npm install -g neovim`

Install nerd-fonts (actually it's optional)

## After Installation, You Might Want To

### First of all(neovim)

Do `:checkhealth`

### For Python Debugger (via `vimspector`)

Install `debugpy` (`pip`)

### Config Python path

Well, make sure you have python

### For Taglist:

Install `ctags` for function/class/variable list

### For FZF

Install `fzf`

Install `ag` (`the_silver_searcher`)

### And may also...

Install `figlet` for inputing text ASCII art

Install `xclip` for system clipboard access (Linux and `xorg` only)

## Keyboard Shortcuts

let `<LEADER>` to be `<space>`.

let `S` to save file (same as command `:w`).

let `Q` to quit (same as command `:q`).

let `ctrl`+`q` to force quit (same as command `:q!`).

### Curosr movement

| ←   | ↓   | ↑   | →   |
| --- | --- | --- | --- |
| `h` | `j` | `k` | `l` |

`gj` and `gk` move line by line if the text wraps.

### Remapped cursor movement

| shortcut   | action                                                    | equavilent |
| ---------- | --------------------------------------------------------- | ---------- |
| `K`        | cursor up 7 lines                                         | `7k`       |
| `J`        | cursor down 7 lines                                       | `7j`       |
| `H`        | cursor left 5 chars                                       | `5h`       |
| `L`        | cursor right 5 chars                                      | `5l`       |
| `ctrl`+`K` | move the view port up 5 lines without moving the cursor   | `5<c-y>`   |
| `ctrl`+`J` | move the view port down 5 lines without moving the cursor | `5<c-e>`   |
| `alt`+`h`  | ← in insert mode                                          | `<left>`   |
| `alt`+`j`  | ↓ in insert mode                                          | `<down>`   |
| `alt`+`k`  | ↑ in insert mode                                          | `<up>`     |
| `alt`+`l`  | → in insert mode                                          | `<right>`  |
| `alt`+`a`  | move cursor to head in insert mode                        | `<home>`   |
| `alt`+`s`  | move cursor to tail in insert mode                        | `<end>`    |

### Remapped commands in Normal Mode

| shortcut           | action                             |
| ------------------ | ---------------------------------- |
| `<`                | un-indent                          |
| `>`                | indent                             |
| `<LEADER><LEADER>` | goto the next placeholder (`<++>`) |
| `<LEADER><Enter>`  | cancel the highligh search         |
| `<LEADER>sc`       | spelling check toggle              |
| `<LEADER>fd`       | find two same word                 |
| `<LEADER>rc`       | open the neovim config anytime     |
| `,rc`              | resource neovim config             |

### Window management

| shortcut | action                            |     | shortcut | action                             |
| -------- | --------------------------------- | --- | -------- | ---------------------------------- |
| `sh`     | split window to the left          |     | `th`     | move cursor to the left window     |
| `sj`     | split window to the down          |     | `tj`     | move cursor to the down window     |
| `sk`     | split window to the up            |     | `tk`     | move cursor to the up window       |
| `sl`     | split window to the right         |     | `tl`     | move cursor to the right window    |
| `ch`     | place the two screens up and down |     | `cv`     | place the two screens side by side |

### Tab management

| shortcut      | action            |
| ------------- | ----------------- |
| `st`          | create a new tab  |
| `t-`          | previous tab      |
| `t=`          | next previous     |
| `alt` + `1~9` | switch to 1~9 tab |

### Other

You can use `ZZ` command, this command writes the file and exits.

~~In normal mode make `Y` to copy till the end of the line (same as `y$`).~~

In visual mode make `ctrl + c` copy to system clipboard (same as `"+y`).

~~In visual mode make `ctrl + v` copy to system clipboard (same as `"+p`).~~

let `ctrl+a` to select all (same as `ggVG`).

`ctrl+z` makes **vim** hang and enter **shell**, `fg` returns **vim** form **shell**.

`space` + `j/k` to increase or decrease a number by one.

`dip` clear the black lien around the current cursor.

~~`ra` use **ranger** in neovim.~~

## Plugin

### [vim-startify](https://github.com/mhinz/vim-startify)

Enter `F5` to open a new tab and running Startify.

<!--First start will generate 5 temporary file with suffixes of `.c`, `.java`, `.py`, `.js`, `.html`, `.css`.-->

![vim-startup](https://img-blog.csdnimg.cn/20200512234641826.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NDEwNDk0,size_16,color_FFFFFF,t_70)

### [COC](https://github.com/neoclide/coc.nvim)

**coc-complete** (a auto-complete plugin)

| shortcut          | action          |     | shortcut | action                  |
| ----------------- | --------------- | --- | -------- | ----------------------- |
| `<tab>`           | next item       |     | `gd`     | jump to definition      |
| `<shift>`+`<tab>` | previous item   |     | `gt`     | jump to type definition |
| `<enter>`         | select item     |     | `gi`     | jump to implementation  |
| `<leader>rn`      | symbol renaming |     | `gr`     | jump to/show references |

![coc-complete](https://img-blog.csdnimg.cn/202005112344456.gif)

**coc-snippet** (a code snippet plugin)

| shortcut | action                       |
| -------- | ---------------------------- |
| `<c-j>`  | trigger snippet expand       |
| `<c-j>`  | jump to next placeholder     |
| `<c-k>`  | jump to previous placeholder |

![coc-snippet](https://img-blog.csdnimg.cn/20200512090039297.gif)

**[coc-explorer](https://github.com/weirongxu/coc-explorer)** (a file browser plugin)

| shortcut  | action               |     | shortcut | action        |     | shortcut | action         |
| --------- | -------------------- | --- | -------- | ------------- | --- | -------- | -------------- |
| `tt`      | coc-explorer toggle  |     | `p`      | paste file    |     | `y`      | copy file path |
| `k`and`j` | up and down          |     | `d`      | delete        |     | `Y`      | copy file name |
| `h`and`l` | collapse and expand  |     | `a`      | add file      |     | `c`      | copy file      |
| `e`       | open file            |     | `A`      | add directory |     | `x`      | cut file       |
| `s`and`E` | open split or vsplit |     | `r`      | rename        |     | `f`      | search         |
| `t`       | open in new tab      |     | `.`      | toggleHidden  |     | `R`      | refresh        |
| `q`       | quit                 |     | `?`      | help          |     |          |                |

![explorer](https://img-blog.csdnimg.cn/20200520184210522.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NDEwNDk0,size_16,color_FFFFFF,t_70)

### [Vista.vim](https://github.com/liuchengxu/vista.vim)

View and search LSP symbols, tags in Vim/NeoVim.

Press `ti` to toggle Vista.

| shortcut | action  |
| -------- | ------- |
| `q`      | quit    |
| `p`      | preview |

[Vista gif](https://user-images.githubusercontent.com/8850248/56469894-14d40780-6472-11e9-802f-729ac53bd4d5.gifhttps://user-images.githubusercontent.com/8850248/56469894-14d40780-6472-11e9-802f-729ac53bd4d5.gifhttps://user-images.githubusercontent.com/8850248/56469894-14d40780-6472-11e9-802f-729ac53bd4d5.gif)

### [fzf.vim](https://github.com/junegunn/fzf.vim)

Things you can do with fzf and Vim.

| shortcut     | action              |
| ------------ | ------------------- |
| `,` `f`      | FZF file            |
| `,` `h`      | FZF history         |
| `,` `b`      | FZF Buffers         |
| `,` `d`      | Del buffer          |
| `,` `l`      | FZF Lines           |
| `leader` `;` | FZF history command |

<!--| `,` `j` | cursor down |-->
<!--| `,` `k` | cursor up |-->

### [vim-visual-multi](https://github.com/mg979/vim-visual-multi)

It can help you realize the function of multi-cursor.

- select words with `Ctrl-N` (like `Ctrl-d` in Sublime Text/VS Code)
- create cursors vertically with `Ctrl-Down/Ctrl-Up`
- select one character at a time with `Shift-Arrows`
- press `n/N` to get next/previous occurrence
- press `[/]` to select next/previous cursor
- press `q` to skip current and get next occurrence
- press `Q` to remove current cursor/selection
- start insert mode with `i,a,I,A`
- `u` to undo, `ctrl` + `r` to redo, like vim native.

### ~~vim-easymotion~~

Fast move you cursor, use `'` easymotion

![vim-easymotion](https://img-blog.csdnimg.cn/20200512164720342.gif)

### ~~vim-after-object~~

Use `da` + `=` to delete what's after `=`.

### [vim-easy-align](https://github.com/junegunn/vim-easy-align)

Press `ga ` + **symbol** in normal or visual mode to align text based on **symbol**.

![easy-align](https://raw.githubusercontent.com/junegunn/i/master/easy-align/equals.gif)

### [nerdcommenter](https://github.com/preservim/nerdcommenter)

> A code comment plugin.

| shortcut     | action           |
| ------------ | ---------------- |
| `<LEADER>cn` | comment a line   |
| `<LEADER>cu` | uncomment a line |

### [vim-markdown-toc](https://github.com/mzlogin/vim-markdown-toc)

> (generate table of contents for markdown files)

In `markdown` files, type `:Gen` then tab, you'll see your options.

![markdown-toc](https://raw.githubusercontent.com/mzlogin/vim-markdown-toc/master/screenshots/english.gif)

### [vim-table-mode](https://github.com/dhruvasagar/vim-table-mode)

| shortcut        | action            |
| --------------- | ----------------- |
| `space` `t` `m` | toggle table mode |
| `space` `t` `r` | realign table     |

### ~~vim-keysound~~

_make your vim a typewriter_

You should do:

```shell
pip install pysdl2

sudo pacman -S sdl sdl-mixer
```

# Use for vim

```
ln -s xxx/nvim ~/.vim
ln -s xxx/nvim/init.vim ./vimrc
```

<font size=50px; ><b>This is bottom</b></font>
