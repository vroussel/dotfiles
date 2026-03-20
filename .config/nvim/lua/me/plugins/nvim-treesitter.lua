---@diagnostic disable: missing-fields
return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "python" },
            },
            -- indent = { enable = true },
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
                "vue",
                "javascript",
                "regex",
                "just",
                "query",
                "sql",
            },
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            -- incremental_selection = {
            -- 	enable = true,
            -- 	keymaps = {
            -- 		init_selection = false,
            -- 		node_incremental = "<cr>",
            -- 		scope_incremental = false,
            -- 		node_decremental = "<bs>",
            -- 	},
            -- },
        })

        vim.keymap.set("n", "<leader>ttc", function()
            vim.api.nvim_command("TSContextToggle")
        end, { desc = "Toggle Treesitter context" })
    end,
}
