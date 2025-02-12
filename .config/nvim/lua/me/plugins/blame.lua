return {
    "FabijanZulj/blame.nvim",
    config = function()
        require("blame").setup()

        vim.api.nvim_create_autocmd("User", {
            pattern = "BlameViewOpened",
            callback = function(event)
                local blame_type = event.data
                if blame_type == "window" then
                    require("barbecue.ui").toggle(false)
                end
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "BlameViewClosed",
            callback = function(event)
                local blame_type = event.data
                if blame_type == "window" then
                    require("barbecue.ui").toggle(true)
                end
            end,
        })

        vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle<cr>")
    end,
    opts = {
        commit_detail_view = "vsplit",
    },
}
