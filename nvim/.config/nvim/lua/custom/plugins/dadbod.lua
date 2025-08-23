return {
  'tpope/vim-dadbod',
  { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'postgres' }, lazy = true },
  'kristijanhusak/vim-dadbod-ui',
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
