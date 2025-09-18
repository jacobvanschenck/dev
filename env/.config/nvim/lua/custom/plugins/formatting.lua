return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			log_level = vim.log.levels.DEBUG,
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier", "rustywind" },
				typescriptreact = { "prettier", "rustywind" },
				json = { "prettier" },
				astro = { "prettier", "rustywind" },
				css = { "prettier", "rustywind" },
				html = { "prettier", "rustywind" },
				yaml = { "yamlfix" },
				markdown = { "prettier" },
				solidity = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				elm = { "elm-format" },
				go = { "gofumpt", "goimports-reviser", "golines" },
				template = { "prettier", "rustywind" },
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
			local current_file = vim.fn.expand("%")
			local escaped_file = vim.fn.shellescape(current_file)

			vim.cmd("!eslint_d " .. escaped_file .. " --fix")
		end, { desc = "Run eslint_d on current file" })
	end,
}
