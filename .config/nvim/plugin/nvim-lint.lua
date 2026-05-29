vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lint = require("lint")

lint.linters_by_ft = {
    sh = { "shellcheck" },
    ["yaml.ansible"] = { "ansible_lint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    pattern = "*",
    group = lint_augroup,
    callback = function()
        lint.try_lint()
    end,
})
