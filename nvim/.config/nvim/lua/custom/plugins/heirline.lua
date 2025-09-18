return {
  {
    'rebelot/heirline.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' }, -- Optional
    config = function()
      vim.cmd [[
        highlight GitAdded guifg=#98be65 guibg=#1e222a
        highlight GitChanged guifg=#ECBE7B guibg=#1e222a
        highlight GitDeleted guifg=#ec5f67 guibg=#1e222a
      ]]
      vim.cmd 'highlight StatusLine guifg=#bbc2cf guibg=#1e222a'
      local conditions = require 'heirline.conditions'
      -- Define colors
      local colors = {
        bg = '#1e222a',
        fg = '#bbc2cf',
        red = '#ec5f67',
        green = '#98be65',
        blue = '#51afef',
        yellow = '#ECBE7B',
        orange = '#FF8800',
        magenta = '#c678dd',
        violet = '#a9a1e1',
        cyan = '#008080',
      }

      local LeftSeparator = {
        provider = '',
        hl = { fg = '#1e222a', bg = '#98be65' },
      }

      local RightSeparator = {
        provider = '',
        hl = { fg = '#1e222a', bg = '#98be65' },
      }

      -- Mode colors
      local mode_colors = {
        n = colors.green,
        i = colors.blue,
        v = colors.magenta,
        V = colors.magenta,
        c = colors.orange,
        s = colors.cyan,
        R = colors.red,
      }

      -- Mode provider
      local ViMode = {
        provider = function()
          local mode = vim.api.nvim_get_mode().mode
          return '  ' .. mode:upper() .. ' '
        end,
        hl = function()
          local mode = vim.api.nvim_get_mode().mode
          return { fg = colors.bg, bg = mode_colors[mode] or colors.red, bold = true }
        end,
        update = { 'ModeChanged' },
      }

      local FileInfo = {
        provider = function()
          -- Get the relative file path
          local filepath = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
          if filepath == '' then
            return ''
          end

          -- Get the file extension, name, and icon
          local file_ext = vim.fn.expand '%:e'
          local filename = vim.fn.expand '%:t'
          local icon, icon_color = require('nvim-web-devicons').get_icon_color(filename, file_ext, { default = true })

          -- Construct the file info string
          local icon_part = string.format('%%#FileIcon#%s%%*', icon or '') -- Use highlight group for the icon
          local path_part = string.format(' %s ', filepath)

          return icon_part .. path_part
        end,
        hl = function()
          return { fg = '#bbc2cf', bg = '#1e222a' }
        end,
        static = {
          init = function(self)
            -- Get the file extension and icon color
            local file_ext = vim.fn.expand '%:e'
            local filename = vim.fn.expand '%:t'
            local _, icon_color = require('nvim-web-devicons').get_icon_color(filename, file_ext, { default = true })

            -- Dynamically set the highlight group for the icon
            vim.api.nvim_set_hl(0, 'FileIcon', { fg = icon_color, bg = '#1e222a' })
          end,
        },
      }

      local GitBranch = {
        provider = function()
          -- Get the current branch name
          local branch = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head or ''
          if branch == '' then
            return ''
          end

          -- Get Git status counts from gitsigns
          local status_dict = vim.b.gitsigns_status_dict
          local added = status_dict.added or 0
          local modified = status_dict.changed or 0
          local deleted = status_dict.removed or 0

          -- Construct the output with colored icons
          local status_info = string.format('  %s %%#GitAdded#[ %d] %%#GitChanged#[ %d] %%#GitDeleted#[ %d] ', branch, added, modified, deleted)
          return status_info
        end,
        hl = { fg = '#a9a1e1', bg = '#1e222a' }, -- Adjust colors for the branch name
      }

      -- Diagnostics provider
      local Diagnostics = {
        condition = conditions.has_diagnostics,
        static = {
          error_icon = ' ',
          warn_icon = ' ',
          info_icon = ' ',
          hint_icon = ' ',
        },

        provider = function(self)
          local diagnostics = vim.diagnostic.get(0)
          local errors = vim.tbl_count(vim.tbl_filter(function(diag)
            return diag.severity == vim.diagnostic.severity.ERROR
          end, diagnostics))
          local warnings = vim.tbl_count(vim.tbl_filter(function(diag)
            return diag.severity == vim.diagnostic.severity.WARN
          end, diagnostics))

          local result = ''
          if errors > 0 then
            result = result .. self.error_icon .. errors .. ' '
          end
          if warnings > 0 then
            result = result .. self.warn_icon .. warnings .. ' '
          end
          return result
        end,
        hl = { fg = colors.red, bg = colors.bg },
      }

      require('heirline').setup {
        statusline = {
          -- Left Section: ViMode
          {
            ViMode,
            hl = { bg = '#1e222a', fg = '#98be65' },
          },
          -- Separator after left section
          {
            provider = ' | ',
            hl = { fg = '#5c6370', bg = '#1e222a' }, -- Light gray separator
          },
          { provider = '%=' }, -- Start of center alignment

          -- Center Section: FileInfo
          {
            FileInfo,
            hl = { bg = '#1e222a', fg = '#bbc2cf' },
          },
          -- Separator before right section
          { provider = '%=' }, -- End of center alignment
          {
            provider = ' | ',
            hl = { fg = '#5c6370', bg = '#1e222a' },
          },

          -- Right Section: GitBranch and Diagnostics
          {
            GitBranch,
            hl = { bg = '#1e222a', fg = '#a9a1e1' },
          },
          {
            Diagnostics,
            hl = { bg = '#1e222a', fg = '#ec5f67' },
          },
        },
      }
    end,
  },
}
