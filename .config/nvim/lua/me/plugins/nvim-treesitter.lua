---@diagnostic disable: missing-fields
return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "OXY2DEV/markview.nvim",
    },
    branch = "main",
    build = ":TSUpdate",
    config = function()
        vim.g._ts_force_sync_parsing = true
        local treesitter = require("nvim-treesitter")

        treesitter.setup({
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "python" },
            },
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        })

        local ensure_installed = {
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
            "vue",
            "javascript",
            "regex",
            "just",
            "query",
            "sql",
        }
        local alreadyInstalled = treesitter.get_installed()
        local parsersToInstall = vim.iter(ensure_installed)
            :filter(function(parser)
                return not vim.tbl_contains(alreadyInstalled, parser)
            end)
            :totable()
        treesitter.install(parsersToInstall)

        vim.keymap.set("n", "<leader>ttc", function()
            vim.api.nvim_command("TSContextToggle")
        end, { desc = "Toggle Treesitter context" })
    end,
}
