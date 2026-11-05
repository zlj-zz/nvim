return {
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			local notify = require("notify")
			notify.setup({
				stages = "fade",
				timeout = 3000,
				render = "wrapped-compact",
				fps = 60,
			})
			vim.notify = notify
		end,
	},
	{
		-- Pretty vim.ui.input / vim.ui.select (LSP rename, code actions, …)
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				border = "single",
				relative = "cursor",
			},
			select = {
				backend = { "telescope", "builtin" },
				builtin = {
					border = "single",
				},
			},
		},
	},
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
					project = {
						enable = true,
						limit = 8,
						label = " Recent Projects ",
						action = "Telescope find_files cwd=",
					},
					mru = { limit = 10, cwd_only = false, label = " MRU " },
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
							symbols = {
								modified = " ●",
								alternate_file = "",
								directory = "",
							},
						},
					},
				},
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "tt", "<cmd>Neotree toggle filesystem left<CR>", desc = "Toggle neo-tree" },
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = "single",
				enable_git_status = true,
				enable_diagnostics = true,
				default_component_configs = {
					indent = { with_markers = true },
					git_status = {
						symbols = {
							added = "✚",
							modified = "✗",
							deleted = "✖",
							renamed = "➜",
							untracked = "★",
							ignored = "◌",
							unstaged = "✗",
							staged = "✓",
							conflict = "✖",
						},
					},
				},
				window = {
					position = "left",
					width = 30,
					mappings = {
						["<C-t>"] = "navigate_up",
						["?"] = "show_help",
						-- Free `t` for global t* maps (tt / th / ti / …).
						-- Default `t`=open_tabnew → unused `O` (T stays trash).
						["t"] = "none",
						["O"] = "open_tabnew",
						-- Preview mode: j/k updates the editor pane without pinning buffers.
						-- Leave the tree (or press P again) to revert; <CR> still opens for real.
						["P"] = {
							"toggle_preview",
							config = { use_float = false },
						},
						["l"] = "focus_preview",
					},
				},
				filesystem = {
					follow_current_file = { enabled = true },
					use_libuv_file_watcher = true,
					hijack_netrw_behavior = "open_default",
					filtered_items = {
						visible = false,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					window = {
						mappings = {
							-- Soft open: same as preview toggle for mouse/keyboard browse.
							["<Tab>"] = {
								"toggle_preview",
								config = { use_float = false },
							},
						},
					},
				},
			})
		end,
	},
}
