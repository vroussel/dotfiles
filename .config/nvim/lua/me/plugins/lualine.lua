return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"otavioschwanck/arrow.nvim",
	},
	config = function()
		local lazy_status = require("lazy.status")
		local statusline = require("arrow.statusline")

		require("lualine").setup({
			options = {
				theme = "tokyonight",
			},
			sections = {
				lualine_c = {
					function()
						return statusline.text_for_statusline_with_icons(nil)
					end,
					"filename",
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
