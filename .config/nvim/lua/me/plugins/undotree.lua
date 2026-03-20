return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set("n", "<leader>U", "<cmd>UndotreeShow|UndotreeFocus<CR>", { desc = "Toggle UndoTree" })
    end,
}
