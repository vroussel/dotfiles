vim.pack.add({ "https://github.com/meanderingprogrammer/render-markdown.nvim" })

require("render-markdown").setup({
    completions = { lsp = { enabled = false } },
})

vim.keymap.set("n", "<leader>mdp", "<cmd>RenderMarkdown preview<cr>", { desc = "Open split markdown preview" })
