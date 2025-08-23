return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>tf',
      function()
        require('conform').format { async = true, lsp_fallback = false }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  log_level = vim.log.levels.DEBUG,
}
