return {
    "christoomey/vim-tmux-navigator",
    enabled = true,
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
    },
    keys = {
        { mode = "n", "<A-h>", "<cmd>TmuxNavigateLeft<cr>" },
        { mode = "n", "<A-j>", "<cmd>TmuxNavigateDown<cr>" },
        { mode = "n", "<A-k>", "<cmd>TmuxNavigateUp<cr>" },
        { mode = "n", "<A-l>", "<cmd>TmuxNavigateRight<cr>" },
        { mode = "t", "<A-h>", "<cmd>TmuxNavigateLeft<cr>" },
        { mode = "t", "<A-j>", "<cmd>TmuxNavigateDown<cr>" },
        { mode = "t", "<A-k>", "<cmd>TmuxNavigateUp<cr>" },
        { mode = "t", "<A-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
    init = function()
        vim.g.tmux_navigator_no_mappings = 1
    end,
}
