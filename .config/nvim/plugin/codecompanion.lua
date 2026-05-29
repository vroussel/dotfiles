require("plugin_deps").use({ "plenary" })

vim.pack.add({ "https://www.github.com/olimorris/codecompanion.nvim" })

-- TODO
-- require("codecompanion").setup({})

vim.keymap.set({ "n", "v" }, "<leader>ccn", "<cmd>CodeCompanionChat<cr>", { noremap = true, silent = true })
vim.keymap.set({ "v" }, "<leader>cca", "<cmd>CodeCompanionChat Add<cr><Esc>", { noremap = true, silent = true })
vim.cmd([[cab cc CodeCompanion]])
