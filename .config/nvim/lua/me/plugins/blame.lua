return {
    "FabijanZulj/blame.nvim",
    config = function()
        require("blame").setup()
        vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle<cr>")
    end,
    opts = {
        commit_detail_view = "vsplit",
    },
}
