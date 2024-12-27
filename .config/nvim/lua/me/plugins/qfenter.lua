return {
    "yssl/QFEnter",
    config = function()
        vim.g.qfenter_keymap = {
            vopen = { "<c-v>" },
            hopen = { "<c-x>" },
            topen = { "<c-t>" },
        }
    end,
}
