require("config.remote_clipboard").setup()
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.o

opt.swapfile = false
-- Disable ai_cmp plugin
vim.g.ai_cmp = false

opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.shiftwidth = 4
opt.tabstop = 4

-- Herdr currently loses German AltGr text while relaying Kitty-protocol input.
-- Keep CSI-u enabled in normal terminals, but use legacy text input in Herdr.
if vim.env.HERDR_ENV == "1" or vim.env.HERDR_PANE_ID ~= nil then
  vim.api.nvim_create_autocmd({ "VimEnter", "VimLeavePre" }, {
    callback = function(args)
      io.stdout:write("\027[<1u")
      io.stdout:flush()
    end,
  })
end
