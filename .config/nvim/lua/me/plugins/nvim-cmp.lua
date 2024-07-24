---@diagnostic disable: missing-fields
return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"dcampos/nvim-snippy",
		"dcampos/cmp-snippy",
		"honza/vim-snippets",
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")

		local lspkind = require("lspkind")

		local snippy = require("snippy")
		vim.keymap.set({ "i", "s" }, "<tab>", snippy.mapping.next("<tab>"))
		vim.keymap.set({ "i", "s" }, "<s-tab>", snippy.mapping.previous("<s-tab>"))
		vim.keymap.set({ "x", "n" }, "<leader><tab>", snippy.mapping.cut_text, { remap = true })
		vim.keymap.set({ "n" }, "<leader><tab><tab>", "^<leader><tab>$", { remap = true })

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = {
				expand = function(args)
					snippy.expand_snippet(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "snippy" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
				}),
			},
		})

		-- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		-- cmp.setup.cmdline({ "/", "?" }, {
		-- 	mapping = cmp.mapping.preset.cmdline(),
		-- 	sources = {
		-- 		{ name = "buffer" },
		-- 	},
		-- })
		--
		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			completion = {
				autocomplete = false,
			},
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
