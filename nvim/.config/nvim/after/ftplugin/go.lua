-- Run Go main
vim.keymap.set('n', '<leader>g', ':!go run %<CR>')
-- Run Go tests
vim.keymap.set('n', '<leader>dt', require('dap-go').debug_test)
vim.keymap.set('n', '<leader>t', ':!go test %<CR>')
