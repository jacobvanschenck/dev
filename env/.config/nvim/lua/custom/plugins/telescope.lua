return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		version = false,
		keys = {
			{ "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP Definitions" },
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "LSP References" },
			{ "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "LSP Implementations" },
			{ "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "LSP Type Definitions" },
		},
		config = function()
			local telescope_setup, telescope = pcall(require, "telescope")
			if not telescope_setup then
				return
			end

			local actions_setup, actions = pcall(require, "telescope.actions")
			if not actions_setup then
				return
			end

			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
				defaults = {
					mappings = {
						i = {
							["<C-d>"] = actions.delete_buffer,
							["<C-y>"] = actions.select_default,
						},
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sy", builtin.lsp_document_symbols, { desc = "[S]earch s[Y]mbols" })
			vim.keymap.set("n", "<leader>si", builtin.git_files, { desc = "[S]earch Git [I]gnore" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch open [B]uffers" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader>s/", builtin.current_buffer_fuzzy_find, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>sc", function()
				builtin.find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end, { desc = "[S]each Nvim [C]onfig" })
		end,
	},
}
