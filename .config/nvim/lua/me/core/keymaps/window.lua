local function is_rightmost(win)
    win = win or vim.api.nvim_get_current_win()
    local cur_pos = vim.api.nvim_win_get_position(win)
    local cur_col = cur_pos[2]
    local cur_width = vim.api.nvim_win_get_width(win)

    local max_right = 0
    for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local pos = vim.api.nvim_win_get_position(w)
        local right = pos[2] + vim.api.nvim_win_get_width(w)
        if right > max_right then
            max_right = right
        end
    end

    return (cur_col + cur_width) >= max_right
end

local function is_bottom(win)
    win = win or vim.api.nvim_get_current_win()
    local cur_pos = vim.api.nvim_win_get_position(win)
    local cur_row = cur_pos[1]
    local cur_height = vim.api.nvim_win_get_height(win)

    local max_bottom = 0
    for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        vim.print(w)
        local pos = vim.api.nvim_win_get_position(w)
        local bottom = pos[1] + vim.api.nvim_win_get_height(w)
        if bottom > max_bottom then
            max_bottom = bottom
        end
    end

    return (cur_row + cur_height) >= max_bottom
end

local function with_sign(n)
    return string.format("%+d", n)
end

local function smart_resize(dir, shift)
    if #vim.api.nvim_tabpage_list_wins(0) == 1 then
        return
    end

    local cmd

    if dir == "h" or dir == "l" then
        cmd = "vertical resize"
        if is_rightmost() then
            shift = shift * -1
        end
    elseif dir == "j" or dir == "k" then
        cmd = "horizontal resize"
        if is_bottom() then
            shift = shift * -1
        end
    end

    if dir == "h" or dir == "j" then
        shift = shift * -1
    end

    vim.cmd(cmd .. with_sign(shift))
end

-- Fast
vim.keymap.set("n", "<down>", function()
    smart_resize("k", 4)
end)
vim.keymap.set("n", "<up>", function()
    smart_resize("j", 4)
end)
vim.keymap.set("n", "<left>", function()
    smart_resize("h", 20)
end)
vim.keymap.set("n", "<right>", function()
    smart_resize("l", 20)
end)

-- Precise
vim.keymap.set("n", "<c-down>", function()
    smart_resize("k", 1)
end)
vim.keymap.set("n", "<c-up>", function()
    smart_resize("j", 1)
end)
vim.keymap.set("n", "<c-left>", function()
    smart_resize("h", 5)
end)
vim.keymap.set("n", "<c-right>", function()
    smart_resize("l", 5)
end)
