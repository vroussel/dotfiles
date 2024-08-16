return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				vue = { "prettierd" },
				cmake = { "gersemi" },
			},
		})

		-- format on save
		local format_augroup = vim.api.nvim_create_augroup("format", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			group = format_augroup,
			callback = function(args)
				conform.format({
					bufnr = args.buf,
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>fo", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
