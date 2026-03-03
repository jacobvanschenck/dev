-- Highlight when copying text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local function sync_system_theme()
	-- Execute the macOS command to check for Dark mode
	-- We redirect stderr to /dev/null because the command fails in Light mode
	local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
	local result = handle:read("*a"):gsub("%s+", "")
	handle:close()

	if result == "Dark" then
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
