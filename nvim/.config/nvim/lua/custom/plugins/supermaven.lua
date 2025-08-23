return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<S-Tab>',
      },
    }

    local supermaven = require 'supermaven-nvim.api'
    -- Toggle SuperMaven
    vim.keymap.set('n', '<leader>st', function()
      supermaven.toggle()

      if supermaven.is_running() then
        vim.print 'SuperMaven Started'
      else
        vim.print 'SuperMaven Stopped'
      end
    end, { desc = '[S]upermaven [T]oggle' })
  end,
}
