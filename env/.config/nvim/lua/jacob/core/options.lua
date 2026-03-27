local opt = vim.opt

--line numbers
opt.relativenumber = true
opt.number = true

opt.inccommand = "split"

-- tabs  & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.cursorline = true

-- line wrapping
-- opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- considers hello-hello one word
opt.iskeyword:append("-")
