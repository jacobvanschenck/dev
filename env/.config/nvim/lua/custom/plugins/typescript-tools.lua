return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		local typescript_tools = require("typescript-tools")

		typescript_tools.setup({})

		vim.keymap.set(
			"n",
			"<leader>oi",
			"<cmd>TSToolsOrganizeImports<cr>",
			{ desc = "Sorts and removes unused imports" }
		)
		vim.keymap.set(
			"n",
			"<leader>rf",
			"<cmd>TSToolsRenameFile<cr>",
			{ desc = "Renames file and apply changes to connected file" }
		)
	end,
}
