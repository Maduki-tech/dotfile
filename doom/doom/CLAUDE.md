# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Essential Commands

After any change to `init.el` or `packages.el`, run:
```bash
doom sync
```

To apply changes in `config.el` or `config.org` without restarting, reload Doom inside Emacs:
```
SPC h r r   (doom/reload)
```

## File Roles

| File | Purpose |
|------|---------|
| `init.el` | Module selection — toggles which Doom modules are active. Edit this to enable/disable language support, UI modules, tools, etc. |
| `config.el` | User configuration — compiled output from `config.org`. Do not edit directly if using the literate workflow. |
| `config.org` | Literate configuration source — the canonical place to add/change settings. Doom's `:config literate` module auto-tangles this to `config.el` on sync. |
| `packages.el` | Extra package declarations via `package!`. Add third-party packages here. |
| `custom.el` | Managed by Emacs Custom; do not edit by hand. |

## Literate Config Workflow

The `:config literate` module is active. This means:
- `config.org` is the source of truth; `config.el` is auto-generated.
- Add new Emacs Lisp configuration inside `#+begin_src emacs-lisp` / `#+end_src` blocks in `config.org`.
- Headings in `config.org` organize sections (LSP, Org, etc.) — match that structure when adding new sections.
- `doom sync` tangles `config.org` → `config.el` automatically.
