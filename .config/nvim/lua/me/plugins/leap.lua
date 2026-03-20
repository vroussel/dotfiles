return {
    "ggandor/leap.nvim",
    config = function()
        vim.keymap.set("n", "<leader>l", "<Plug>(leap)")
        vim.keymap.set("n", "<leader>L", "<Plug>(leap-anywhere)")
    end,
}
