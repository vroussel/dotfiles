return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local mason_tool_installer = require("mason-tool-installer")

		mason_tool_installer.setup({
			ensure_installed = {
				-- formatters
				"stylua",
				"prettierd",
				"gersemi",
				"clang-format",

				-- linters
				"ansible-lint", -- used by ansiblels
				"shellcheck",
				"mypy",
			},
		})
	end,
}
