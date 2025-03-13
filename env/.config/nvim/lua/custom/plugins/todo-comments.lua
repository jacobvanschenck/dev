return {
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		config = function()
			local todo = require("todo-comments")

			todo.setup({})

			vim.keymap.set("n", "]t", function()
				todo.jump_next()
			end, { desc = "Next todo comment" })

			vim.keymap.set("n", "[t", function()
				todo.jump_prev()
			end, { desc = "Previous todo comment" })

			vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "[S]earc [T]odos" })
		end,
	},
}
