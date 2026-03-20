return {
	"s1n7ax/nvim-window-picker",
	name = "window-picker",
	event = "VeryLazy",
	version = "2.*",
	config = function()
		require("window-picker").setup({
			hint = "floating-big-letter",
			filter_rules = {
				autoselect_one = true,
				include_current_win = true,
				bo = {
					-- if the file type is one of following, the window will be ignored
					filetype = { "NvimTree", "neo-tree", "notify", "aerial", "TelescopePrompt" },
					buftype = { "prompt" },
				},
			},
		})
	end,
}
