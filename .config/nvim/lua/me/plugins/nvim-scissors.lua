return {
	"chrisgrieser/nvim-scissors",
	dependencies = { "ibhagwan/fzf-lua", "stevearc/dressing.nvim" },
	opts = {
		snippetDir = vim.fn.stdpath("config") .. "/snippets",
		jsonFormatter = "jq",
	},
}
