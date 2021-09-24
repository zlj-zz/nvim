return {
	syntax = 'on',
	filetype = 'on',

	foldenable = true,
	foldmethod = 'manual',

	termguicolors = true,
	number = true,
	relativenumber = true,
	cursorline = true,
	encoding = 'utf-8',
	pyxversion = 3,
	autoread = true,

	-- identation
	ts = 4,
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
	ignorecase = true,
	hlsearch = true,
	mouse = 'a',
	scrolloff = 5,
	updatetime = 200,

	-- cursor can swap line.
	backspace = 'eol,start,indent',
	whichwrap = 'b,s,<,>,h,l',

	-- tip char.
	listchars = 'extends:❯,precedes:❮,tab:▸\\ ,trail:-',

	hidden = true,

	shortmess = 'atAF',

}

