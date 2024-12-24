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
		local keymap = vim.keymap

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gr", vim.lsp.buf.references, opts)

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
		end

		local capabilities = require("blink.cmp").get_lsp_capabilities()

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

		require("lspconfig").perlnavigator.setup({})
	end,
}
