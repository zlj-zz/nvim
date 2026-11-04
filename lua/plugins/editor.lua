return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = {
					"python",
					"lua",
					"vim",
					"vimdoc",
					"javascript",
					"typescript",
					"vue",
					"css",
					"html",
					"scss",
					"json",
					"yaml",
					"dart",
					"markdown",
					"markdown_inline",
					"c",
					"cpp",
					"java",
					"go",
					"bash",
				},
				highlight = { enable = true },
				indent = { enable = true },
				auto_install = true,
			})

			-- nvim-treesitter-textobjects v1.0+ requires manual keymap binding
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			local ts_select = require("nvim-treesitter-textobjects.select")
			vim.keymap.set({ "x", "o" }, "af", function()
				ts_select.select_textobject("@function.outer")
			end)
			vim.keymap.set({ "x", "o" }, "if", function()
				ts_select.select_textobject("@function.inner")
			end)
			vim.keymap.set({ "x", "o" }, "ac", function()
				ts_select.select_textobject("@class.outer")
			end)
			vim.keymap.set({ "x", "o" }, "ic", function()
				ts_select.select_textobject("@class.inner")
			end)
			vim.keymap.set({ "x", "o" }, "aa", function()
				ts_select.select_textobject("@parameter.outer")
			end)
			vim.keymap.set({ "x", "o" }, "ia", function()
				ts_select.select_textobject("@parameter.inner")
			end)
			vim.keymap.set({ "x", "o" }, "al", function()
				ts_select.select_textobject("@loop.outer")
			end)
			vim.keymap.set({ "x", "o" }, "il", function()
				ts_select.select_textobject("@loop.inner")
			end)
			vim.keymap.set({ "x", "o" }, "ab", function()
				ts_select.select_textobject("@block.outer")
			end)
			vim.keymap.set({ "x", "o" }, "ib", function()
				ts_select.select_textobject("@block.inner")
			end)

			local ts_move = require("nvim-treesitter-textobjects.move")
			vim.keymap.set({ "n", "x" }, "]f", function()
				ts_move.goto_next_start("@function.outer")
			end)
			vim.keymap.set({ "n", "x" }, "]c", function()
				ts_move.goto_next_start("@class.outer")
			end)
			vim.keymap.set({ "n", "x" }, "[f", function()
				ts_move.goto_previous_start("@function.outer")
			end)
			vim.keymap.set({ "n", "x" }, "[c", function()
				ts_move.goto_previous_start("@class.outer")
			end)

			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				ts_config = {
					lua = { "string" },
					javascript = { "template_string" },
				},
				disable_filetype = { "TelescopePrompt", "spectre_panel" },
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = { char = "┆" },
				scope = { enabled = true },
				exclude = {
					filetypes = { "help", "terminal", "dashboard", "lazy" },
				},
			})
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		event = "VeryLazy",
		config = function()
			require("hlslens").setup({ calm_down = true })
			local opts = { noremap = true, silent = true }
			vim.keymap.set(
				"n",
				"n",
				[[<Cmd>execute('normal! ' .. v:count1 .. 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				opts
			)
			vim.keymap.set(
				"n",
				"N",
				[[<Cmd>execute('normal! ' .. v:count1 .. 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				opts
			)
			vim.keymap.set("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
			vim.keymap.set("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
		end,
	},
	{
		"rachartier/tiny-glimmer.nvim",
		event = "VeryLazy",
		config = function()
			-- paste left to yanky highlight; only animate undo/redo
			require("tiny-glimmer").setup({
				overwrite = {
					paste = { enabled = false },
					undo = { enabled = true },
					redo = { enabled = true },
				},
			})
		end,
	},
	{
		"junegunn/vim-easy-align",
		keys = {
			{ "ga", "<Plug>(EasyAlign)", mode = { "x", "n" } },
		},
	},
	{
		"mg979/vim-visual-multi",
		init = function()
			vim.g.VM_leader = { default = ",", visual = ",", buffer = "," }
			vim.g.VM_maps = {
				["Find Under"] = "<C-d>",
				["Find Subword Under"] = "<C-d>",
				["Find Prev"] = "-",
				["Find Next"] = "=",
				["Remove Region"] = "Q",
				["Skip Region"] = "q",
				["Undo"] = "u",
				["Redo"] = "<C-r>",
			}
			vim.g.VM_mouse_mappings = 1
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = {
					line = "<leader>cc",
				},
				opleader = {
					line = "<leader>c",
					block = "<leader>b",
				},
			})
		end,
	},
	"AndrewRadev/splitjoin.vim",
	{
		"mbbill/undotree",
		config = function()
			local g = vim.g

			g.undotree_DiffAutoOpen = 1
			g.undotree_SetFocusWhenToggle = 1
			g.undotree_ShortIndicators = 1
			g.undotree_WindowLayout = 2
			g.undotree_DiffpanelHeight = 8
			g.undotree_SplitWidth = 24

			-- Buffer-local keymaps for undotree windows
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "undotree",
				callback = function()
					local opts = { buffer = true, remap = true, silent = true }
					vim.keymap.set("n", "k", "<plug>UndotreeNextState", opts)
					vim.keymap.set("n", "j", "<plug>UndotreePreviousState", opts)
					vim.keymap.set("n", "K", "5<plug>UndotreeNextState", opts)
					vim.keymap.set("n", "J", "5<plug>UndotreePreviousState", opts)
				end,
			})

			vim.keymap.set("n", "tu", ":UndotreeToggle<CR>", { silent = true })
		end,
		cmd = { "UndotreeToggle" },
	},
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("aerial").setup({
				backends = { "lsp", "treesitter", "markdown", "man" },
				layout = {
					default_direction = "prefer_right",
					min_width = 20,
				},
				show_guides = true,
				filter_kind = false,
				guides = {
					mid_item = "├─",
					last_item = "└─",
					nested_top = "│ ",
					whitespace = "  ",
				},
			})
		end,
		cmd = { "AerialToggle", "AerialOpen", "AerialNavToggle" },
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({})
		end,
		cmd = { "Trouble" },
	},
	{
		"gbprod/yanky.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			local utils = require("utils")
			local map = utils.map

			require("yanky").setup({
				ring = {
					history_length = 100,
					storage = "shada",
					sync_with_numbered_registers = true,
					cancel_event = "update",
				},
				picker = {
					select = {
						action = nil,
					},
					telescope = {
						use_default_mappings = true,
						mappings = nil,
					},
				},
				system_clipboard = {
					sync_with_ring = true,
				},
				highlight = {
					on_put = true,
					on_yank = true,
					timer = 500,
				},
				preserve_cursor_position = {
					enabled = true,
				},
			})

			-- Cycle through yank history with <c-p> / <c-n> in normal mode after paste
			map("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
			map("n", "<c-n>", "<Plug>(YankyNextEntry)")

			-- Open yank history via telescope
			map("n", "<space>y", ":Telescope yank_history<cr>")
		end,
	},
}
