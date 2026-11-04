return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			local map = require("utils").map

			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.3
					end
				end,
				open_mapping = nil,
				hide_numbers = true,
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				direction = "horizontal",
				close_on_exit = true,
				shell = vim.o.shell,
			})

			local Terminal = require("toggleterm.terminal").Terminal

			-- Default bottom terminal
			local bottom_term = Terminal:new({ direction = "horizontal", hidden = true })

			-- Right-side terminal
			local right_term = Terminal:new({ direction = "vertical", hidden = true })

			-- Toggle bottom terminal
			map({ "n", "t" }, "<C-t>", function()
				bottom_term:toggle()
			end)

			-- Toggle right terminal
			map({ "n", "t" }, "<C-l>", function()
				right_term:toggle()
			end)

			-- Escape terminal mode to normal mode
			map("t", "<Esc><Esc>", "<C-\\><C-n>")
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local M = {}

			local function get_greeting(name)
				local hour = tonumber(os.date("%H"))
				local greetings = {
					[1] = "Sleep well",
					[2] = "Good morning",
					[3] = "Good afternoon",
					[4] = "Good evening",
					[5] = "Good night",
				}
				local idx
				if hour == 23 or hour < 7 then
					idx = 1
				elseif hour < 12 then
					idx = 2
				elseif hour < 18 then
					idx = 3
				elseif hour < 22 then
					idx = 4
				else
					idx = 5
				end
				return greetings[idx] .. ", " .. name
			end

			local function get_footer()
				local stats = require("lazy").stats()
				local plugins_str = stats.loaded .. "/" .. stats.count .. " plugins loaded"
				local ver = vim.version()
				local nvim_ver = "v" .. ver.major .. "." .. ver.minor .. "." .. ver.patch
				return get_greeting("zachary") .. "  " .. plugins_str .. "  " .. nvim_ver
			end

			require("dashboard").setup({
				theme = "hyper",
				config = {
					header = {
						[[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
						[[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
						[[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
						[[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
						[[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
						[[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
					},
					shortcut = {
						{
							desc = "New file",
							icon = " ",
							group = "Number",
							action = "ene",
							key = "e",
						},
						{
							desc = "Sync plugins",
							icon = " ",
							group = "String",
							action = "Lazy sync",
							key = "s",
						},
						{
							desc = "Configuration",
							icon = " ",
							group = "Operator",
							action = "e $MYVIMRC | cd %:p:h | pwd",
							key = "c",
						},
						{
							desc = "Quit",
							icon = "󰅚 ",
							group = "Keyword",
							action = "qa",
							key = "q",
						},
					},
					packages = { enable = true },
					project = { enable = false },
					mru = { limit = 10, cwd_only = true, label = "MRU " .. vim.fn.getcwd() },
					footer = { get_footer() },
				},
			})

			return M
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					styles = {
						comments = "italic",
						keywords = "bold",
						types = "italic,bold",
						functions = "bold",
					},
				},
			})
		end,
	},
	{
		-- Winbar breadcrumbs; aerial stays as the outline panel (ti).
		"Bekaboo/dropbar.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{
				"<leader>;",
				function()
					require("dropbar.api").pick()
				end,
				desc = "Dropbar pick",
			},
		},
		config = function()
			require("dropbar").setup({
				menu = {
					preview = true,
					keymaps = {
						["h"] = "<C-w>q",
						["l"] = function()
							local menu = require("dropbar.utils").menu.get_current()
							if not menu then
								return
							end
							local cursor = vim.api.nvim_win_get_cursor(menu.win)
							local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
							if component then
								menu:click_on(component, nil, 1, "l")
							end
						end,
					},
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Statusline / tabline; winbar is owned by dropbar (do not set lualine winbar).
			vim.opt.laststatus = 3
			vim.opt.showtabline = 2

			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					component_separators = { left = "│", right = "│" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = { "dashboard", "alpha" },
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						{
							"filename",
							path = 1, -- relative path, closer to demo center path
							symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
						},
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "location" },
				},
				tabline = {
					lualine_a = {
						{
							"buffers",
							mode = 2,
							show_filename_only = true,
							max_length = vim.o.columns * 2 / 3,
							symbols = {
								modified = " ●",
								alternate_file = "",
								directory = "",
							},
						},
					},
					lualine_z = { "branch" },
				},
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local function my_on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				api.map.on_attach.default(bufnr)

				vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			end

			require("nvim-tree").setup({
				on_attach = my_on_attach,
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
				sort_by = "case_sensitive",
				view = {
					width = 30,
					side = "left",
					number = false,
					relativenumber = false,
				},
				filters = {},
				renderer = {
					highlight_git = "name",
					highlight_opened_files = "name",
					indent_markers = { enable = true },
					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
						},
						glyphs = {
							git = {
								unstaged = "✗",
								staged = "✓",
								unmerged = "✖",
								renamed = "➜",
								untracked = "★",
								deleted = "✖",
								ignored = "◌",
							},
						},
					},
				},
				git = {
					enable = true,
					ignore = false,
				},
				actions = {
					open_file = {
						quit_on_open = false,
						resize_window = true,
					},
				},
			})

			-- VS Code-style git status colors
			local hl = vim.api.nvim_set_hl
			hl(0, "NvimTreeGitDirty", { fg = "#e5c07b" }) -- modified: orange/yellow
			hl(0, "NvimTreeGitStaged", { fg = "#98c379" }) -- staged: green
			hl(0, "NvimTreeGitNew", { fg = "#98c379" }) -- untracked: green
			hl(0, "NvimTreeGitDeleted", { fg = "#e06c75" }) -- deleted: red
			hl(0, "NvimTreeGitIgnored", { fg = "#636e7b" }) -- ignored: gray
			hl(0, "NvimTreeGitRenamed", { fg = "#61afef" }) -- renamed: blue
			hl(0, "NvimTreeGitMerge", { fg = "#c678dd" }) -- conflict: purple

			-- global toggle keymap
			vim.keymap.set("n", "tt", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })

			-- auto open on directory, skip when opening a file (including new files)
			-- vim.api.nvim_create_autocmd('VimEnter', {
			--     callback = function()
			--         if vim.fn.argc() == 0 then
			--             -- no args: nvim (opens cwd)
			--             require('nvim-tree.api').tree.open()
			--         else
			--             local arg = vim.fn.argv(1)
			--             if type(arg) == 'string' then
			--                 local stat = vim.loop.fs_stat(arg)
			--                 if stat and stat.type == 'directory' then
			--                     -- first arg is a directory: nvim .
			--                     require('nvim-tree.api').tree.open()
			--                 end
			--             end
			--         end
			--     end,
			-- })
		end,
	},
}
