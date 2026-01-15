# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfile repository for an Arch Linux development environment. It manages configurations for Neovim (LazyVim), Tmux, Ghostty terminal, and various utility scripts. The repository uses **GNU Stow** for symlink-based deployment.

**Deployment mechanism:** Stow creates symlinks from `<app>/<app>/` directories to `~/.config/<app>/`. For example, `nvim/nvim/` maps to `~/.config/nvim/`.

## Installation & Setup Commands

### Initial Setup
```bash
# Main installation (minimal bootstrap)
./install.sh

# Install Neovim from source with configuration
./installation/install-nvim.sh

# Install Tmux and utility scripts
./installation/tmux-nvim.sh

# Install development dependencies (base-devel, cmake, ninja, curl, git, stow, tmux, npm, nodejs, ripgrep, fzf, zsh, go, python, docker, etc.)
./installation/develop.sh

# Configure GTK/Qt dark mode
./darkmode.sh
```

### Deploy Configurations Manually
```bash
# Deploy specific configuration using stow
cd ~/dotfile
stow -t ~/.config nvim    # Deploy Neovim config
stow -t ~/.config tmux    # Deploy Tmux config
stow -t ~/.config script  # Deploy utility scripts
stow -t ~/.config ghostty # Deploy Ghostty terminal config
```

### Neovim Commands
```bash
# Neovim is built from source at ~/Github/neovim
# Configuration located at: nvim/nvim/
nvim                      # Launch editor
:Lazy                     # Open plugin manager
:LazyExtras               # Manage LazyVim extras
:Mason                    # LSP/DAP/formatter installer
```

### Tmux Commands
```bash
# Prefix key: C-a (Ctrl+Alt)
tmux                      # Start new session
tmux attach               # Attach to existing session

# Inside tmux:
# C-a f   - Launch project session finder (tmux-sessiongod.sh)
# C-a N   - Open Neovim session
# C-a o   - Open Obsidian vault session
# C-a i   - Launch cheatsheet lookup
# C-a d   - Horizontal split
# C-a V   - Vertical split
# C-a k/j/h/l - Navigate panes (VI-style)
```

## Architecture & Key Concepts

### 1. Neovim Configuration (LazyVim-based)

**Structure:**
- `nvim/nvim/init.lua` - Bootstrap entry point
- `nvim/nvim/lua/config/` - Core settings (options, keymaps, autocmds)
- `nvim/nvim/lua/plugins/` - Plugin configurations (one file per plugin)
- `nvim/nvim/lazyvim.json` - LazyVim extras configuration
- `nvim/nvim/lazy-lock.json` - Locked plugin versions

**Enabled LazyVim Extras:**
- Languages: C/C++, CMake, Docker, Go, JSON, Python, Rust, SQL, TypeScript
- Tools: Copilot, DAP (debugging), Prettier, ESLint, Tailwind CSS

**Custom Plugins:**
- **Obsidian.nvim** (nvim/nvim/lua/plugins/obsidian.lua:1): Knowledge base integration with `~/vault/` workspace
- **Neogit** (nvim/nvim/lua/plugins/neogit.lua:1): Git UI (`<leader>gg`)
- **Oil.nvim** (nvim/nvim/lua/plugins/oil.lua:1): File explorer (`<C-b>`)
- **Blink.nvim** (nvim/nvim/lua/plugins/blink.lua:1): Completion engine
- **Multiple colorschemes** (nvim/nvim/lua/plugins/colorscheme.lua:1): Catppuccin (default), Gruvbox, Kanagawa, Rose Pine, Tokyonight, and others

**Custom Keybindings:**
- `Q` - Save and quit
- `<C-b>` - Open Oil file explorer
- `<leader>on` - Create new Obsidian note
- `<leader>gg` - Open Neogit UI

**Important Settings:**
- No swap files enabled
- 80-character column indicator
- 4-space indentation (not tabs)
- LSP diagnostics with rounded borders

### 2. Tmux Configuration

**Key customizations:**
- Prefix changed to `C-a` (Ctrl+Alt)
- VI mode keybindings enabled
- Mouse support enabled
- Auto-rename disabled for manual session management
- Catppuccin Mocha theme (tmux/tmux/plugins/catppuccin/)

**Session management integration:**
- Uses `tmux-sessiongod.sh` for intelligent session switching
- Searches `~/Github/` and `~/projects/` directories
- Auto-names sessions based on directory basename

**Cheatsheet integration:**
- Keybind `C-a i` launches `cht.sh` script
- Supports languages: golang, nodejs, javascript, typescript, c++, lua, rust, python, bash, etc.
- Supports commands: git, docker, make, cargo, find, grep, sed, awk, etc.

### 3. Utility Scripts

Located in `script/script/`, deployed to `~/.config/script/`:

**tmux-sessiongod.sh** - Smart tmux session manager
- Searches `~/Github/` and `~/projects/` for project directories
- Creates/switches to sessions automatically
- Can accept explicit path as argument

**fp** - Project folder creator
- Interactive category selection (Go, Java, Javascript, Rust, C, C++, Python, etc.)
- Creates folder structure in `~/personal/[category]/[subfolder]`
- Automatically opens tmux session in new folder

**cht.sh** - Cheatsheet lookup
- Uses `tmux-cht-languages` and `tmux-cht-command` files for fzf selection
- Fetches documentation from `curl cht.sh/` API
- Opens results in new tmux window

**ccm** - CMake template generator
- Creates CMakeLists.txt for C++ projects
- Sets C++17 standard

**javaup.sh** - Maven project setup
- Generates Maven archetype quickstart
- Creates run script and clang-format config

### 4. Directory Organization Conventions

**Project directories:**
- `~/Github/` - Main projects and cloned repositories
- `~/projects/` - Additional project workspace
- `~/personal/` - Personal projects organized by language/category
- `~/vault/` - Obsidian knowledge base

**Configuration deployment:**
- Source: `~/dotfile/<app>/<app>/`
- Target: `~/.config/<app>/`
- Method: GNU Stow symlinks

### 5. Historical Configurations (Currently Deleted Locally)

The following configurations exist in Git history but are not currently active:
- **Hyprland** (Wayland compositor with modular config files)
- **Nushell** (shell with Starship prompt)
- **Starship** (shell prompt)
- **Waybar** (status bar)
- **Doom Emacs** (previous editor setup)

These were removed in recent commits but may be restored if needed.

## Development Workflow

1. **Starting a new project:**
   - Use `fp` script for structured folder creation, or
   - Use `tmux-sessiongod.sh` (via `C-a f`) to navigate to existing projects

2. **Working with Neovim:**
   - Obsidian notes: `<leader>on` creates notes in `~/vault/`
   - Git operations: `<leader>gg` opens Neogit
   - File navigation: `<C-b>` opens Oil file explorer

3. **Session management:**
   - Keep tmux sessions named after project directories
   - Use `tmux-sessiongod.sh` to switch between active projects
   - Special sessions: Neovim config (`C-a N`), Obsidian vault (`C-a o`)

4. **Looking up documentation:**
   - Press `C-a i` in tmux to launch cheatsheet lookup
   - Covers programming languages and common CLI tools

## Important Paths

- Neovim config: `nvim/nvim/`
- Tmux config: `tmux/tmux/tmux.conf`
- Utility scripts: `script/script/`
- Installation scripts: `installation/`
- Project directories: `~/Github/`, `~/projects/`
- Obsidian vault: `~/vault/`
