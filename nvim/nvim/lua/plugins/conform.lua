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
      java = { "clang_format_java" },
      cpp = { "clang_format_cpp" },
      c = { "clang_format_cpp" },
    },
    formatters = {
      clang_format_cpp = {
        command = "clang-format",
        args = {
          "--style={BasedOnStyle: Google, IndentWidth: 4, TabWidth: 4, UseTab: Never, ColumnLimit: 80, BinPackParameters: false, BinPackArguments: false, AlignAfterOpenBracket: AlwaysBreak, AllowShortFunctionsOnASingleLine: None, AllowShortIfStatementsOnASingleLine: Never, AllowShortLoopsOnASingleLine: false, AccessModifierOffset: -4, IndentCaseLabels: true, ContinuationIndentWidth: 8}",
          "--assume-filename",
          "$FILENAME",
        },
        stdin = true,
      },
      clang_format_java = {
        command = "clang-format",
        args = {
          "--style={BasedOnStyle: Google, IndentWidth: 4, TabWidth: 4, UseTab: Never, ColumnLimit: 80, BinPackParameters: false, BinPackArguments: false, AlignAfterOpenBracket: AlwaysBreak, AllowShortFunctionsOnASingleLine: None, AllowShortIfStatementsOnASingleLine: Never, AllowShortLoopsOnASingleLine: false, AccessModifierOffset: -4, IndentCaseLabels: true, ContinuationIndentWidth: 8}",
          "--assume-filename",
          "$FILENAME",
        },
        stdin = true,
      },
    },
  },
}
