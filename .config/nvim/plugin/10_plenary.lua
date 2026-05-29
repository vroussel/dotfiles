local setup = function()
    vim.pack.add({ "https://www.github.com/nvim-lua/plenary.nvim" })
end

require("plugin_deps").register("plenary", setup)
