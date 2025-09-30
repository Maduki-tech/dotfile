return {
  'ellisonleao/carbon-now.nvim',
  lazy = true,
  cmd = 'CarbonNow',
  opts = {},
  config = function()
    local carbon = require 'carbon-now'
    carbon.setup {
      base_url = 'https://carbon.now.sh/',
      options = {
        bg = 'gray',
        drop_shadow_blur = '68px',
        drop_shadow = true,
        drop_shadow_offset_y = '20px',
        font_family = 'Hack',
        font_size = '18px',
        line_height = '100%',
        line_numbers = true,
        theme = 'one-dark',
        titlebar = 'Synticode',
        watermark = false,
        width = '680',
        window_theme = 'bw',
        padding_horizontal = '0px',
        padding_vertical = '0px',
      },
    }
  end,
}
