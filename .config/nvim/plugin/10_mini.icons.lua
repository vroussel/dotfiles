local setup = function()
    vim.pack.add({ "https://github.com/nvim-mini/mini.icons" })
    local icons = require("mini.icons")
    icons.setup()
    icons.mock_nvim_web_devicons() -- lualine
end

require("plugin_deps").register("mini.icons", setup)
