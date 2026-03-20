return {
    "chrisgrieser/nvim-scissors",
    dependencies = { "ibhagwan/fzf-lua" },
    opts = {
        snippetDir = vim.fn.stdpath("config") .. "/snippets",
        jsonFormatter = "jq",
    },
}
