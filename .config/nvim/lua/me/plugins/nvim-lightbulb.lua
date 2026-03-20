return {
    "kosayoda/nvim-lightbulb",
    config = function()
        require("nvim-lightbulb").setup({
            autocmd = {
                text = "",
                enabled = true,
                updatetime = -1,
            },
            sign = {
                text = "",
                enabled = false,
            },
            virtual_text = {
                text = "",
                enabled = true,
            },
        })
    end,
}
