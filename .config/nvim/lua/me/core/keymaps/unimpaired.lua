-- quickfix
vim.keymap.set("n", "[q", function()
	vim.cmd("cprev")
end)

vim.keymap.set("n", "[Q", function()
	vim.cmd("cfirst")
end)

vim.keymap.set("n", "]q", function()
	vim.cmd("cnext")
end)

vim.keymap.set("n", "]Q", function()
	vim.cmd("clast")
end)

-- buffers
vim.keymap.set("n", "[b", function()
	vim.cmd("bprev")
end)

vim.keymap.set("n", "[B", function()
	vim.cmd("bfirst")
end)

vim.keymap.set("n", "]b", function()
	vim.cmd("bnext")
end)

vim.keymap.set("n", "]B", function()
	vim.cmd("blast")
end)

-- arguments
vim.keymap.set("n", "[a", function()
	vim.cmd("prev")
end)

vim.keymap.set("n", "[A", function()
	vim.cmd("first")
end)

vim.keymap.set("n", "]a", function()
	vim.cmd("next")
end)

vim.keymap.set("n", "]A", function()
	vim.cmd("last")
end)

-- location list
vim.keymap.set("n", "[l", function()
	vim.cmd("lprev")
end)

vim.keymap.set("n", "[L", function()
	vim.cmd("lfirst")
end)

vim.keymap.set("n", "]l", function()
	vim.cmd("lnext")
end)

vim.keymap.set("n", "]L", function()
	vim.cmd("llast")
end)
