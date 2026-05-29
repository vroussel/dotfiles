require("plugin_deps").use({ "mini.icons" })

vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
    keymaps = {
        ["<C-v>"] = { "actions.select", opts = { close = true, vertical = true }, mode = "n" },
        ["<C-x>"] = { "actions.select", opts = { close = true, horizontal = true }, mode = "n" },
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
