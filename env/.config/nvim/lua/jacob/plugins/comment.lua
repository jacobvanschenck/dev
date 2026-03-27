-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring#getting-started
-- skip backwards compatibility routines and speed up loading
vim.g.skip_ts_context_commentstring_module = true

-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
return {
	"numToStr/Comment.nvim",
	opts = {
		-- add any options here
	},
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	lazy = false,
	config = function()
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
