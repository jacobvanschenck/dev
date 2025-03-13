return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
		-- "windwp/nvim-ts-autotag",
		config = function()
			-- import nvim-autopairs safely
			local autopairs_setup, autopairs = pcall(require, "nvim-autopairs")
			if not autopairs_setup then
				return
			end

			-- configure autopairs
			autopairs.setup({
				check_ts = true, -- enable treesitter
				ts_config = {
					lua = { "string" }, -- don't add pairs in lua string treesitter nodes
					javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
					java = false, -- don't check treesitter on java
				},
			})

			-- import nvim-autopairs completion functionality safely
			local cmp_autopairs_setup, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
			if not cmp_autopairs_setup then
				return
			end

			-- import nvim-cmp plugin safely (completions plugin)
			local cmp_setup, cmp = pcall(require, "cmp")
			if not cmp_setup then
				return
			end

			-- make autopairs and completion work together
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			local autotag_setup, autotag = pcall(require, "nvim-ts-autotag")
			if not autotag_setup then
				return
			end

			autotag.setup()
		end,
	},
}
