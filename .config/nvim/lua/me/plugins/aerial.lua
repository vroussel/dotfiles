return {
	"stevearc/aerial.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({
			layout = {
				default_direction = "right",
				placement = "edge",
			},
			attach_mode = "global",
			-- optionally use on_attach to set keymaps when aerial has attached to a buffer
			on_attach = function(bufnr)
				-- Jump forwards/backwards with '{' and '}'
				vim.keymap.set("n", "[s", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "]s", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		})
		-- You probably also want to set a keymap to toggle aerial
		vim.keymap.set("n", "<c-Bslash>", "<cmd>AerialToggle!<CR>")
		vim.keymap.set("n", "<a-Bslash>", "<cmd>AerialOpen<CR>")
	end,
}
