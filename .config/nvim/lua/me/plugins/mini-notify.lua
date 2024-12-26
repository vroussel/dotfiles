return {
	"echasnovski/mini.notify",
	version = false,
	config = function()
		require("mini.notify").setup({
			--fidget.nvim looks better for this
			lsp_progress = { enable = false },
		})
		vim.notify = require("mini.notify").make_notify()
	end,
}
