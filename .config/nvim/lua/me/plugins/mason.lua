return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            ensure_installed = {
                "rust_analyzer",
                "lua_ls",
                "neocmake",
                "clangd",
                "ruff",
                "pylsp",
            },
        })

        local mason_tool_installer = require("mason-tool-installer")
        mason_tool_installer.setup({
            ensure_installed = {
                -- formatters
                "stylua",
                "gersemi",
                "clang-format",

                -- linters
                "shellcheck",
                "mypy",
                "rumdl",
                "ansible-lint",
            },
        })
    end,
}
