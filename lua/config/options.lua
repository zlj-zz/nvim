local utils = require("utils")

local options = {
	foldlevel = 99,

	termguicolors = true,
	winborder = "single",
	number = true,
	relativenumber = false,
	cursorline = true,
	cursorlineopt = "both",
	signcolumn = "yes",
	encoding = "utf-8",
	pyxversion = 3,
	autoread = true,

	-- identation
	tabstop = 4,
	shiftwidth = 4,
	softtabstop = 4,
	expandtab = true,
	smarttab = true,
	autoindent = true,
	cindent = true,

	wrap = true,
	showmatch = true,
	matchtime = 2,

	wildmenu = true,
	showcmd = true,
	showmode = false, -- lualine owns mode; hide native -- NORMAL --
	ignorecase = true,
	hlsearch = true,
	mouse = "a",
	scrolloff = 5,
	updatetime = 1000, -- was 200; CursorHold/LSP highlight less chatty while browsing
	lazyredraw = true,

	undofile = true,
	undodir = vim.g.home_path .. "/.tmp/undo",

	-- cursor can swap line.
	backspace = "eol,start,indent",
	whichwrap = "b,s,<,>,h,l",

	-- tip char.
	listchars = "extends:❯,precedes:❮,tab:▸\\ ,trail:-",
	fillchars = "eob: ,fold: ,foldopen:▾,foldclose:▸,foldsep: ",

	hidden = true,

	shortmess = "atAF",
}

for o, v in pairs(options) do
	utils.opt(o, v)
end
