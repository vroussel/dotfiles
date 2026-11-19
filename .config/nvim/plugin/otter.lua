vim.pack.add({
    "https://github.com/jmbuhr/otter.nvim",
})

local otter = require("otter")
otter.setup({
    buffers = {
        write_to_disk = false,
    },
})

vim.api.nvim_create_autocmd({ "BufNew", "BufRead" }, {
    pattern = { "*.rs", "*.md", ".c", "*.python" },
    callback = function()
        otter.activate()
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
        end
    end,
})
