return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			require("mason-lspconfig").setup()

			require("mason-tool-installer").setup({
				ensure_installed = {
					"astro",
					"biome",
					"cssls",
					"html",
					"lua_ls",
					"gopls",
					"rust_analyzer",
					"rustywind", -- Tailwind class sorter
					"stylua", -- lua formatter
					"tailwindcss",
					"ts_ls",
					"tsgo",
				},
			})
		end,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},
}
