return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "folke/neodev.nvim", config = true },
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"ray-x/lsp_signature.nvim",
	},
	config = function()
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
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
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", opts)

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			if client.name == "clangd" then
				opts.buffer = bufnr

				opts.desc = "Go to source/header"
				keymap.set("n", "<leader>aa", function()
					vim.api.nvim_command("ClangdSwitchSourceHeader")
				end, opts)

				opts.desc = "Go to source/header in vertical split"
				keymap.set("n", "<leader>av", function()
					vim.cmd("vsplit")
					vim.api.nvim_command("ClangdSwitchSourceHeader")
				end, opts)

				opts.desc = "Go to source/header in horizontal split"
				keymap.set("n", "<leader>ax", function()
					vim.cmd("split")
					vim.api.nvim_command("ClangdSwitchSourceHeader")
				end, opts)
			end

			opts.desc = "Toggle inlay hints"
			keymap.set("n", "<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, opts)

			-- opts.desc = "Format buffer or selection"
			-- keymap.set({"n", "v"}, "<leader>fo", function() vim.lsp.buf.format { async = true } end, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)

			require("lsp_signature").on_attach({
				toggle_key = "<C-h>",
				floating_window = false,
				hint_prefix = "󰅏",
			}, bufnr)
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
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

		lspconfig["cmake"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
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

		lspconfig["ruff_lsp"].setup({
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
						yapf = { enabled = false },
						rope_autoimport = { enabled = true },
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
				},
			},
		})

		require("lspconfig").perlnavigator.setup({})
	end,
}
