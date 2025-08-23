return {
  'xiyaowong/nvim-transparent',
  opts = {

    vim.keymap.set('n', '<leader>te', vim.cmd.TransparentToggle, { noremap = true, silent = true }),
  },
}
