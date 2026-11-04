local api = vim.api
local funcs = require("funcs")

local group = api.nvim_create_augroup("ZACHARY_GROUP", { clear = true })

-- Restore last cursor position and open folds on BufReadPost.
api.nvim_create_autocmd("BufReadPost", {
	group = group,
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "gitcommit" then
			return
		end
		local mark = api.nvim_buf_get_mark(0, '"')
		local lcount = api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(api.nvim_win_set_cursor, 0, mark)
			vim.cmd("normal! zv")
		end
	end,
	desc = "Restore cursor position and open folds",
})

-- Bigfile gate: skip TS / LSP / ibl on huge buffers (size or line count).
local BIG_BYTES = 5 * 1024 * 1024 -- 5 MiB
local BIG_LINES = 10000

local function apply_bigfile(buf)
	vim.b[buf].bigfile = true

	vim.bo[buf].swapfile = false
	vim.bo[buf].undofile = false

	pcall(vim.treesitter.stop, buf)
	pcall(function()
		require("ibl").setup_buffer(buf, { enabled = false })
	end)

	-- After FileType plugins; keep regex syntax and LSP off.
	vim.schedule(function()
		if not api.nvim_buf_is_valid(buf) then
			return
		end
		vim.bo[buf].syntax = "off"
		pcall(vim.treesitter.stop, buf)
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
			pcall(vim.lsp.buf_detach_client, buf, client.id)
		end
	end)
end

local function maybe_bigfile(buf)
	if vim.bo[buf].buftype ~= "" then
		return
	end
	if vim.b[buf].bigfile then
		apply_bigfile(buf) -- FileType may revive syntax/TS; re-assert
		return
	end
	local name = api.nvim_buf_get_name(buf)
	local size = name ~= "" and vim.fn.getfsize(name) or 0
	local lines = api.nvim_buf_line_count(buf)
	if (size > BIG_BYTES) or (lines > BIG_LINES) then
		apply_bigfile(buf)
	end
end

api.nvim_create_autocmd({ "BufReadPost", "FileType" }, {
	group = group,
	pattern = "*",
	callback = function(args)
		maybe_bigfile(args.buf)
	end,
	desc = "Mark huge buffers as bigfile (disable TS/LSP/ibl)",
})
api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(args)
		if vim.b[args.buf].bigfile then
			vim.schedule(function()
				if api.nvim_buf_is_valid(args.buf) then
					pcall(vim.lsp.buf_detach_client, args.buf, args.data.client_id)
				end
			end)
		end
	end,
	desc = "Detach LSP from bigfile buffers",
})
-- Re-detect filetype on save if it was empty.
api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "*",
	nested = true,
	callback = function()
		if vim.bo.filetype == "" or vim.b.ftdetect then
			vim.b.ftdetect = nil
			vim.cmd("filetype detect")
		end
	end,
	desc = "Re-detect filetype if empty on save",
})

-- Toggle cursorline based on mode.
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	group = group,
	pattern = "*",
	command = "set cursorline",
	desc = "Enable cursorline in normal mode",
})

api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	group = group,
	pattern = "*",
	command = "set nocursorline",
	desc = "Disable cursorline in insert mode",
})

-- Terminal: open file path on current line in editing area.
api.nvim_create_autocmd("TermOpen", {
	group = group,
	callback = function(args)
		local opts = { buffer = args.buf, silent = true }
		vim.keymap.set({ "t", "n" }, "<C-o>", funcs.open_file_from_terminal, opts)

		-- macOS: Cmd+Click may be intercepted by the terminal; use Ctrl+Click as fallback.
		local mouse_fn = function()
			local pos = vim.fn.getmousepos()
			if pos.winid == 0 then
				return
			end
			local win_buf = api.nvim_win_get_buf(pos.winid)
			local lines = api.nvim_buf_get_lines(win_buf, pos.line - 1, pos.line, false)
			funcs.open_file_from_terminal_line(lines[1])
		end
		vim.keymap.set({ "t", "n" }, "<C-LeftMouse>", mouse_fn, opts)
		vim.keymap.set({ "t", "n" }, "<D-LeftMouse>", mouse_fn, opts)
	end,
	desc = "Open file from terminal line in editing area",
})
