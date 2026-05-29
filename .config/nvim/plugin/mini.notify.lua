vim.pack.add({ "https://github.com/nvim-mini/mini.notify" })

require("mini.notify").setup({
    --fidget.nvim looks better for this
    lsp_progress = { enable = false },
})
vim.notify = require("mini.notify").make_notify()
