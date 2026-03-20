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
                "perlnavigator",
                "dockerls",
                "neocmake",
                "ansiblels",
                "clangd",
                "tailwindcss",
                "volar",
                "ruff",
                "pylsp",
            },
        })

        local mason_tool_installer = require("mason-tool-installer")
        mason_tool_installer.setup({
            ensure_installed = {
                -- formatters
                "stylua",
                "prettierd",
                "gersemi",
                "clang-format",

                -- linters
                "ansible-lint", -- used by ansiblels
                "shellcheck",
                "mypy",
                "markdownlint",
            },
        })
    end,
}
