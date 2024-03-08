return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"nvim-telescope/telescope.nvim", -- optional
		"sindrets/diffview.nvim", -- optional
	},
	config = function()
		local neogit = require("neogit")

		neogit.setup({
			kind = "vsplit",
		})

		vim.keymap.set("n", "<leader>g", neogit.open)
	end,
}
