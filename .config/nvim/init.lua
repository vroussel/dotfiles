require("options")
require("keymaps")
require("lazygit")

-- auto resize windows when terminal gets resized
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
})

-- Highlight trailing whitespaces and bind keymap to remove them
vim.api.nvim_set_hl(0, "ExtraWhitespace", { fg = "red", bg = "red" })
local whitespace_augroup = vim.api.nvim_create_augroup("whitespace", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*",
    group = whitespace_augroup,
    callback = function()
        vim.fn.matchadd("ExtraWhitespace", [[\s\+$]])
    end,
})
vim.keymap.set("n", "<leader>ts", [[<cmd>%s/\s\+$//g<cr>]], { desc = "Delete trailing spaces" })
