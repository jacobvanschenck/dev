return {
	{
		"hrsh7th/nvim-cmp", -- completion plugins
		dependencies = {
			"onsails/lspkind.nvim", -- vs-code like pictograms
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"hrsh7th/cmp-nvim-lsp",
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				dependencies = {
					"saadparwaiz1/cmp_luasnip", -- for autocompletion
					"rafamadriz/friendly-snippets",
				},
			}, -- snippet engine
		},
		config = function()
			-- import nvim-cmp plugin safely
			local cmp_status, cmp = pcall(require, "cmp")
			if not cmp_status then
				return
			end

			-- -- import luasnip plugin safely
			local luasnip = require("luasnip")

			-- import lspkind plugin safely
			local lspkind_status, lspkind = pcall(require, "lspkind")
			if not lspkind_status then
				return
			end

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
					["<C-e>"] = cmp.mapping.abort(), -- close completion window
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
				}),

				-- sources for autocompletion
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- lsp
					{ name = "luasnip" },
					{ name = "buffer" }, -- text within current buffer
					{ name = "path" }, -- file system paths
				}),
				-- configure lspkind for vs-code like icons
				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})

			-- Setup up vim-dadbod
			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
			})

			luasnip.config.set_config({
				history = false,
				updateevents = "TextChanged,TextChangedI",
			})

			luasnip.filetype_extend("javascript", { "typescriptreact" })
			luasnip.filetype_extend("typescript", { "typescriptreact" })

			vim.keymap.set({ "i", "s" }, "<c-k>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<c-j>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { silent = true })
		end,
	},
}
