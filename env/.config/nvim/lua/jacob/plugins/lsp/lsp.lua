return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Disable this server
		-- vim.lsp.enable("tsgo", false)
		vim.lsp.enable("ts_ls", false)

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(args)
				local opts = { buffer = args.buf, silent = true }

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show LSP definition"
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

				opts.desc = "Show documentation for what is under the cursor"
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover({ border = "rounded" })
				end, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<cmd>", opts)
			end,
		})

		local severity = vim.diagnostic.severity

		vim.diagnostic.config({
			signs = {
				text = {
					[severity.ERROR] = "",
					[severity.WARN] = "",
					[severity.HINT] = "",
					[severity.INFO] = "",
				},
			},
			virtual_text = false,
			float = {
				border = "rounded",
				focusable = true,
			},
			jump = {
				float = true,
			},
			update_in_insert = false, -- Recommended: Don't update diagnostics in insert mode
		})
	end,
}
