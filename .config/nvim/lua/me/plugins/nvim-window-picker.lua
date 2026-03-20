return {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
        local window_picker = require("window-picker")

        window_picker.setup({
            hint = "floating-big-letter",
            filter_rules = {
                autoselect_one = true,
                include_current_win = true,
                bo = {
                    -- if the file type is one of following, the window will be ignored
                    filetype = { "NvimTree", "neo-tree", "notify", "aerial", "TelescopePrompt", "fidget" },
                    buftype = { "prompt" },
                },
            },
        })

        ---@param mode "vsplit"|"split"|nil
        local function open_qf_item(mode)
            local qf_id = vim.fn.win_getid()
            local picked_id = window_picker.pick_window({ filter_rules = { include_current_win = false } })
            if picked_id then
                vim.fn.win_gotoid(picked_id)
                if mode then
                    vim.cmd(mode)
                end
                vim.fn.win_gotoid(qf_id)
                local cr = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
                vim.api.nvim_feedkeys(cr, "n", false)
            end
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "qf",
            callback = function()
                vim.keymap.set("n", "<c-v>", function()
                    open_qf_item("vsplit")
                end)
                vim.keymap.set("n", "<c-x>", function()
                    open_qf_item("split")
                end)
                vim.keymap.set("n", "<cr>", function()
                    open_qf_item(nil)
                end)
            end,
        })
    end,
}
