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

			local ok, features = pcall(require, "local_features")
			local default_features = {
				enable_biome_lsp = false,
			}
			local config = ok and features or default_features

			local lsp = require("lspconfig")
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
				jump = {
					float = true,
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

			local on_attach = function(_, bufnr)
				-- keybind options
				local opts = { noremap = true, silent = true, buffer = bufnr }

				-- set keybinds
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				keymap.set("n", "K", function()
					vim.lsp.buf.hover({ border = "rounded" })
				end, opts) -- show documentation for what is under cursor
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
			-- configure biome
			if config.enable_biome_lsp then
				print("Biome LSP is enabled")
				lsp["biome"].setup({
					handlers = handlers,
					capabilities = capabilities,
					-- Pass a new function that chains your existing on_attach logic
					-- with the new autocommand for Biome fixes.
					on_attach = function(client, bufnr)
						-- 1. Call your existing on_attach function
						if on_attach then
							on_attach(client, bufnr)
						end

						-- 2. Add the Autocommand for Biome Fix-on-Save
						if client.name == "biome" then
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr, -- Apply only to the current buffer
								desc = "Auto fix Biome diagnostics on save",
								callback = function()
									-- Execute the Biome 'source.fixAll.biome' code action
									vim.lsp.buf.code_action({
										context = {
											only = { "source.fixAll.biome" },
										},
										apply = true, -- Apply the fix immediately
										bufnr = bufnr,
									})
								end,
							})
						end
					end,
					root_dir = function(fname)
						return lsp.util.root_pattern("biome.json", "biome.jsonc")(fname)
							or lsp.util.find_package_json_ancestor(fname)
							or lsp.util.find_node_modules_ancestor(fname)
							or lsp.util.find_git_ancestor(fname)
					end,
				})
			else
				print("Biome LSP is disabled")
			end

			-- configure typescript server with plugin
			lsp.ts_ls.setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					diagnostics = { ignoredCodes = { 6133 } },
				},
			})

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
				filetypes = { "go", "gomod", "gowork", "template" },
				root_dir = lsp.util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						templateExtensions = { "tmpl" },
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
				root_dir = lsp.util.root_pattern(
					"tailwind.config.js",
					"tailwind.config.ts",
					"tailwind.config.cjs",
					"package.json",
					".git",
					"go.mod" -- Important for your Go project
				),
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
