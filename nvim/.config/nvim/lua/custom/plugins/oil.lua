return {
  'stevearc/oil.nvim',
  -- dir = '/Users/davidschluter/nvim-package/oil.nvim',
  requires = { 'lewis6991/gitsigns.nvim' },
  config = function()
    local oil = require 'oil'
    oil.setup {
      columns = {
        'icon',
      },

      win_options = {
        signcolumn = 'yes:2',
      },
    }

    -- Keybinding to open Oil
    vim.keymap.set('n', '<C-b>', oil.open, { desc = 'Open Parent Directory' })
  end,
}
