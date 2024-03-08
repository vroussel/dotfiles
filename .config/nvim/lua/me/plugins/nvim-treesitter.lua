---@diagnostic disable: missing-fields
return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"RRethy/nvim-treesitter-textsubjects",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
	},
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = {
				enable = true,
			},
			-- indent = { enable = true },
			ensure_installed = {
				"json",
				"yaml",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"c",
				"cpp",
				"python",
				"rust",
				"vimdoc",
				"regex",
			},
			-- incremental_selection = {
			-- 	enable = true,
			-- 	keymaps = {
			-- 		init_selection = false,
			-- 		node_incremental = "<cr>",
			-- 		scope_incremental = false,
			-- 		node_decremental = "<bs>",
			-- 	},
			-- },
		})

		vim.keymap.set("n", "<leader>ttc", function()
			vim.api.nvim_command("TSContextToggle")
		end, { desc = "Toggle Treesitter context" })
	end,
}
