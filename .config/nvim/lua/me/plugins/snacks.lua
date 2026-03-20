return {
    "folke/snacks.nvim",
    config = function()
        local snacks = require("snacks")
        snacks.setup({
            input = {},
        })
    end,
}
