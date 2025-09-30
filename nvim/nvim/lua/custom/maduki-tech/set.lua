vim.g.have_nerd_font = true
local opt = vim.o

opt.number = true
opt.relativenumber = true

opt.mouse = 'a'
opt.wrap = false
opt.showmode = false

vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

opt.breakindent = true

opt.undofile = true
opt.swapfile = false

opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = 'yes'
opt.colorcolumn = '80'

opt.updatetime = 250

opt.timeoutlen = 300

opt.splitright = true
opt.splitbelow = true

opt.list = true
opt.softtabstop = 4
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true

opt.inccommand = 'split'

opt.cursorline = true

opt.laststatus = 3

opt.scrolloff = 10
opt.confirm = false
