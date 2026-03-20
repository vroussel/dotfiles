vim.api.nvim_create_autocmd("BufWritePost", {
    buffer = 0,
    command = "silent !plantuml %",
})

vim.api.nvim_buf_create_user_command(0, "Img", "silent !feh --auto-reload %:p:r" .. ".png &", {})
