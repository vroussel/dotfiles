return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        local ansible_lint = lint.linters.ansible_lint
        ansible_lint.args = {
            "-p",
            "--nocolor",
        }

        lint.linters_by_ft = {
            sh = { "shellcheck" },
            python = { "mypy" },
            markdown = { "markdownlint" },
        }

        lint.linters["markdownlint"].args = { "--stdin", "--disable", "MD013" }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            pattern = "*",
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
