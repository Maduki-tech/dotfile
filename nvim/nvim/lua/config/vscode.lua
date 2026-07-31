-- VS Code / Cursor keymaps for vscode-neovim + LazyVim
-- Mirrors LazyVim window nav, picker (telescope/snacks), and custom keys.

local vscode = require("vscode")

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function action(command, opts)
  return function()
    vscode.action(command, opts)
  end
end

-- Window movement (LazyVim <C-hjkl>) — must call VS Code, not Neovim <C-w>
map("n", "<C-h>", action("workbench.action.navigateLeft"), { desc = "Go to Left Window" })
map("n", "<C-j>", action("workbench.action.navigateDown"), { desc = "Go to Lower Window" })
map("n", "<C-k>", action("workbench.action.navigateUp"), { desc = "Go to Upper Window" })
map("n", "<C-l>", action("workbench.action.navigateRight"), { desc = "Go to Right Window" })

-- Window resize (LazyVim <C-Arrow>)
map("n", "<C-Up>", action("workbench.action.increaseViewHeight"), { desc = "Increase Window Height" })
map("n", "<C-Down>", action("workbench.action.decreaseViewHeight"), { desc = "Decrease Window Height" })
map("n", "<C-Left>", action("workbench.action.decreaseViewWidth"), { desc = "Decrease Window Width" })
map("n", "<C-Right>", action("workbench.action.increaseViewWidth"), { desc = "Increase Window Width" })

-- Splits / windows
map("n", "<leader>-", action("workbench.action.splitEditorDown"), { desc = "Split Window Below" })
map("n", "<leader>|", action("workbench.action.splitEditorRight"), { desc = "Split Window Right" })
map("n", "<leader>wd", action("workbench.action.closeActiveEditor"), { desc = "Delete Window" })
map("n", "<leader>ww", action("workbench.action.focusNextGroup"), { desc = "Other Window" })
map("n", "<leader>wm", action("workbench.action.toggleMaximizeEditorGroup"), { desc = "Maximize Window" })

-- Buffers / tabs (LazyVim)
map("n", "<S-h>", action("workbench.action.previousEditor"), { desc = "Prev Buffer" })
map("n", "<S-l>", action("workbench.action.nextEditor"), { desc = "Next Buffer" })
map("n", "[b", action("workbench.action.previousEditor"), { desc = "Prev Buffer" })
map("n", "]b", action("workbench.action.nextEditor"), { desc = "Next Buffer" })
map("n", "<leader>bd", action("workbench.action.closeActiveEditor"), { desc = "Delete Buffer" })
map("n", "<leader>bo", action("workbench.action.closeOtherEditors"), { desc = "Delete Other Buffers" })
map("n", "<leader>bb", action("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup"), { desc = "Switch Buffer" })
map("n", "<leader>`", action("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup"), { desc = "Switch Buffer" })

-- Picker / Telescope equivalents (LazyVim + your <leader>sf)
map("n", "<leader><space>", action("workbench.action.quickOpen"), { desc = "Find Files" })
map("n", "<leader>ff", action("workbench.action.quickOpen"), { desc = "Find Files" })
map("n", "<leader>sf", action("workbench.action.quickOpen"), { desc = "Find Files" })
map("n", "<leader>fr", action("workbench.action.openRecent"), { desc = "Recent" })
map("n", "<leader>,", action("workbench.action.showAllEditorsByMostRecentlyUsed"), { desc = "Buffers" })
map("n", "<leader>fb", action("workbench.action.showAllEditorsByMostRecentlyUsed"), { desc = "Buffers" })
map("n", "<leader>/", action("workbench.action.findInFiles"), { desc = "Grep" })
map("n", "<leader>sg", action("workbench.action.findInFiles"), { desc = "Grep" })
map("n", "<leader>ss", action("workbench.action.gotoSymbol"), { desc = "Document Symbols" })
map("n", "<leader>sS", action("workbench.action.showAllSymbols"), { desc = "Workspace Symbols" })
map("n", "<leader>sk", action("workbench.action.openView"), { desc = "Keymaps / Views" })

-- Oil → file explorer
map("n", "<C-b>", action("workbench.view.explorer"), { desc = "Open Explorer (Oil)" })

-- Neogit / git
map("n", "<leader>gg", action("workbench.view.scm"), { desc = "Git (SCM)" })
map("n", "<leader>gs", action("workbench.view.scm"), { desc = "Git Status" })

-- LSP
map("n", "gd", action("editor.action.revealDefinition"), { desc = "Goto Definition" })
map("n", "gr", action("editor.action.goToReferences"), { desc = "References" })
map("n", "gI", action("editor.action.goToImplementation"), { desc = "Goto Implementation" })
map("n", "gy", action("editor.action.goToTypeDefinition"), { desc = "Goto Type Definition" })
map("n", "K", action("editor.action.showHover"), { desc = "Hover" })
map("n", "<leader>ca", action("editor.action.quickFix"), { desc = "Code Action" })
map("n", "<leader>cr", action("editor.action.rename"), { desc = "Rename" })
map({ "n", "x" }, "<leader>cf", action("editor.action.formatDocument"), { desc = "Format" })

-- Diagnostics
map("n", "]d", action("editor.action.marker.next"), { desc = "Next Diagnostic" })
map("n", "[d", action("editor.action.marker.prev"), { desc = "Prev Diagnostic" })
map("n", "]e", action("editor.action.marker.next"), { desc = "Next Diagnostic" })
map("n", "[e", action("editor.action.marker.prev"), { desc = "Prev Diagnostic" })
map("n", "<leader>cd", action("editor.action.marker.next"), { desc = "Line Diagnostics" })
map("n", "<leader>xx", action("workbench.actions.view.problems"), { desc = "Diagnostics" })

-- Save / quit (your Q = save and quit)
map({ "n", "i", "x" }, "<C-s>", action("workbench.action.files.save"), { desc = "Save File" })
map("n", "Q", function()
  vscode.action("workbench.action.files.save")
  vscode.action("workbench.action.closeActiveEditor")
end, { desc = "Save and quit" })
map("n", "<leader>qq", action("workbench.action.quit"), { desc = "Quit All" })
map("n", "<leader>fn", action("workbench.action.files.newUntitledFile"), { desc = "New File" })

-- Terminal
map("n", "<leader>ft", action("workbench.action.terminal.toggleTerminal"), { desc = "Terminal" })
map("n", "<leader>fT", action("workbench.action.terminal.toggleTerminal"), { desc = "Terminal" })
map("n", "<C-/>", action("workbench.action.terminal.toggleTerminal"), { desc = "Terminal" })

-- Move lines (LazyVim <A-j>/<A-k>)
map("n", "<A-j>", action("editor.action.moveLinesDownAction"), { desc = "Move Down" })
map("n", "<A-k>", action("editor.action.moveLinesUpAction"), { desc = "Move Up" })
map("v", "<A-j>", action("editor.action.moveLinesDownAction"), { desc = "Move Down" })
map("v", "<A-k>", action("editor.action.moveLinesUpAction"), { desc = "Move Up" })
