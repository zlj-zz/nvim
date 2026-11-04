return {
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		config = function()
			local M = {}

			M.enabled = false

			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					vue = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					less = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					jsonc = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					["markdown.mdx"] = { "prettier" },
					graphql = { "prettier" },
					sh = { "shfmt" },
					bash = { "shfmt" },
					zsh = { "shfmt" },
					go = { "gofumpt", "goimports" },
				},
				format_on_save = function(bufnr)
					if not M.enabled then
						return
					end
					return {
						timeout_ms = 500,
						lsp_fallback = true,
					}
				end,
			})

			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_fallback = true, range = range })
			end, { range = true })

			vim.api.nvim_create_user_command("FormatToggle", function()
				M.enabled = not M.enabled
				vim.notify("Format on save: " .. (M.enabled and "ON" or "OFF"))
			end, {})

			vim.keymap.set({ "n", "v" }, "<leader>cf", ":Format<CR>", { silent = true, desc = "Format" })

			return M
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local function on_attach(client, bufnr)
				local opts = { buffer = bufnr, silent = true }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)

				-- Inlay hints: off by default; <leader>ih toggles buffer-local
				if client:supports_method("textDocument/inlayHint") then
					vim.keymap.set("n", "<leader>ih", function()
						local on = not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
						vim.lsp.inlay_hint.enable(on, { bufnr = bufnr })
					end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
				end

				-- Code Lens: on demand only (no auto refresh/display)
				if client:supports_method("textDocument/codeLens") then
					vim.keymap.set("n", "<leader>cl", function()
						vim.lsp.codelens.refresh()
						vim.lsp.codelens.run()
					end, opts)
				end

				-- highlight word under cursor
				if client:supports_method("textDocument/documentHighlight") then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd("CursorMoved", {
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end

			local gopls_config = {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							shadow = true,
						},
						staticcheck = true,
						gofumpt = true,
						-- Keep call-site param names only; rest were redraw-heavy when inlays on.
						hints = {
							parameterNames = true,
						},
					},
				},
			}

			local servers = {
				gopls = gopls_config,
				bashls = { on_attach = on_attach, capabilities = capabilities },
				jsonls = { on_attach = on_attach, capabilities = capabilities },
				html = { on_attach = on_attach, capabilities = capabilities },
				cssls = { on_attach = on_attach, capabilities = capabilities },
				basedpyright = {
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						basedpyright = {
							analysis = {
								typeCheckingMode = "standard",
								diagnosticMode = "openFilesOnly",
								useLibraryCodeForTypes = true,
								diagnosticSeverityOverrides = {
									reportUnusedParameter = "none",
								},
							},
						},
					},
				},
				-- pyright = { on_attach = on_attach, capabilities = capabilities },
				yamlls = { on_attach = on_attach, capabilities = capabilities },
				vtsls = {
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						typescript = {
							preferences = {
								importModuleSpecifier = "relative",
							},
						},
					},
				},
				sourcekit = { on_attach = on_attach, capabilities = capabilities }, -- Swift / Objective-C
				rust_analyzer = { on_attach = on_attach, capabilities = capabilities },
				lua_ls = {
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
							telemetry = { enable = false },
						},
					},
				},
			}

			-- Neovim 0.11+ uses vim.lsp.config, older versions use lspconfig
			if vim.lsp.config then
				for name, cfg in pairs(servers) do
					vim.lsp.config(name, cfg)
					vim.lsp.enable(name)
				end
			else
				local lspconfig = require("lspconfig")
				for name, cfg in pairs(servers) do
					lspconfig[name].setup(cfg)
				end
			end
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Load snippets: VSCode format (friendly-snippets) + Lua format (custom)
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/luasnippets" })

			-- Integrate nvim-autopairs with cmp (handles pairing on confirm)
			local ok_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
			if ok_autopairs then
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end

			cmp.setup({
				window = {
					completion = { border = "single" },
					documentation = { border = "single" },
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
