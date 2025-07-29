local keymap = vim.keymap

-- jj to exit
keymap.set("i", "<C-c>", "<Esc>")

-- clear search highlights
keymap.set("n", "<Esc>", ":nohl<CR>")
-- keymap.set("n", "<CR>", function()
-- 	if vim.opt.hlsearch:get() then
-- 		vim.cmd.nohl()
-- 		return ""
-- 	else
-- 		return "<CR>"
-- 	end
-- end)

-- Basic movement keybinds, these make navigating splits easy for me
keymap.set("n", "<c-j>", "<c-w><c-j>")
keymap.set("n", "<c-k>", "<c-w><c-k>")
keymap.set("n", "<c-l>", "<c-w><c-l>")
keymap.set("n", "<c-h>", "<c-w><c-h>")

keymap.set("n", "<leader>sv", "<c-w>v") -- split vertically
keymap.set("n", "<leader>sh", "<c-w>s") -- split vertically

-- move lines of text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Naviage up and down, but leave cursor centered
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- open lazy package manager
keymap.set("n", "<leader><leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })

-- open mason
keymap.set("n", "<leader><leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- delete single character without coping into register
keymap.set("n", "x", '"_x')

-- Window Management
keymap.set("n", "<leader>q", "<C-w>q") -- close window

keymap.set("n", "Q", "<nop>")

-- Source neovim config
keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })
keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Execute the current line" })
keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Execute the selected lines" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set("t", "jj", "<C-\\><C-n>", { desc = "Exit terminal mode" })

keymap.set("n", "<C-n>", "<cmd>cnext<cr>", { desc = "Next quickfix" })
keymap.set("n", "<C-p>", "<cmd>cprev<cr>", { desc = "Previous quickfix" })

keymap.set("n", "<C-f>", "<cmd>!tmux neww tmux-sessionizer<CR>", { desc = "Tmux sessionizer" })

keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer" })
