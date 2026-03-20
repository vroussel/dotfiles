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

				-- linters
				"ansible-lint", -- used by ansiblels
				"shellcheck",
				"mypy",
			},
		})

		-- local update_deps = function()
		-- 	vim.api.nvim_cmd(vim.api.nvim_parse_cmd("PylspInstall python-lsp-ruff pylsp-mypy", {}), { output = true })
		-- end
		-- vim.api.nvim_create_user_command("UpdatePythonDeps", update_deps, {})
	end,
}
