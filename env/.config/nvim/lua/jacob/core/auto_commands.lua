-- Highlight when copying text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("help_vertical", {}),
	pattern = "help",
	command = "wincmd L",
})

-- No auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Match Neovim theme to system theme
local function sync_system_theme()
	-- Execute the macOS command to check for Dark mode
	-- We redirect stderr to /dev/null because the command fails in Light mode
	local handle = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
	local mode = string.gsub(handle, "%s+", "")

	if mode == "Dark" then
		vim.o.background = "dark"
	else
		vim.o.background = "light"
	end
end

-- Create the autocommand
vim.api.nvim_create_autocmd({ "FocusGained", "VimResume", "WinEnter" }, {
	group = vim.api.nvim_create_augroup("SystemThemeSync", { clear = true }),
	callback = function()
		sync_system_theme()
	end,
})

-- Run once on startup
sync_system_theme()
