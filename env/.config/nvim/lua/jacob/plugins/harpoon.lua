return {
	"theprimeagen/harpoon",
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: add file" })
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon: open menu" })

		-- Set <space>1..<space>5 be my shortcuts to moving to the files
		for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
			vim.keymap.set("n", string.format("<space>%d", idx), function()
				ui.nav_file(idx)
			end, { desc = string.format("Harpoon Nav %d", idx) })
		end
	end,
}
