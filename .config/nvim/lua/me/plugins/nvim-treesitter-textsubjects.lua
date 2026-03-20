---@diagnostic disable: missing-fields
return {
    "RRethy/nvim-treesitter-textsubjects",
    lazy = true,
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            textsubjects = {
                enable = true,
                prev_selection = ",", -- (Optional) keymap to select the previous selection
                keymaps = {
                    ["."] = "textsubjects-smart",
                },
            },
        })
    end,
}
