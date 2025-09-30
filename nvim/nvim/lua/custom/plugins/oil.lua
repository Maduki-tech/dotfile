return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    vim.keymap.set('n', '<C-b>', '<CMD>Oil<CR>', { desc = 'Open Parent Directory' }),
    win_options = {
      signcolumn = 'yes:2',
    },
  },
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  lazy = false,
}
