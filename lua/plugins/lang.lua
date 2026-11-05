return {
	{
		"dart-lang/dart-vim-plugin",
		ft = { "dart" },
		config = function()
			local g = vim.g

			g.dart_style_guide = 2
			g.dart_format_on_save = 1
			g.dartfmt_options = { "-l 100" }
		end,
	},
	{ "f-person/pubspec-assist-nvim", ft = { "pubspec.yaml" } },
	{
		"akinsho/flutter-tools.nvim",
		ft = { "dart" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			require("flutter-tools").setup({
				ui = {
					border = "single",
					notification_style = "plugin",
				},
				decorations = {
					statusline = {
						app_version = true,
						device = true,
						project_config = true,
					},
				},
				debugger = {
					enabled = false,
				},
				flutter_lookup_cmd = nil,
				fvm = false,
				widget_guides = {
					enabled = true,
				},
				closing_tags = {
					highlight = "Comment",
					prefix = "// ",
					enabled = true,
				},
				dev_log = {
					enabled = true,
					notify_errors = false,
					open_cmd = "tabedit",
				},
				dev_tools = {
					autostart = false,
					auto_open_browser = false,
				},
				lsp = {
					on_attach = function(client, bufnr)
						-- Enable document color via built-in LSP (Neovim 0.12+)
						vim.lsp.document_color.enable(true, bufnr, { style = "virtual" })

						-- LSP keymaps (buffer-local)
						local opts = { buffer = bufnr, silent = true }
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
						vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
						vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
						vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
						vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
						vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
						vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)

						if client:supports_method("textDocument/formatting") then
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr,
								callback = function()
									vim.lsp.buf.format({ bufnr = bufnr })
								end,
							})
						end
					end,
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					settings = {
						showTodos = true,
						completeFunctionCalls = true,
						analysisExcludedFolders = {},
					},
				},
			})
		end,
	},
	{
		"supermaven-inc/supermaven-nvim",
		event = "VeryLazy",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<C-l>",
					-- clear_suggestion = '<C-\\>',
					accept_word = "<C-j>",
				},
				ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
				color = {
					suggestion_color = "#7c7c7c",
					cterm = 244,
				},
				disable_inline_completion = false,
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			enabled = false,
			preset = "none",
			max_file_size = 10.0,
			debounce = 100,
			heading = {
				sign = true,
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			},
			code = {
				sign = false,
				width = "full",
				disable_background = { "markdown" },
			},
			checkbox = {
				enabled = true,
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰱒 " },
			},
			table = { enabled = true },
			pipe_table = {
				preset = "none",
				cell = "trimmed",
				style = "normal",
				padding = 1,
				border = {
					"",
					"",
					"",
					"",
					" ",
					"",
					"",
					"",
					"",
					" ",
					"─",
				},
			},
		},
		keys = {
			{ "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown render" },
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_auto_close = 1
		end,
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown browser preview" },
		},
	},
}
