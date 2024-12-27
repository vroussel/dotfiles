return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        vim.o.foldcolumn = "1" -- '0' is not bad
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

        local ufo = require("ufo")

        vim.keymap.set("n", "z'", ufo.openAllFolds)
        vim.keymap.set("n", "zh", ufo.closeAllFolds)
        vim.keymap.set("n", "zm", ufo.closeFoldsWith)
        vim.keymap.set("n", "zj", "1zm", { remap = true })
        vim.keymap.set("n", "zk", "2zm", { remap = true })
        vim.keymap.set("n", "zl", "3zm", { remap = true })
        vim.keymap.set("n", "z;", "4zm", { remap = true })

        local action = require("ufo.action")
        vim.keymap.set("n", "]z", action.goNextClosedFold)
        vim.keymap.set("n", "[z", action.goPreviousClosedFold)

        ufo.setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,
        })
    end,
}
