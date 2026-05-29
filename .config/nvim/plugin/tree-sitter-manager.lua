vim.pack.add({ "https://github.com/romus204/tree-sitter-manager.nvim" })

require("tree-sitter-manager").setup({
    ensure_installed = {
        "json",
        "yaml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "c",
        "cpp",
        "python",
        "rust",
        "vimdoc",
        "regex",
        "just",
        "sql",
    },
})
