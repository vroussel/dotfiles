vim.pack.add({
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/mason-org/mason.nvim",
})

local mason = require("mason")
mason.setup({})

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
    ensure_installed = {
        "rust_analyzer",
        "lua_ls",
        "neocmake",
        "clangd",
        "pylsp",
        "ruff",
    },
})

local mason_tool_installer = require("mason-tool-installer")
mason_tool_installer.setup({
    ensure_installed = {
        -- formatters
        "stylua",
        "yamlfix",
        "gersemi",
        "clang-format",

        -- linters
        "shellcheck",
        "rumdl",
        "ansible-lint",
    },
})

vim.keymap.set("n", "<leader><leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })
