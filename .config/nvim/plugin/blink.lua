vim.pack.add({
    "https://github.com/rafamadriz/friendly-snippets",
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("1.*"),
    },
})

require("blink.cmp").setup({
    keymap = { preset = "default" },

    appearance = {
        nerd_font_variant = "normal",
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
            codecompanion = { "codecompanion" },
        },
    },
    signature = {
        enabled = true,
    },

    completion = {
        menu = {
            auto_show = true,
        },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
})
