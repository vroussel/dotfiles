require("me.core.keymaps")
require("me.core.options")
require("me.core.trailing_spaces")
require("me.core.title")

-- auto resize windows when terminal gets resized
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
})
