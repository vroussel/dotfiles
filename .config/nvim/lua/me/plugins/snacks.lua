return {
    "folke/snacks.nvim",
    config = function()
        local snacks = require("snacks")
        snacks.setup({
            input = {},
            lazygit = { win = { ft = "lazygit" } },
        })

        vim.keymap.set("n", "<leader>gg", snacks.lazygit.open, { desc = "Lazygit" })
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "lazygit",
            callback = function()
                vim.keymap.set("t", "<a-q>", "<cmd>close<cr>", { buffer = true })
            end,
        })
    end,
}
