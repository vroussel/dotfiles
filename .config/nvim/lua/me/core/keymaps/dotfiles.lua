vim.keymap.set("n", "<leader>cn", function()
    vim.cmd("tabnew ~/.config/nvim/")
    vim.cmd("tcd ~/.config/nvim")
end, { desc = "neovim conf" })

vim.keymap.set("n", "<leader>ci", function()
    vim.cmd("tabnew ~/.config/i3/config")
    vim.cmd("tcd ~/.config/i3")
end, { desc = "i3 conf" })

vim.keymap.set("n", "<leader>cb", function()
    vim.cmd("tabnew ~/.bashrc")
    vim.cmd("tcd ~")
end, { desc = "bashrc conf" })

vim.keymap.set("n", "<leader>cl", function()
    vim.cmd("tabnew ~/.config/alacritty/alacritty.toml")
    vim.cmd("tcd ~/.config/alacritty")
end, { desc = "alacritty conf" })

vim.keymap.set("n", "<leader>cf", function()
    vim.cmd("tabnew ~/.config/fish/config.fish")
    vim.cmd("tcd ~/.config/fish")
end, { desc = "fish conf" })
