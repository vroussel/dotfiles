return {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",

    version = "*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = "default" },

        appearance = {
            nerd_font_variant = "normal",
        },

        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
        },
        completion = {
            menu = {
                border = "rounded",
            },
            documentation = {
                window = { border = "rounded" },
            },
        },
        signature = {
            enabled = true,
            window = { border = "rounded" },
        },
    },
    opts_extend = { "sources.default" },
}
