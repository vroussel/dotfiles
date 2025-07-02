vim.keymap.set("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

require("me.core.keymaps.diagnostics")
require("me.core.keymaps.dotfiles")
require("me.core.keymaps.unimpaired")
require("me.core.keymaps.window")
require("me.core.keymaps.lsp")

vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "<leader><leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
vim.keymap.set("n", "<leader><leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })
vim.keymap.set("n", "<bs>", "<c-^>")

-- Insert lines before/after current without leaving normal mode
vim.keymap.set("n", "]<leader>", function()
    return "m`" .. vim.v.count .. "o<Esc>``"
end, { expr = true })

vim.keymap.set("n", "[<leader>", function()
    return "m`" .. vim.v.count .. "O<Esc>``"
end, { expr = true })

-- Paste last yanked item
vim.keymap.set({ "n", "v" }, "<Leader>p", [["0p]])
vim.keymap.set({ "n", "v" }, "<Leader>P", [["0P]])

-- Paste/yank with system clipboard
vim.keymap.set({ "n", "v" }, "<Leader><leader>p", [["+p]])
vim.keymap.set({ "n", "v" }, "<Leader><leader>P", [["+P]])
vim.keymap.set({ "n", "v" }, "<Leader><leader>y", [["+y]])

-- xml formatting
vim.keymap.set("n", "<leader>xml", ":.!xmlstarlet fo<CR>")
vim.keymap.set("x", "<leader>xml", ":!xmlstarlet fo<CR>")

-- json formatting
vim.keymap.set("n", "<leader>jq", ":.!jq .<CR>")
vim.keymap.set("x", "<leader>jq", ":!jq .<CR>")

-- open/close tabs
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>")

-- Opposite of J, split line
vim.keymap.set("n", "S", [[i<CR><ESC>k:sil! keepp s/\v +$//<CR>:set hls<CR>j^]])

-- Toggle quickfix list
vim.keymap.set("n", "<c-q>", function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end)
