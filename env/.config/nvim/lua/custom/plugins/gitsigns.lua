return {
	"lewis6991/gitsigns.nvim",
	event = "BufAdd",
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Actions
				map("n", "<leader>gs", gs.stage_hunk, { desc = "[G]itsign [S]tage hunk" })
				map("n", "<leader>gr", gs.reset_hunk, { desc = "[G]itsign [R]eset hunk" })
				map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "[G]itsign [U]nstage hunk" })
				map("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[G]itsign [S]tage hunk" })
				map("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[G]itsign [R]eset hunk" })
				map("n", "<leader>gS", gs.stage_buffer, { desc = "[G]itsign [S]tage buffer" })
				map("n", "<leader>gR", gs.reset_buffer, { desc = "[G]itsign [R]eset buffer" })
				map("n", "<leader>gp", gs.preview_hunk, { desc = "[G]itsign [P]review hunk" })
				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, { desc = "[G]itsign [B]lame line" })
				map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "[T]oggle [B]lame line" })
				map("n", "<leader>gd", gs.diffthis, { desc = "[G]itsign [D]iff this" })
				map("n", "<leader>gD", function()
					gs.diffthis("~")
				end, { desc = "[G]itsign [D]iff this" })
			end,
		})
	end,
}
