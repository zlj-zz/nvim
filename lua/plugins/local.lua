local utils = require("utils")

return {
	{
		"zlj-zz/loom.nvim",
		dir = utils.lazy_safe_dif("~/projects/loom.nvim"),
		dependencies = { "nvim-lua/plenary.nvim" },
		-- keys-only: avoid startup require of telescope via load_extension("loom")
		keys = {
			{ "<leader>ls", "<cmd>LoomSave<cr>", desc = "Loom save" },
			{ "<leader>ll", "<cmd>LoomLoad<cr>", desc = "Loom load" },
			{ "<leader>lL", "<cmd>LoomList<cr>", desc = "Loom list" },
			{ "<leader>lw", "<cmd>LoomWorkspaceSave<cr>", desc = "Loom workspace save" },
			{ "<leader>lW", "<cmd>LoomWorkspaceLoad<cr>", desc = "Loom workspace load" },
			{ "<leader>lc", "<cmd>LoomCleanup<cr>", desc = "Loom cleanup" },
			{ "<leader>lS", "<cmd>LoomSwitch<cr>", desc = "Loom switch" },
		},
		config = function()
			require("loom").setup({
				autosave = {
					enabled = false,
					interval_minutes = 30,
					on_events = { "BufWritePost" },
					max_auto_snaps = 10,
				},
				cleanup = {
					max_snapshots = 50,
					auto_cleanup_after_days = 90,
				},
				integrations = {
					telescope = true,
					which_key = false,
				},
			})

			local ok, telescope = pcall(require, "telescope")
			if ok then
				telescope.load_extension("loom")
			end
		end,
	},
	{
		"Isrothy/neominimap.nvim",
		dir = utils.lazy_safe_dif("~/projects/neominimap.nvim"),
		version = "v3.x.x",
		lazy = false,
		init = function()
			-- The following options are recommended when layout == "float"
			-- vim.opt.wrap = false
			vim.opt.sidescrolloff = 36 -- Set a large value

			vim.g.neominimap = {
				auto_enable = false,
				width = 15,
				exclude_filetypes = { "help", "dashboard", "lazy", "mason", "neo-tree" },
				viewport = {
					enabled = true,
				},
			}
		end,
		keys = {
			{ "<leader>nm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle minimap" },
			{ "<leader>nr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh minimap" },
		},
	},
}
