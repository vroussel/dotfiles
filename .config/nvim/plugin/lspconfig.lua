vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = true, desc = desc })
        end

        local fzf = require("fzf-lua")
        map("n", "gr", fzf.lsp_references, "Show LSP references")
        map("n", "gd", fzf.lsp_declarations, "Go to declaration")
        map("n", "gD", fzf.lsp_definitions, "Go to declaration")
        map("n", "gi", fzf.lsp_implementations, "Show LSP implementations")
        map("n", "gt", fzf.lsp_typedefs, "Show LSP type definitions")
        map("n", "gs", fzf.lsp_document_symbols, "Show LSP document symbols")
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

vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
        },
    },
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
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
    cmd = { "clangd", "--background-index", "--clang-tidy" },
})

vim.lsp.config("pylsp", {
    settings = {
        pylsp = {
            plugins = {
                -- Disable eveything that can be handled by ruff
                autopep8 = { enabled = false },
                mccabe = { enabled = false },
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                yapf = { enabled = false },
            },
        },
    },
})

vim.lsp.config("ruff", {})

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

vim.lsp.config("html", {
    filetypes = { "html", "htmldjango" },
})

vim.lsp.config("tailwindcss", {})
