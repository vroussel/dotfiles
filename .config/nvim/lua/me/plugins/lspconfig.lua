return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "folke/lazydev.nvim",
    },
    config = function()
        -- vim.lsp.set_log_level(0)
        -- require("vim.lsp.log").set_format_func(vim.inspect)
        local lspconfig = require("lspconfig")

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("my.lsp", {}),
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = true, desc = desc })
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
                        vim.api.nvim_command("LspClangdSwitchSourceHeader")
                    end, "Go to source/header")

                    map("n", "<leader>av", function()
                        vim.cmd("vsplit")
                        vim.api.nvim_command("LspClangdSwitchSourceHeader")
                    end, "Go to source/header in vertical split")

                    map("n", "<leader>ax", function()
                        vim.cmd("split")
                        vim.api.nvim_command("LspClangdSwitchSourceHeader")
                    end, "Go to source/header in horizontal split")
                end

                map("n", "<leader>tih", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end, "Toggle inlay hints")
            end,
        })

        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        --TODO move that in ~/.config/nvim/lsp/ , probably cleaner
        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy",
                    },
                },
            },
        })

        vim.lsp.config("neocmake", {
            init_options = {
                format = {
                    enable = false,
                },
                lint = {
                    enable = false,
                },
            },
        })

        vim.lsp.config("pylsp", {
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

        vim.lsp.config("lua_ls", {
            root_markers = {
                ".luarc.json",
                ".luarc.jsonc",
                ".luacheckrc",
                ".stylua.toml",
                "stylua.toml",
                "selene.toml",
                "selene.yml",
                ".git",
                "init.lua",
            },
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = "ApplyInMemory",
                        userThirdParty = { "/home/valentin/ws/luals_addons" },
                    },
                    runtime = {
                        version = "LuaJIT",
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                    hint = {
                        enable = true,
                    },
                },
            },
        })

        vim.lsp.config("clangd", {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
            },
        })
    end,
}
