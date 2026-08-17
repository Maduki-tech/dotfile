local qmlls_import_path = vim.fn.trim(vim.fn.system("qmake6 -query QT_INSTALL_QML 2>/dev/null"))
if qmlls_import_path == "" then
  qmlls_import_path = "/usr/lib/qt6/qml"
end

-- Quickshell (omarchy) `qs.*` modules (qs.Commons, qs.Ui, ...) live in a
-- non-standard layout: /usr/share/omarchy/shell/Commons/qmldir declares
-- "module qs.Commons", but stock qmlls only finds modules at
-- <importPath>/qs/Commons/qmldir. Mirror quickshell's own VFS trick: symlink
-- the shell dir under a dedicated import path so `import qs.Commons` resolves.
local qml_imports_dir = vim.fn.stdpath("data") .. "/qml-imports"
local qs_link = qml_imports_dir .. "/qs"
local omarchy_shell = (vim.env.OMARCHY_PATH or "/usr/share/omarchy") .. "/shell"
if vim.fn.isdirectory(qs_link) ~= 1 and vim.fn.isdirectory(omarchy_shell) == 1 then
  vim.fn.mkdir(qml_imports_dir, "p")
  vim.fn.system({ "ln", "-sfn", omarchy_shell, qs_link })
end

local qmlls_cmd = { "qmlls", "-I", qmlls_import_path }
if vim.fn.isdirectory(qs_link) == 1 then
  vim.list_extend(qmlls_cmd, { "-I", qml_imports_dir })
end

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
      qmlls = {
        -- nvim 0.12 changed `cmd` function semantics (a function cmd must
        -- return an RPC client, not args), so pass a static cmd array.
        cmd = qmlls_cmd,
      },
    },
  },
}
