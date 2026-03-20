return {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",

    version = "1.*",

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
        signature = {
            enabled = true,
        },

        completion = {
            menu = { auto_show = false },
        },
    },
}
