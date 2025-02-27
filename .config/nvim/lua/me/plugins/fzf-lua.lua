return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local fzf = require("fzf-lua")

        fzf.setup({
            "telescope",
            oldfiles = { cwd_only = true, include_current_session = true },
        })

        fzf.register_ui_select()

        vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Find grep" })
        vim.keymap.set("n", "<leader>fw", fzf.grep_cword, { desc = "Find grep (word under cursor)" })
        vim.keymap.set("n", "<leader>fh", fzf.helptags, { desc = "Find help" })
        vim.keymap.set("n", "<leader>fo", fzf.oldfiles, { desc = "Find old files" })
        vim.keymap.set("n", "<leader>fr", fzf.resume, { desc = "Find (resume)" })
        vim.keymap.set("n", "<leader>F", fzf.builtin, { desc = "Find anything" })
    end,
}
