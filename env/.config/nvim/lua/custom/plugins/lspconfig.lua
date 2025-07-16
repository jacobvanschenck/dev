return {
	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		config = function()
			-- This is where all the LSP shenanigans will live

			local lsp = require("lspconfig")
			local configs = require("lspconfig.configs")
			local keymap = vim.keymap
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local signs = {
				Error = "",
				Warn = "",
				Hint = "",
				Info = "",
			}

			-- Add borders to diagnostic window
			vim.diagnostic.config({
				virtual_text = false,
				float = {
					border = "rounded",
					focusable = true,
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = signs.Error,
						[vim.diagnostic.severity.WARN] = signs.Warn,
						[vim.diagnostic.severity.HINT] = signs.Hint,
						[vim.diagnostic.severity.INFO] = signs.Info,
					},
				},
				update_in_insert = false, -- Recommended: Don't update diagnostics in insert mode
			})

			-- Add borders to hover and signature help
			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
			}

			local on_attach = function(client, bufnr)
				-- keybind options
				local opts = { noremap = true, silent = true, buffer = bufnr }

				-- if client.name == "tsserver" then
				-- 	local ns = vim.lsp.diagnostic.get_namespace(client.id)
				-- 	vim.diagnostic.disable(nil, ns)
				-- end

				-- set keybinds
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- got to declaration
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
			end

			local capabilities = cmp_nvim_lsp.default_capabilities()

			lsp.astro.setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "astro" },
			})

			-- configure html server
			lsp["html"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- configure biome
			-- lsp["biome"].setup({
			-- 	handlers = handlers,
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	root_dir = function(fname)
			-- 		return lsp.util.root_pattern("biome.json", "biome.jsonc")(fname)
			-- 			or lsp.util.find_package_json_ancestor(fname)
			-- 			or lsp.util.find_node_modules_ancestor(fname)
			-- 			or lsp.util.find_git_ancestor(fname)
			-- 	end,
			-- })

			-- configure typescript server with plugin
			lsp["ts_ls"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					diagnostics = { ignoredCodes = { 6133 } },
				},
			})

			-- configs.tsgo = {
			-- 	default_config = {
			-- 		cmd = { "tsgo", "--lsp", "-stdio" },
			-- 		filetypes = {
			-- 			"javascript",
			-- 			"javascriptreact",
			-- 			"javascript.jsx",
			-- 			"typescript",
			-- 			"typescriptreact",
			-- 			"typescript.tsx",
			-- 		},
			-- 		root_dir = lsp.util.root_pattern({ "tsconfig.json", "jsconfig.json", "package.json", ".git" }),
			-- 	},
			-- }
			--
			-- lsp.tsgo.setup({
			-- 	handlers = handlers,
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- })

			-- lsp["elixirls"].setup({
			-- 	handlers = handlers,
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	cmd = { "/Users/jacobvanschenck/.local/share/nvim/mason/bin/elixir-ls" },
			-- })

			lsp["rust_analyzer"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
				cmd = { "rustup", "run", "stable", "rust-analyzer" },
				checkOnSave = {
					allFeatures = true,
					command = "clippy",
					extraArgs = {
						"--",
						"--no-deps",
						"-Dclippy::correctness",
						"-Dclippy::complexity",
						"-Wclippy::perf",
						"-Wclippy::pedantic",
					},
				},
			})

			-- configure css server
			lsp["cssls"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					css = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
			})

			lsp["gopls"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = lsp.util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						completeUnimported = true,
						analyses = {
							unusedparams = true,
						},
						gofumpt = true,
					},
				},
			})

			lsp["marksman"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- configure css server
			lsp["jsonls"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- configure tailwindcss server
			lsp["tailwindcss"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lsp["elmls"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lsp["yamlls"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lsp["solidity_ls_nomicfoundation"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lsp["sqls"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lsp["bashls"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- lsp["eslint"].setup({
			-- 	handlers = handlers,
			-- 	capabilities = capabilities,
			-- 	on_attach = function(_, bufnr)
			-- 		vim.api.nvim_create_autocmd("BufWritePre", {
			-- 			buffer = bufnr,
			-- 			callback = function()
			-- 				vim.cmd("EslintFixAll")
			-- 			end,
			-- 		})
			-- 	end,
			-- })

			lsp["terraformls"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lsp["tflint"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- configure lua server (with special settings)
			lsp["lua_ls"].setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
				settings = { -- custom settings for lua
					Lua = {
						-- make the language server recognize "vim" global
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							runtime = { version = "LuaJIT" },
							checkThirdParty = false,
							-- make language server aware of runtime files
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
					},
				},
			})
		end,
	},
}
