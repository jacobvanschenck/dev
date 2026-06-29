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

-- Enable treesitter
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
	pattern = {
		"astro",
		"bash",
		"elixir",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"lua",
		"markdown",
		"mdx",
		"odin",
		"python",
		"query",
		"regex",
		"solidity",
		"typescript",
		"typescriptreact",
		"terraform",
		"vim",
		"vimdoc",
		"yaml",
		"go",
	},
	callback = function()
		vim.treesitter.start()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- Run once on startup
sync_system_theme()

-- User command for reload script
vim.api.nvim_create_user_command("ReloadProject", function()
	local root = vim.fs.root(0, { ".git" })

	if not root then
		vim.notify("Could not find project root", vim.log.levels.ERROR)
		return
	end

	local reload_script = root .. "/reload"

	if vim.fn.executable(reload_script) == 0 then
		vim.notify("No executable reload script found", vim.log.levels.ERROR)
		return
	end

	vim.system({ reload_script }, { cwd = root }, function(result)
		vim.schedule(function()
			if result.code == 0 then
				vim.notify("Reload completed")
			else
				vim.notify(result.stderr, vim.log.levels.ERROR)
			end
		end)
	end)
end, {})
