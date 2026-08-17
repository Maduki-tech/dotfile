return {
  -- Kill markdownlint inline noise (MD013 line-length etc.)
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          condition = function()
            return false
          end,
        },
      },
    },
  },

  -- Richer in-buffer markdown reading (LazyVim already ships this; we just style it)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      render_modes = { "n", "c", "t" },
      heading = {
        enabled = true,
        sign = false,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        width = "full",
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
        border = "thin",
      },
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
      checkbox = {
        enabled = true,
      },
      quote = {
        enabled = true,
        icon = "▋",
      },
      pipe_table = {
        enabled = true,
        style = "full",
      },
      link = {
        enabled = true,
      },
    },
  },
}
