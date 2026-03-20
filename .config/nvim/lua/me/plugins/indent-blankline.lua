return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        local ibl = require("ibl")
        ibl.setup({
            enabled = true,
            indent = {
                char = "┊",
            },
            scope = {
                enabled = false,
            },
        })
        vim.keymap.set("n", "<leader>til", function()
            vim.api.nvim_command("IBLToggle")
        end, { desc = "Toggle indent lines" })
    end,
}
