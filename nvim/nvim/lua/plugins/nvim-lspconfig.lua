return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
    },
    diagnostics = {
      float = {
        border = "rounded",
      },
    },

    -- make sure mason installs the server
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
            completion = {
              callSnippet = "Replace",
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
      vtsls = {
        -- explicitly add default filetypes, so that we can extend
        -- them in related extras
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          complete_function_calls = true,
        },
      },
    },

    -- Custom setup function to hook up the non-Mason QML language server
    setup = {
      qml_language_server = function()
        local lspconfig = require("lspconfig")

        lspconfig.qml_language_server = {
          default_config = {
            cmd = { "qml-language-server" },
            filetypes = { "qml", "qmljs" },
            root_dir = lspconfig.util.root_pattern("qmlls.ini", ".git", "."),
            single_file_support = true,
          },
        }

        lspconfig.qml_language_server.setup({})
        return true -- Prevents this server from trying to load via Mason
      end,
    },
  },
}
