return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				-- preview = {
				--     treesitter = false,
				-- },
				mappings = {
					i = {
						["<c-d>"] = actions.preview_scrolling_down,
						["<c-u>"] = actions.preview_scrolling_up,
						["<c-f>"] = actions.results_scrolling_down,
						["<c-b>"] = actions.results_scrolling_up,
					},
					n = {
						["<c-d>"] = actions.preview_scrolling_down,
						["<c-u>"] = actions.preview_scrolling_up,
						["<c-f>"] = actions.results_scrolling_down,
						["<c-b>"] = actions.results_scrolling_up,
						["<c-c>"] = actions.close,
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("undo")

		vim.keymap.set("n", "<leader>km", "<cmd>Telescope keymaps<CR>")
		vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
		vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
		vim.keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<CR>")
		vim.keymap.set("n", "<leader>o", "<cmd>Telescope oldfiles<CR>")
		vim.keymap.set("n", "<leader>/", "<cmd>Telescope search_history<CR>")
		vim.keymap.set("n", "<leader>:", "<cmd>Telescope command_history<CR>")
		vim.keymap.set("n", "<leader>tr", "<cmd>Telescope resume<CR>")
		vim.keymap.set("n", "<leader>tt", "<cmd>Telescope treesitter<CR>")
		vim.keymap.set("n", "<leader>tu", "<cmd>Telescope undo<CR>")
	end,
}
