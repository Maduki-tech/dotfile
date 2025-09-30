return {
  'danymat/neogen',
  config = function()
    require('neogen').setup {}
    vim.api.nvim_set_keymap('n', '<Leader>ng', ":lua require('neogen').generate()<CR>", { noremap = true, silent = true })
  end,
}
