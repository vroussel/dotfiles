vim.pack.add({ "https://github.com/folke/lazydev.nvim" })
-- require("lazydev").setup()
require("lazydev").setup({
    enabled = function(root_dir)
        local config = vim.fs.normalize(vim.fn.stdpath("config"))
        root_dir = vim.fs.normalize(root_dir)

        return root_dir == config or root_dir:find("^" .. vim.pesc(config) .. "/") ~= nil
    end,
})
