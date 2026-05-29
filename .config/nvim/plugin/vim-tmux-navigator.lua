vim.g.tmux_navigator_no_mappings = 1
vim.pack.add({ "https://github.com/christoomey/vim-tmux-navigator" })

vim.keymap.set("n", "<A-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<A-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<A-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<A-l>", "<cmd>TmuxNavigateRight<cr>")
vim.keymap.set("t", "<A-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("t", "<A-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("t", "<A-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("t", "<A-l>", "<cmd>TmuxNavigateRight<cr>")
