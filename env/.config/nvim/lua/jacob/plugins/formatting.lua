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
			formatters = {
				biome = {
					-- "check" runs formatting AND unsafe fixes (like sorting imports)
					-- Use "check --apply" for safe fixes only, or "check --apply-unsafe" for everything
					args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
				},
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
	end,
}
