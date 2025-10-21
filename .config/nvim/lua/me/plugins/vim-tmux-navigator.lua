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
        { "<A-h>", "<cmd>TmuxNavigateLeft<cr>" },
        { "<A-j>", "<cmd>TmuxNavigateDown<cr>" },
        { "<A-k>", "<cmd>TmuxNavigateUp<cr>" },
        { "<A-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
    init = function()
        vim.g.tmux_navigator_no_mappings = 1
    end,
}
