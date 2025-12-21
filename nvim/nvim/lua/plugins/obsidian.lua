return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      note_id_func = function(title)
        return title
      end,
      templates = {
        folder = "06_Templates",
      },
      daily_notes = {
        folder = "01_Diary/Daily/",
        template = "06_Templates/Daily.md",
      },
      workspaces = {
        {
          name = "personal",
          path = "~/vault/",
        },
      },

      vim.keymap.set("n", "<leader>o", function() end),
      { desc = "Obsidian" },

      vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian<cr>", { desc = "Obsidian Menu" }),

      vim.keymap.set("n", "<leader>on", function()
        require("obsidian").new_note()
      end, { desc = "Obsidian: New Note" }),
    },
  },
}
