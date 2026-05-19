local M = {}

local g = vim.g
local t = vim.t
local fn = vim.fn
local api = vim.api

-------------------------------
---Open current in a browsers.
-------------------------------
local browsers = {
	chrome = "open -a Google Chrome ",
	firefox = "open -a Firefox ",
}

M.open_curr_on_browser = function()
	vim.cmd("silent !" .. browsers.firefox .. fn.expand("%:p"))
end

--------------------
---Switch bg color.
--------------------
g.bg_flag__ = 1

M.switch_transparent_bg = function()
	-- Capture original guibg on first call (after colorscheme is loaded)
	if g.record_guibg__ == nil then
		local hi = fn.execute("hi normal")
		g.record_guibg__ = fn.matchstr(hi, "guibg=\\zs\\S*")
	end

	if g.bg_flag__ == 1 then
		g.bg_flag__ = 0
		vim.cmd([[hi normal guibg=none]])
	else
		g.bg_flag__ = 1
		vim.cmd("hi normal guibg=" .. g.record_guibg__)
	end
end

--------------------------------------------------
---toggle to make a screen full when split screen
--------------------------------------------------
M.switch_full_screen = function()
	if t.zoomed ~= nil and t.zoomed == 1 then
		vim.cmd(t.zoom_winrestcmd)
		t.zoomed = 0
	else
		t.zoom_winrestcmd = fn.winrestcmd()
		vim.cmd([[resize]])
		vim.cmd([[vertical resize]])
		t.zoomed = 1
	end
end

-----------------------------------
--- change current buffer by index
-----------------------------------
---@param num integer
M.buf_index = function(num)
	if num == nil then
		return
	end

	local buf_list = fn.filter(fn.range(1, fn.bufnr("$")), "buflisted(v:val)")

	if num > #buf_list then
		return
	end

	local buf_id = buf_list[num]
	vim.cmd(":" .. buf_id .. "b")
end

M.get_time = function()
	return fn.strftime("%Y-%m-%d %H:%M:%S")
end

---Split window then open telescope file picker (fallback to :e if no telescope).
---@param split_cmd string
M.telescope_split = function(split_cmd)
	local ok, builtin = pcall(require, "telescope.builtin")
	if ok then
		vim.cmd(split_cmd)
		builtin.find_files()
	else
		vim.cmd(split_cmd .. " | e")
	end
end

local function confirm_close(msg)
	local choice = fn.confirm(msg, "&Yes\n&No", 2)
	return choice == 1
end

---Close current buffer and switch to the previous one.
---If only one listed buffer remains, quit the window instead.
---Prompts for confirmation if the buffer has unsaved changes.
M.smart_close = function()
	local wins = vim.tbl_filter(function(w)
		local buf = api.nvim_win_get_buf(w)
		return vim.bo[buf].buflisted
	end, api.nvim_list_wins())

	-- In a split: just close the current window, keep the buffer
	if #wins > 1 then
		local cur = api.nvim_get_current_buf()
		local modified = fn.getbufvar(cur, "&modified") == 1
		if modified then
			if not confirm_close("Buffer has unsaved changes. Close window anyway?") then
				return
			end
			vim.cmd("q!")
		else
			vim.cmd("q")
		end
		return
	end

	local buf_list = fn.getbufinfo({ buflisted = 1 })
	local cur = api.nvim_get_current_buf()
	local modified = fn.getbufvar(cur, "&modified") == 1

	-- Only one buffer left: quit nvim
	if #buf_list <= 1 then
		if modified then
			if not confirm_close("Buffer has unsaved changes. Quit anyway?") then
				return
			end
			vim.cmd("q!")
		else
			vim.cmd("q")
		end
		return
	end

	if modified then
		if not confirm_close("Buffer has unsaved changes. Close anyway?") then
			return
		end
	end

	local alt = fn.bufnr("#")

	-- If alternate buffer is valid and listed, switch to it first
	if alt > 0 and fn.buflisted(alt) == 1 and alt ~= cur then
		vim.cmd("b#")
	else
		-- Fall back to previous buffer in the list
		vim.cmd("bp")
	end

	-- Delete the buffer we just left
	if modified then
		vim.cmd("bd! " .. cur)
	else
		vim.cmd("bd " .. cur)
	end
end

local function extract_path(line)
	line = line:match("^%s*(.-)%s*$")
	local path = line:match("^%S+%s+(.-)%s*$")
	if path then
		local renamed = path:match("^.-%s+->%s+(.-)%s*$")
		return renamed or path
	end
	if line:match("^[%w_%-%./]+$") then
		return line
	end
	return nil
