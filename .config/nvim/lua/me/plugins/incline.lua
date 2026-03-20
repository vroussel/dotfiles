return {
	"b0o/incline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local incline = require("incline")
		incline.setup()

		vim.keymap.set("n", "<leader>tfn", incline.toggle, { desc = "Toggle file name (top right)" })
	end,
}
