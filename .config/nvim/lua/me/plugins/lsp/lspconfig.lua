return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"ray-x/lsp_signature.nvim",
		"folke/lazydev.nvim",
	},
	config = function()
		-- vim.lsp.set_log_level(0)
		-- require("vim.lsp.log").set_format_func(vim.inspect)

		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			automatic_installation = true,
			-- automatic_installation = {
			--     exclude = {
			--         "pylsp",
			--     }
			-- }
		})

		local lspconfig = require("lspconfig")
		local keymap = vim.keymap

		local map_opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			map_opts.buffer = bufnr

			-- set keybinds
			map_opts.desc = "Show LSP references"
			keymap.set("n", "gr", vim.lsp.buf.references, map_opts)

			map_opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, map_opts)

			map_opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", map_opts)

			map_opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", map_opts)

			map_opts.desc = "Show LSP type definitions"
			keymap.set("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", map_opts)

			map_opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, map_opts)

			map_opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, map_opts)

			map_opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, map_opts)

			if client.name == "clangd" then
				map_opts.buffer = bufnr

				map_opts.desc = "Go to source/header"
				keymap.set("n", "<leader>aa", function()
					vim.api.nvim_command("ClangdSwitchSourceHeader")
				end, map_opts)

				map_opts.desc = "Go to source/header in vertical split"
				keymap.set("n", "<leader>av", function()
					vim.cmd("vsplit")
					vim.api.nvim_command("ClangdSwitchSourceHeader")
				end, map_opts)

				map_opts.desc = "Go to source/header in horizontal split"
				keymap.set("n", "<leader>ax", function()
					vim.cmd("split")
					vim.api.nvim_command("ClangdSwitchSourceHeader")
				end, map_opts)
			end

			map_opts.desc = "Toggle inlay hints"
			keymap.set("n", "<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, map_opts)

			map_opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", map_opts)
		end

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		lspconfig["rust_analyzer"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Intall ansible-lint via mason
		lspconfig["ansiblels"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["neocmake"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			init_options = {
				format = {
					enable = false,
				},
				lint = {
					enable = false,
				},
			},
		})

		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- lspconfig["tsserver"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })

		lspconfig["volar"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		--lspconfig["svelte"].setup{
		--    capabilities = capabilities,
		--    on_attach = on_attach,
		--}

		-- lspconfig["html"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })

		lspconfig["ruff"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			init_options = {
				settings = {
					-- Any extra CLI arguments for `ruff` go here.
					args = {},
				},
			},
		})

		lspconfig["pylsp"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				pylsp = {
					plugins = {
						-- I use black for formatting:
						autopep8 = { enabled = false },
						mccabe = { enabled = false },
						pycodestyle = { enabled = false },
						pyflakes = { enabled = false },
						yapf = { enabled = false },
					},
				},
			},
		})

		lspconfig["lua_ls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
					},
					runtime = {
						version = "LuaJIT",
					},
				},
			},
		})

		lspconfig["perlnavigator"].setup({})
	end,
}