end

local function find_editable_win(exclude_win)
	for _, win in ipairs(api.nvim_list_wins()) do
		if win ~= exclude_win then
			local buf = api.nvim_win_get_buf(win)
			if vim.bo[buf].buftype ~= "terminal" and vim.bo[buf].filetype ~= "NvimTree" then
				return win
			end
		end
	end
	return nil
end

local function notify_and_restore(msg)
	vim.notify(msg, vim.log.levels.WARN)
	vim.cmd("startinsert")
end

local function open_path_in_editor(path)
	local abs_path = fn.filereadable(path) == 1 and path or (fn.getcwd() .. "/" .. path)
	if fn.filereadable(abs_path) ~= 1 then
		return nil, "File not found: " .. abs_path
	end

	local term_win = api.nvim_get_current_win()
	vim.cmd("wincmd p")
	local cur_buf = api.nvim_win_get_buf(0)
	if vim.bo[cur_buf].buftype == "terminal" or vim.bo[cur_buf].filetype == "NvimTree" then
		local win = find_editable_win(term_win)
		api.nvim_set_current_win(win or term_win)
	end

	vim.cmd("e " .. fn.fnameescape(abs_path))
	return true
end

M.open_file_from_terminal = function()
	vim.cmd("stopinsert")
	local path = extract_path(fn.getline("."))
	if not path then
		notify_and_restore("No file path found on current line")
		return
	end

	local ok, err = open_path_in_editor(path)
	if not ok then
		notify_and_restore(err)
	end
end

M.open_file_from_terminal_line = function(line_str)
	local path = extract_path(line_str)
	if not path then
		return
	end
	open_path_in_editor(path)
end

