-- CAPPUCCIN
-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("catppuccin").setup({
-- 			transparent_background = true, -- disables setting the background color.
-- 			custom_highlights = function(colors)
-- 				return {
-- 					-- FloatBorder = { fg = colors.lavender },
-- 					-- FloatBorder = { fg = colors.lavender },
-- 				}
-- 			end,
-- 		})
--
-- 		-- setup must be called before loading
-- 		vim.cmd.colorscheme("catppuccin")
-- 	end,
-- }

-- ROSE-PINE
return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			styles = {
				-- transparency = true,
			},
			groups = {
				border = "muted",
			},
			highlight_groups = {
				CursorLineNr = { fg = "gold", bg = "none" },
			},
		})

		vim.cmd.colorscheme("rose-pine")
	end,
}

-- TOKYONIGHT
-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 100,
-- 	opts = {},
-- 	config = function()
-- 		require("tokyonight").setup({
-- 			transparent = true,
-- 			on_highlights = function(hl, c)
-- 				hl.FloatBorder = {
-- 					bg = "none",
-- 					fg = c.border_highlight,
-- 				}
-- 				hl.FloatTitle = {
-- 					bg = "none",
-- 					bold = true,
-- 					fg = c.blue,
-- 				}
-- 				hl.NormalFloat = {
-- 					bg = "none",
-- 					fg = c.fg_float,
-- 				}
-- 				hl.TelescopeBorder = {
-- 					bg = "none",
-- 					fg = c.border_highlight,
-- 				}
-- 				hl.TelescopePromptBorder = {
-- 					bg = "none",
-- 					fg = c.border_highlight,
-- 				}
-- 				hl.TelescopePromptTitle = {
-- 					bg = "none",
-- 					bold = true,
-- 					fg = c.blue,
-- 				}
-- 				hl.TelescopeNormal = {
-- 					bg = "none",
-- 					fg = c.fg_float,
-- 				}
-- 				hl.TelescopeResultsTitle = {
-- 					bg = "none",
-- 					bold = true,
-- 					fg = c.blue,
-- 				}
-- 				hl.TelescopePreviewTitle = {
-- 					bg = "none",
-- 					bold = true,
-- 					fg = c.blue,
-- 				}
-- 				hl.LspInfoBorder = {
-- 					bg = "none",
-- 					fg = c.border_highlight,
-- 				}
-- 			end,
-- 		})
-- 		-- load the colorscheme here
-- 		vim.cmd([[colorscheme tokyonight]])
--
-- 		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
-- 		vim.lsp.handlers["textDocument/signatureHelp"] =
-- 			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
-- 		vim.diagnostic.config({
-- 			float = { border = "rounded" },
-- 		})
-- 		require("lspconfig.ui.windows").default_options = {
-- 			border = "rounded",
-- 		}
-- 	end,
-- }
