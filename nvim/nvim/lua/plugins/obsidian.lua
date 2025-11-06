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
        folder = "~/vault/06_Templates",
      },
      daily_notes = {
        folder = "~/vault/01_Diary/Daily/",
        template = "~/vault/06_Templates/Daily.md",
      },
      workspaces = {
        {
          name = "personal",
          path = "~/vault/",
        },
      },
    },
  },
}
