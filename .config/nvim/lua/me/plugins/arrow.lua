return {
    "otavioschwanck/arrow.nvim",
    opts = {
        show_icons = true,
        leader_key = "<leader>;", -- Recommended to be a single key
        mappings = {
            edit = "e",
            delete_mode = "d",
            clear_all_items = "C",
            toggle = "s", -- used as save if separate_save_and_remove is true
            open_vertical = "<c-v>",
            open_horizontal = "<c-x>",
            quit = "q",
            remove = "x", -- only used if separate_save_and_remove is true
            next_item = "]",
            prev_item = "[",
        },
    },
}
