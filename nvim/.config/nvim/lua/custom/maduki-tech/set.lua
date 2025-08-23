-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
--
-- Disable comment continuation
vim.opt.formatoptions:remove { 'r', 'c', 'o' }
vim.cmd [[autocmd BufEnter * set formatoptions-=cro]]

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
vim.o.wrap = false

vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.hlsearch = true

-- init.lua
vim.o.laststatus = 3

vim.api.nvim_create_user_command('TWHSL', function()
  vim.cmd [[:%s/\(\d\+\(\.\d\+\)\?\)\s\+\(\d\+\(\.\d\+\)\?%\)\s\+\(\d\+\(\.\d\+\)\?%\)/hsl(\1, \3, \5)/g ]]
end, {})
