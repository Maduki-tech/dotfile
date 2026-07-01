(setq doom-theme 'catppuccin)
(setq display-line-numbers-type 'relative)
(setq org-directory "~/org/")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 22 :weight 'semi-light)
     doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 13))

;; Max treesitter font-lock level for complete highlighting (class names, generics, etc.)
(setq treesit-font-lock-level 4)

;; Offset scrolling
(setq scroll-margin 8)

;; Auto-popup after first keystroke, pre-select first candidate
(after! corfu
  (setq corfu-auto t
        corfu-auto-delay 0.1
        corfu-auto-prefix 1
        corfu-cycle t
        corfu-preselect 'first
        corfu-on-exact-match nil
        corfu-quit-no-match 'separator)

  ;; Quick Docs panel alongside candidates (IntelliJ's documentation popup)
  (corfu-popupinfo-mode 1)
  (setq corfu-popupinfo-delay '(0.3 . 0.1))

  ;; Recently-used completions rank higher
  (corfu-history-mode 1))

(after! savehist
  (add-to-list 'savehist-additional-variables 'corfu-history))

;; Kind icons: method/field/class/variable symbols like IntelliJ
(use-package! nerd-icons-corfu
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; hotfuzz (via vertico +fuzzy) handles file/buffer finding with scoring,
;; so orderless-flex is only needed for in-buffer corfu completions.
;; Keep initialism ("gSF" -> getStatusFlag) and prefixes; drop flex here
;; to avoid scattered-char false positives in minibuffer.
(after! orderless
  (setq orderless-matching-styles
        '(orderless-initialism
          orderless-prefixes
          orderless-literal)))

;; Route LSP completions through corfu (capf), keep response snappy
;; Semantic tokens let jdtls tell Emacs exactly which identifiers are classes/methods/etc.
(after! lsp-mode
  (setq lsp-completion-provider :capf
        lsp-idle-delay 0.1
        lsp-semantic-tokens-enable t))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>"   . copilot-accept-completion)
              ("TAB"     . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB"   . copilot-accept-completion-by-word)
              ("M-n"     . copilot-next-completion)
              ("M-p"     . copilot-previous-completion)))

(setq org-roam-directory (file-truename "~/org/roam/"))

(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)" "KILL(k)"))))

(after! org
  (setq org-capture-templates
        '(("t" "Todo" entry (file "~/org/inbox.org")
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
          ("n" "Fleeting note" entry (file "~/org/inbox.org")
           "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n"))))

(after! org-roam
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+date: %U\n")
           :unnarrowed t))))

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t))
