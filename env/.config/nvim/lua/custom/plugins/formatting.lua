return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			log_level = vim.log.levels.DEBUG,
			formatters_by_ft = {
				javascript = { "biome", "rustywind" },
				typescript = { "biome", "rustywind" },
				javascriptreact = { "biome", "rustywind" },
				typescriptreact = { "biome", "rustywind" },
				json = { "biome" },
				astro = { "biome", "rustywind" },
				css = { "biome", "rustywind" },
				html = { "biome", "rustywind" },
				yaml = { "yamlfix" },
				markdown = { "biome" },
				solidity = { "biome" },
				graphql = { "biome" },
				lua = { "stylua" },
				elm = { "elm-format" },
				go = { "gofumpt", "goimports-reviser", "golines" },
				template = { "biome", "rustywind" },
				sql = { "sql_formatter" },
			},
			format_on_save = function()
				if vim.g.disable_autoformat then
					return
				end
				return {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				}
			end,
		})

		vim.keymap.set("n", "<leader>f", function()
			vim.cmd("BiomeFixAll")
		end, { desc = "Run biome on current file" })
	end,
}
