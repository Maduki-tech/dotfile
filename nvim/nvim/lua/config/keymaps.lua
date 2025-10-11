-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "Q", vim.cmd.x, { desc = "Save and quit" })
vim.keymap.set("n", "<C-b>", "<CMD>Oil<cr>", { desc = "Open Oil" })
