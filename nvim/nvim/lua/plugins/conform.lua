return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>tf",
      function()
        require("conform").format()
      end,
      desc = "Format file",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      markdown = { "markdownfmt" },
      java = { "clang_format" },
    },
  },
}
