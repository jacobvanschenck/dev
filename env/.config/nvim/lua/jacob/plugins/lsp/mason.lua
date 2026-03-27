return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"biome",
				"astro",
				"html",
				"cssls",
				"tailwindcss",
				"graphql",
				"gopls",
				"ts_ls",
				"eslint",
				"lua_ls",
				"rust_analyzer",
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",

				opts = {

					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"stylua", -- lua formatter
				"rustywind", -- Tailwind class sorter
				"gopls",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
