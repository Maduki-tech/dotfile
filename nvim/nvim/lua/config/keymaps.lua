-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.vscode then
  -- Load after LazyDone so vscode-neovim has restored runtimepath
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimKeymaps",
    once = true,
    callback = function()
      local ok, err = pcall(require, "config.vscode")
      if not ok then
        vim.notify("config.vscode failed: " .. tostring(err), vim.log.levels.ERROR)
      end
    end,
  })
  return
end

vim.keymap.set("n", "Q", vim.cmd.x, { desc = "Save and quit" })
vim.keymap.set("n", "<C-b>", "<CMD>Oil<cr>", { desc = "Open Oil" })

-- Rmove default LazyVim keymap for <leader>gg
-- vim.keymap.del("n", "<leader>gg")
