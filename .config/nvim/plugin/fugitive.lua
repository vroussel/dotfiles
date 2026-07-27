vim.pack.add({ "https://github.com/tpope/vim-fugitive" })

vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>")

-- Fix wrong alignment between dropbar (or other) and fugitive blame
vim.api.nvim_create_autocmd("FileType", {
    desc = "Set buffer-local options for fugitive blame buffers.",
    group = vim.api.nvim_create_augroup("FugitiveSettings", {}),
    pattern = "fugitiveblame",
    callback = function()
        local win_alt = vim.fn.win_getid(vim.fn.winnr("#"))
        vim.opt_local.winbar = vim.api.nvim_win_is_valid(win_alt) and vim.wo[win_alt].winbar ~= "" and " " or ""
    end,
})
