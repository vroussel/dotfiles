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

local function oil_ssh()
    local c = vim.fn.getchar(0)

    if type(c) == "number" then
        c = vim.fn.nr2char(c)
    else
        c = ""
    end

    return "Oil oil-ssh://" .. (c:match("%s") and "" or c)
end

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("ca", "ssh", oil_ssh, { expr = true })
