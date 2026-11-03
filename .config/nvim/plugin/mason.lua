vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
})

local mason = require("mason")
local mason_registry = require("mason-registry")
mason.setup({})

local wanted = {
    -- LSP
    "rust-analyzer",
    "lua-language-server",
    "neocmakelsp",
    "rumdl",

    -- Formatters
    "stylua",
    "yamlfix",
    "gersemi",
    "clang-format",

    -- Linters
    "shellcheck",
    "ansible-lint",
}

local installed = {}
for _, pkg in ipairs(mason_registry.get_installed_package_names()) do
    installed[pkg] = true
end

for _, pkg in ipairs(wanted) do
    if not installed[pkg] then
        vim.cmd("MasonInstall " .. pkg)
    end
end

vim.keymap.set("n", "<leader><leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })
