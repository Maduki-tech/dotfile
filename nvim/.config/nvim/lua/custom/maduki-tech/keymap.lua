vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>d', vim.cmd.vsplit, { desc = 'Split the windwo' })
vim.keymap.set('n', '<leader>s', vim.cmd.split, { desc = 'Split the windwo' })
vim.keymap.set('n', 'Q', vim.cmd.x, { desc = 'Quit and save' })

vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover { border = 'rounded' }
end, { desc = 'Hover Documentation' })

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>')
