return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "saghen/blink.cmp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { "antosha417/nvim-lsp-file-operations", config = true },
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "ray-x/lsp_signature.nvim",
        "folke/lazydev.nvim",
    },
    config = function()
        -- vim.lsp.set_log_level(0)
        -- require("vim.lsp.log").set_format_func(vim.inspect)
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            automatic_installation = true,
            -- automatic_installation = {
            --     exclude = {
            --         "pylsp",
            --     }
            -- }
        })

        local lspconfig = require("lspconfig")

        local on_attach = function(client, bufnr)
            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end

            local fzf = require("fzf-lua")
            map("n", "gr", fzf.lsp_references, "Show LSP references")
            map("n", "gd", fzf.lsp_declarations, "Go to declaration")
            map("n", "gi", fzf.lsp_implementations, "Show LSP implementations")
            map("n", "gD", fzf.lsp_typedefs, "Show LSP type definitions")
            map({ "n", "v" }, "<leader>ca", fzf.lsp_code_actions, "See available code actions")
            map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
            map("n", "K", vim.lsp.buf.hover, "Show documentation")

            if client.name == "clangd" then
                map("n", "<leader>aa", function()
                    vim.api.nvim_command("ClangdSwitchSourceHeader")
                end, "Go to source/header")

                map("n", "<leader>av", function()
                    vim.cmd("vsplit")
                    vim.api.nvim_command("ClangdSwitchSourceHeader")
                end, "Go to source/header in vertical split")

                map("n", "<leader>ax", function()
                    vim.cmd("split")
                    vim.api.nvim_command("ClangdSwitchSourceHeader")
                end, "Go to source/header in horizontal split")
            end

            map("n", "<leader>tih", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "Toggle inlay hints")
        end

        local capabilities = require("blink.cmp").get_lsp_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        lspconfig["rust_analyzer"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy",
                    },
                },
            },
        })

        -- Intall ansible-lint via mason
        lspconfig["ansiblels"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["clangd"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["neocmake"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            init_options = {
                format = {
                    enable = false,
                },
                lint = {
                    enable = false,
                },
            },
        })

        lspconfig["tailwindcss"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- lspconfig["tsserver"].setup({
        -- 	capabilities = capabilities,
        -- 	on_attach = on_attach,
        -- })

        lspconfig["volar"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        --lspconfig["svelte"].setup{
        --    capabilities = capabilities,
        --    on_attach = on_attach,
        --}

        -- lspconfig["html"].setup({
        -- 	capabilities = capabilities,
        -- 	on_attach = on_attach,
        -- })

        lspconfig["ruff"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            init_options = {
                settings = {
                    -- Any extra CLI arguments for `ruff` go here.
                    args = {},
                },
            },
        })

        lspconfig["pylsp"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                pylsp = {
                    plugins = {
                        -- I use black for formatting:
                        autopep8 = { enabled = false },
                        mccabe = { enabled = false },
                        pycodestyle = { enabled = false },
                        pyflakes = { enabled = false },
                        yapf = { enabled = false },
                    },
                },
            },
        })

        lspconfig["lua_ls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = false,
                    },
                    runtime = {
                        version = "LuaJIT",
                    },
                },
            },
        })

        lspconfig["perlnavigator"].setup({})
    end,
}
