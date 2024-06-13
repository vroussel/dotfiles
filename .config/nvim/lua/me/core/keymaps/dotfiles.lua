vim.keymap.set("n", "<leader>cn", function()
	vim.cmd("tabnew ~/.config/nvim/")
end, { desc = "neovim conf" })

vim.keymap.set("n", "<leader>ci", function()
	vim.cmd("tabnew ~/.config/i3/config")
end, { desc = "i3 conf" })

vim.keymap.set("n", "<leader>cb", function()
	vim.cmd("tabnew ~/.bashrc")
end, { desc = "bashrc conf" })
