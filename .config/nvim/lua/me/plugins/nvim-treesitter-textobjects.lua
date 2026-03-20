---@diagnostic disable: missing-fields
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	lazy = true,
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						{ desc = "Select around function" },
						["if"] = "@function.inner",
						{ desc = "Select inside function" },
						["ac"] = "@class.outer",
						{ desc = "Select around class" },
						["ic"] = { query = "@class.inner", desc = "Select inside class" },
						["aa"] = "@parameter.outer",
						{ desc = "Select around argument" },
						["ia"] = "@parameter.inner",
						{ desc = "Select inside argument" },
					},
					-- You can choose the select mode (default is charwise 'v')
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * method: eg 'v' or 'o'
					-- and should return the mode ('v', 'V', or '<c-v>') or a table
					-- mapping query_strings to modes.
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					-- If you set this to `true` (default is `false`) then any textobject is
					-- extended to include preceding or succeeding whitespace. Succeeding
					-- whitespace has priority in order to act similarly to eg the built-in
					-- `ap`.
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * selection_mode: eg 'v'
					-- and should return true of false
					include_surrounding_whitespace = true,
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]f"] = "@function.outer",
						{ desc = "Next function start" },

						["]c"] = { query = "@class.outer", desc = "Next class start" },

						["]a"] = "@parameter.inner",
						{ desc = "Next param start" },
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						{ desc = "Next function end" },

						["]C"] = "@class.outer",
						{ desc = "Next class end" },
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						{ desc = "Previous function start" },

						["[c"] = "@class.outer",
						{ desc = "Previous class start" },

						["[a"] = "@parameter.inner",
						{ desc = "Previous param start" },
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						{ desc = "Previous function end" },

						["[C"] = "@class.outer",
						{ desc = "Previous class end" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>]a"] = "@parameter.inner",
						{ desc = "Swap param with next" },

						["<leader>]f"] = "@function.outer",
						{ desc = "Swap function with next" },

						["<leader>]c"] = "@class.outer",
						{ desc = "Swap class with next" },
					},
					swap_previous = {
						["<leader>[a"] = "@parameter.inner",
						{ desc = "Swap param with previous" },

						["<leader>[f"] = "@function.outer",
						{ desc = "Swap function with previous" },

						["<leader>[c"] = "@class.outer",
						{ desc = "Swap class with previous" },
					},
				},
			},
		})

		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		-- Repeat movement with ; and ,
		-- vim way: ; goes to the direction you were moving.
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

		-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
	end,
}
