return {
    "folke/zen-mode.nvim",
    config = function()
        local zen = require("zen-mode")
        zen.setup()
        vim.keymap.set("n", "<leader>z", zen.toggle)
    end,
}
