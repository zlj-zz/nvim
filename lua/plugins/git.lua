local Conflicts = {}
local api = vim.api
local utils = require("utils")

local MARKER_START = "^<<<<<<< (.+)$"
local MARKER_SEP = "^=======$"
local MARKER_END = "^>>>>>>> "
local PREVIEW_NS = api.nvim_create_namespace("conflict_preview")
local TRUNC_LEN = 35

local function find_conflict(lines, row)
	local start_ln
	for i = row, 1, -1 do
		if lines[i]:match(MARKER_START) then
			start_ln = i
			break
		end
	end
	if not start_ln then
		return nil
	end

	local sep_ln, end_ln
	for i = start_ln + 1, #lines do
		if lines[i]:match(MARKER_SEP) then
			sep_ln = i
		elseif lines[i]:match(MARKER_END) then
			end_ln = i
			break
		end
	end
	if not sep_ln or not end_ln then
		return nil
	end

	return start_ln, sep_ln, end_ln
end

function Conflicts.resolve(mode)
	local buf = api.nvim_get_current_buf()
	local row = api.nvim_win_get_cursor(0)[1]
	local lines = api.nvim_buf_get_lines(buf, 0, -1, false)

	local start_ln, sep_ln, end_ln = find_conflict(lines, row)
	if not start_ln then
		utils.warn("No conflict at cursor")
		return
	end
	if not sep_ln or not end_ln then
		utils.error("Incomplete conflict markers")
		return
	end

	local keep
	if mode == "ours" then
		keep = vim.list_slice(lines, start_ln + 1, sep_ln - 1)
	elseif mode == "theirs" then
		keep = vim.list_slice(lines, sep_ln + 1, end_ln - 1)
	elseif mode == "both" then
		keep = vim.list_slice(lines, start_ln + 1, sep_ln - 1)
		vim.list_extend(keep, vim.list_slice(lines, sep_ln + 1, end_ln - 1))
	elseif mode == "none" then
		keep = {}
	end

	api.nvim_buf_set_lines(buf, start_ln - 1, end_ln, false, keep)
end

local function scan_conflicts(buf)
	local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
	local conflicts = {}
	local i = 1
	while i <= #lines do
		local branch = lines[i]:match(MARKER_START)
		if branch then
			local start_ln = i
			local ours_text, theirs_text = {}, {}
			local in_ours = true
			i = i + 1
			while i <= #lines do
				local l = lines[i]
				if l:match(MARKER_SEP) then
					in_ours = false
				elseif l:match(MARKER_END) then
					conflicts[#conflicts + 1] = {
						lnum = start_ln,
						end_lnum = i,
						branch = branch,
						ours = table.concat(ours_text, " "):sub(1, TRUNC_LEN),
						theirs = table.concat(theirs_text, " "):sub(1, TRUNC_LEN),
					}
					break
				elseif in_ours then
					ours_text[#ours_text + 1] = vim.trim(l)
				else
					theirs_text[#theirs_text + 1] = vim.trim(l)
				end
				i = i + 1
			end
		end
		i = i + 1
	end
	return conflicts
end

Conflicts.picker = function()
	local buf = api.nvim_get_current_buf()
	local conflicts = scan_conflicts(buf)
	if #conflicts == 0 then
		utils.warn("No conflicts found")
		return
	end

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local previewers = require("telescope.previewers")

	local previewer = previewers.new_buffer_previewer({
		title = "Conflict Context",
		define_preview = function(self, entry, _)
			local c = entry.value
			local buf_lines = api.nvim_buf_get_lines(buf, c.lnum - 1, c.end_lnum, false)
			api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, buf_lines)
			vim.bo[self.state.bufnr].filetype = vim.bo[buf].filetype

			for j, l in ipairs(buf_lines) do
				if l:match(MARKER_START) then
					api.nvim_buf_set_extmark(
						self.state.bufnr,
						PREVIEW_NS,
						j - 1,
						0,
						{ hl_eol = true, hl_group = "DiffAdd" }
					)
				elseif l:match(MARKER_SEP) then
					api.nvim_buf_set_extmark(
						self.state.bufnr,
						PREVIEW_NS,
						j - 1,
						0,
						{ hl_eol = true, hl_group = "DiffChange" }
					)
				elseif l:match(MARKER_END) then
					api.nvim_buf_set_extmark(
						self.state.bufnr,
						PREVIEW_NS,
						j - 1,
						0,
						{ hl_eol = true, hl_group = "DiffDelete" }
					)
				end
			end
		end,
	})

	pickers
		.new({}, {
			prompt_title = "Git Conflicts",
			finder = finders.new_table({
				results = conflicts,
				entry_maker = function(c)
					return {
						value = c,
						display = string.format(
							"%4d | ours: %-" .. TRUNC_LEN .. "s | theirs: %-" .. TRUNC_LEN .. "s | %s",
							c.lnum,
							c.ours,
							c.theirs,
							c.branch
						),
						ordinal = c.ours .. c.theirs,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			previewer = previewer,
			attach_mappings = function(prompt_bufnr, map)
				local function act(m)
					return function()
						local entry = action_state.get_selected_entry()
						actions.close(prompt_bufnr)
						api.nvim_win_set_cursor(0, { entry.value.lnum, 0 })
						Conflicts.resolve(m)
					end
				end

				map("i", "<C-o>", act("ours"))
				map("i", "<C-t>", act("theirs"))
				map("i", "<C-b>", act("both"))
				map("i", "<C-d>", act("none"))

				actions.select_default:replace(function()
					local e = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					api.nvim_win_set_cursor(0, { e.value.lnum, 0 })
				end)
				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<leader>fc", function()
	Conflicts.picker()
end, { desc = "Git conflict picker", silent = true })

return {
	{
		"zlj-zz/pigit.nvim",
		dir = utils.lazy_safe_dif("~/projects/pigit.nvim"),
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			local map = require("utils").map

			require("pigit").setup({
				cd_scope = "tcd",
				open_on_enter = "none",
			})

			map("n", ",pp", "<cmd>PigitRepos<CR>")
			map("n", ",ps", "<cmd>PigitStatus<CR>")
			map("n", ",pg", "<cmd>PigitTerm<CR>")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local opts = { buffer = bufnr }

					vim.keymap.set("n", "]h", gs.next_hunk, opts)
					vim.keymap.set("n", "[h", gs.prev_hunk, opts)
					vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
					vim.keymap.set("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end, opts)
					vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
					vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
					vim.keymap.set("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, opts)
					vim.keymap.set("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, opts)
					vim.keymap.set("n", "<leader>hS", gs.stage_buffer, opts)
					vim.keymap.set("n", "<leader>hR", gs.reset_buffer, opts)
					vim.keymap.set("n", "<leader>hd", gs.diffthis, opts)
				end,
			})
		end,
	},
}
