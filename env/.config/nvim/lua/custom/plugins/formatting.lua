return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local util = require("conform.util")

		conform.setup({
			log_level = vim.log.levels.DEBUG,
			formatters_by_ft = {
				-- javascript = { "biome" },
				-- typescript = { "biome" },
				-- javascriptreact = { "biome", "rustywind" },
				-- typescriptreact = { "biome", "rustywind" },
				-- json = { "biome" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd", "rustywind" },
				typescriptreact = { "prettierd", "rustywind" },
				json = { "prettierd" },
				astro = { "prettierd", "rustywind" },
				css = { "prettierd", "rustywind" },
				html = { "prettierd", "rustywind" },
				yaml = { "yamlfix" },
				markdown = { "prettierd" },
				solidity = { "prettierd" },
				graphql = { "prettierd" },
				lua = { "stylua" },
				elm = { "elm-format" },
				go = { "gofumpt", "goimports-reviser", "golines" },
				sql = { "sql_formatter" },
			},
			format_on_save = function()
				if vim.g.disable_autoformat then
					return
				end
				return {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				}
			end,
		})

		vim.api.nvim_create_user_command("FormatDisable", function()
			vim.g.disable_autoformat = true
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})

		conform.formatters.prettierd = {
			require_cwd = true,
			cwd = util.root_file({ "prettier.config.cjs", ".prettierrc", ".prettierrc.json" }),
		}

		vim.keymap.set({ "n", "v" }, "<leader>ff", function()
			conform.format({
				lsp_fallback = true,
				async = true,
				timeout_ms = 1000,
				formatters = { "prettier" },
			})
			print("success")
		end, { desc = "[F]ormat [F]ile or range (in visual mode)" })
	end,
}