---------------------------------------------
---Floating search/replace in current buffer.
---------------------------------------------
M.replace_float = function(prefill_search)
	local target_win = api.nvim_get_current_win()
	local target_buf = api.nvim_get_current_buf()

	local is_regex = false
	local cached_lines = api.nvim_buf_get_lines(target_buf, 0, -1, false)
	local last_pattern = nil
	local last_re = nil

	local buf = api.nvim_create_buf(false, true)
	local search_prefix = "Search: "
	local replace_prefix = "Replace: "
	local search_line = prefill_search and (search_prefix .. prefill_search) or search_prefix
	api.nvim_buf_set_lines(buf, 0, -1, false, { search_line, replace_prefix })

	local function get_title()
		return " Search / Replace [" .. (is_regex and "regex" or "plain") .. "] "
	end

	local win = api.nvim_open_win(buf, true, {
		relative = "editor",
		row = math.floor((vim.o.lines - 4) / 2),
		col = math.floor((vim.o.columns - 50) / 2),
		width = 50,
		height = 4,
		style = "minimal",
		border = "single",
		title = get_title(),
		title_pos = "center",
		footer = { { " 0 matches ", "Comment" } },
		footer_pos = "right",
	})

	vim.bo[buf].modifiable = true
	vim.bo[buf].bufhidden = "wipe"

	api.nvim_buf_call(buf, function()
		vim.cmd([[syntax match Comment /^Search:\|^Replace:/]])
	end)

	local match_id = nil
	local hl_group = "ReplaceFloatMatch"
	local ok_cur = pcall(api.nvim_get_hl, 0, { name = "CurSearch" })
	if ok_cur then
		vim.api.nvim_set_hl(0, hl_group, { link = "CurSearch" })
	else
		vim.api.nvim_set_hl(0, hl_group, { bg = "#5e81ac", fg = "#eceff4", bold = true })
	end

	local function clear_highlight()
		if match_id then
			pcall(fn.matchdelete, match_id, target_win)
			match_id = nil
		end
	end

	local function count_regex_matches(pattern)
		local re
		if last_pattern == pattern then
			re = last_re
		else
			local ok
			ok, re = pcall(vim.regex, pattern)
			if not ok or not re then
				return 0
			end
			last_pattern = pattern
			last_re = re
		end

		local count = 0
		local max_matches = 5000
		if not re then
			return 0
		end
		for lnum, _ in ipairs(cached_lines) do
			local s = 0
			while true do
				local m = re:match_line(target_buf, lnum - 1, s)
				if m == nil then
					break
				end
				count = count + 1
				if count >= max_matches then
					return count
				end
				s = m + 1
			end
		end
		return count
	end

	local function count_matches(text)
		if text == "" then
			return 0
		end
		if not is_regex then
			local n = 0
			for _, line in ipairs(cached_lines) do
				local start_pos = 1
				while true do
					local s, e = string.find(line, text, start_pos, true)
					if not s then
						break
					end
					n = n + 1
					start_pos = e + 1
				end
			end
			return n
		else
			return count_regex_matches(text)
		end
	end

	local last_display = { count = -1, mode = nil }
	local update_timer = nil

	local function do_update()
		if update_timer then
			update_timer:stop()
			update_timer:close()
			update_timer = nil
		end

		local lines = api.nvim_buf_get_lines(buf, 0, 1, false)
		local search = lines[1]:gsub("^Search:%s*", "")
		clear_highlight()

		local count = 0
		if search ~= "" then
			api.nvim_win_call(target_win, function()
				local pattern = is_regex and search or fn.escape(search, ".*[]^$\\")
				local ok, id = pcall(fn.matchadd, hl_group, pattern, 10)
				if ok then
					match_id = id
				end
			end)
			count = count_matches(search)
		end

		if last_display.count ~= count or last_display.mode ~= is_regex then
			last_display.count = count
			last_display.mode = is_regex
			pcall(api.nvim_win_set_config, win, {
				title = get_title(),
				footer = { { " " .. count .. " matches ", "Comment" } },
				footer_pos = "right",
			})
		end
	end

	local function update_highlight()
		if update_timer then
			update_timer:stop()
			update_timer:close()
		end
		update_timer = vim.defer_fn(function()
			update_timer = nil
			do_update()
		end, 80)
	end

	local function toggle_regex()
		is_regex = not is_regex
		update_highlight()
	end

	local augroup = api.nvim_create_augroup("ReplaceFloatHighlight", { clear = true })
	api.nvim_create_autocmd("TextChangedI", {
		group = augroup,
		buffer = buf,
		callback = function()
			local row = api.nvim_win_get_cursor(win)[1]
			if row == 1 then
				update_highlight()
			end
		end,
	})

	api.nvim_create_autocmd("BufWipeout", {
		group = augroup,
		buffer = buf,
		once = true,
		callback = function()
			clear_highlight()
			api.nvim_clear_autocmds({ group = augroup })
		end,
	})

	if prefill_search then
		update_highlight()
	end

	api.nvim_win_set_cursor(win, { 1, #search_line })
	vim.cmd("startinsert!")

	local function confirm()
		if update_timer then
			update_timer:stop()
			update_timer:close()
			update_timer = nil
		end
		local lines = api.nvim_buf_get_lines(buf, 0, 2, false)
		local search = lines[1]:gsub("^Search:%s*", "")
		local replace = lines[2]:gsub("^Replace:%s*", "")
		clear_highlight()
		api.nvim_clear_autocmds({ group = augroup })
		api.nvim_win_close(win, true)
		if search ~= "" then
			local ok, err = pcall(function()
				if is_regex then
					vim.cmd(string.format("%%s/%s/%s/g", fn.escape(search, "/"), fn.escape(replace, "/")))
				else
					vim.cmd(string.format("%%s/\\V%s/%s/g", fn.escape(search, "/\\"), fn.escape(replace, "/")))
				end
			end)
			if not ok then
				vim.notify("Replace error: " .. err, vim.log.levels.ERROR)
			end
		end
	end

	local function cycle_input()
		local row = api.nvim_win_get_cursor(win)[1]
		if row == 1 then
			api.nvim_win_set_cursor(win, { 2, #replace_prefix })
		else
			api.nvim_win_set_cursor(win, { 1, #search_prefix })
		end
		vim.cmd("startinsert!")
	end

	local function close()
		if update_timer then
			update_timer:stop()
			update_timer:close()
			update_timer = nil
		end
		clear_highlight()
		api.nvim_clear_autocmds({ group = augroup })
		api.nvim_win_close(win, true)
	end

	vim.keymap.set("n", "<CR>", confirm, { buffer = buf })
	vim.keymap.set("i", "<C-s>", confirm, { buffer = buf })
	vim.keymap.set("i", "<Tab>", cycle_input, { buffer = buf })
	vim.keymap.set("i", "<C-x>", toggle_regex, { buffer = buf })
	vim.keymap.set({ "n", "i" }, "<Esc>", close, { buffer = buf })
end

M.replace_float_visual = function()
	local region = fn.getregion(fn.getpos("'<"), fn.getpos("'>"))
	local selection = table.concat(region, "\n")
	M.replace_float(selection)
end

return M
