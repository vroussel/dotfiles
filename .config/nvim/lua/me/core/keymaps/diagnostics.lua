-- This could be in lspconfig.lua
-- BUT those are usefull with linters outside LSP as well

local opts = { noremap = true, silent = true }
opts.desc = "Show workspace diagnostics"
vim.keymap.set("n", "<leader><leader>D", "<cmd>Telescope diagnostics<CR>", opts)

opts.desc = "Show buffer diagnostics"
vim.keymap.set("n", "<leader><leader>d", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

opts.desc = "Show line diagnostics"
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

opts.desc = "Go to previous diagnostic"
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

opts.desc = "Go to next diagnostic"
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

opts.desc = "Go to previous error"
vim.keymap.set("n", "[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)

opts.desc = "Go to next error"
vim.keymap.set("n", "]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)

-- Toggle diagnostic appearance

local virtual_text = false
local virtual_lines = false
local underline = true
local signs = true
local only_errors = false

local diag_option_value = function(state)
	if not state then
		return false
	elseif only_errors then
		return { severity = vim.diagnostic.severity.ERROR }
	else
		return true
	end
end

local update_diag_conf = function()
	vim.diagnostic.config({
		virtual_text = diag_option_value(virtual_text),
		signs = diag_option_value(signs),
		underline = diag_option_value(underline),
		virtual_lines = virtual_lines,
	})
end

-- toggle diag virtual
vim.keymap.set("n", "<leader>tdv", function()
	if not virtual_text and not virtual_lines then
		virtual_text = true
		virtual_lines = false
	elseif virtual_text then
		virtual_text = false
		virtual_lines = true
	elseif virtual_lines then
		virtual_text = false
		virtual_lines = false
	end

	update_diag_conf()
end, { desc = "Toggle virtual text" })

-- toggle diag underline
vim.keymap.set("n", "<leader>tdu", function()
	underline = not underline
	update_diag_conf()
end, { desc = "Toggle underline" })

-- toggle diag signs
vim.keymap.set("n", "<leader>tds", function()
	signs = not signs
	update_diag_conf()
end, { desc = "Toggle signs" })

-- toggle diag level
vim.keymap.set("n", "<leader>tdl", function()
	only_errors = not only_errors
	update_diag_conf()
end, { desc = "Toggle diagnostics severity (all/error)" })

-- toggle diags
vim.keymap.set("n", "<leader>tD", function()
	if vim.diagnostic.is_disabled() then
		vim.diagnostic.enable()
	else
		vim.diagnostic.disable()
	end
end, { desc = "Toggle diagnostics" })

update_diag_conf()
