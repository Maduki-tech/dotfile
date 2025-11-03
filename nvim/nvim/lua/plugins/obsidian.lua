return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      note_id_func = function(title)
        return title
      end,
      templates = {
        folder = "~/Obsidian Vault/06_Templates",
      },
      workspaces = {
        {
          name = "personal",
          path = "~/Obsidian Vault/",
        },
      },
    },
  },
}
