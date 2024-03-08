return {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
        local tokyonight = require("tokyonight")
        tokyonight.setup({
            style = "storm",
            on_highlights = function(highlights, colors)
                highlights.CursorLineNr = {
                    fg = colors.yellow
                }
            end
        })
        vim.cmd([[colorscheme tokyonight]])
    end,
}
