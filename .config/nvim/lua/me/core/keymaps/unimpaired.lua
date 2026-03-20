-- quickfix
vim.keymap.set("n", "[q", function()
    pcall(vim.cmd["cprev"])
end)

vim.keymap.set("n", "[Q", function()
    pcall(vim.cmd["cfirst"])
end)

vim.keymap.set("n", "]q", function()
    pcall(vim.cmd["cnext"])
end)

vim.keymap.set("n", "]Q", function()
    pcall(vim.cmd["clast"])
end)

-- buffers
vim.keymap.set("n", "[b", function()
    pcall(vim.cmd["bprev"])
end)

vim.keymap.set("n", "[B", function()
    pcall(vim.cmd["bfirst"])
end)

vim.keymap.set("n", "]b", function()
    pcall(vim.cmd["bnext"])
end)

vim.keymap.set("n", "]B", function()
    pcall(vim.cmd["blast"])
end)

-- arguments
vim.keymap.set("n", "[a", function()
    pcall(vim.cmd["prev"])
end)

vim.keymap.set("n", "[A", function()
    pcall(vim.cmd["first"])
end)

vim.keymap.set("n", "]a", function()
    pcall(vim.cmd["next"])
end)

vim.keymap.set("n", "]A", function()
    pcall(vim.cmd["last"])
end)

-- location list
vim.keymap.set("n", "[l", function()
    pcall(vim.cmd["lprev"])
end)

vim.keymap.set("n", "[L", function()
    pcall(vim.cmd["lfirst"])
end)

vim.keymap.set("n", "]l", function()
    pcall(vim.cmd["lnext"])
end)

vim.keymap.set("n", "]L", function()
    pcall(vim.cmd["llast"])
end)
