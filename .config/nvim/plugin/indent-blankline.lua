vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })

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
