;;; config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "David Schlueter"
      user-mail-address "d.schlueter1011@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 18 )
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 18))


(setq doom-theme 'catppuccin)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/inbox.org"
                         "~/org/tasks.org"
                         "~/org/notes.org"))
(setq org-roam-directory (file-truename "~/org/roam/"))

;; Default capture template for `ROAM'
(setq org-roam-capture-templates
      '(("d" "default" plain "%?"
         :if-new (file+head "${slug}.org"
                            "#+title: ${title}\n#+date: %U\n\n")
         :unnarrowed t)))

(setq org-capture-templates
      '(
        ;; Quick TODO (in tasks.org)
        ("t" "Todo" entry
         (file+headline "~/org/tasks.org" "Inbox")
         "* TODO %?\n  %U\n  %a" :empty-lines 1)

        ;; Quick note (in notes.org)
        ("n" "Note" entry
         (file+headline "~/org/notes.org" "Unsorted")
         "* %?\n  %U\n  %a" :empty-lines 1)

        ;; Capture daily log/journal in inbox.org
        ("j" "Journal" entry
         (file+datetree "~/org/inbox.org")
         "* %?\nEntered on %U\n  %i\n  %a" :empty-lines 1)))


(setq projectile-project-search-path '(("~/personal/" . 2) ("~/.config" . 2)))

;; TailwindCSS LSP support
;; (use-package lsp-tailwindcss
;;   :ensure t
;;   :after lsp-mode
;;   :init
;;   (setq lsp-tailwindcss-add-on-mode t
;;         lsp-tailwindcss-server-version "0.14.8"
;;         lsp-tailwindcss-skip-config-check t))

(use-package! lsp-tailwindcss :after lsp-mode)


(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))


;; IntelliJ-Style completion
(after! corfu
  ;; RET = accept like IntelliJ
  (define-key corfu-map (kbd "RET") #'corfu-insert)
  (define-key corfu-map (kbd "<return>") #'corfu-insert)
  ;; Shift+RET = newline
  (define-key corfu-map (kbd "S-RET") #'newline)
  (define-key corfu-map (kbd "S-<return>") #'newline)

  ;; Faster LSP Popup
  (setq corfu-auto t
        corfu-auto-delay 0.1
        corfu-auto-prefix 1
        corfu-preselect 'first
        completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((lsp-capf (styles orderless)))
        orderless-matching-styles '(orderless-flex)
        )
  )


(after! lsp-mode
  (setq lsp-completion-provider :none
        lsp-completion-enable-additional-text-edit nil
        lsp-completion-show-kind t))


(map! :leader
      (:prefix ("s" . "search")
       :desc "Find files in project root" "f" #'projectile-find-file))


(setq scroll-margin 20)

;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)))

(setq org-plantuml-jar-path
      (expand-file-name "/usr/share/java/plantuml/plantuml.jar"))



(defun my/tsx-in-jsx-p ()
  "Return non-nil if point is inside a JSX node in tsx-ts-mode."
  (when (derived-mode-p 'tsx-ts-mode)
    (let ((node (treesit-node-at (point))))
      (catch 'yes
        (while node
          (when (member (treesit-node-type node)
                        '("jsx_element" "jsx_fragment" "jsx_self_closing_element"
                          "jsx_text" "jsx_opening_element" "jsx_closing_element"
                          "jsx_attribute" "jsx_expression"))
            (throw 'yes t))
          (setq node (treesit-node-parent node)))
        nil))))

(defun my/tsx-smart-comment (beg end)
  "Context-aware comment for TSX: JSX => {/* ... */}, else //."
  (interactive (list (when (use-region-p) (region-beginning))
                     (when (use-region-p) (region-end))))
  (let* ((in-jsx (my/tsx-in-jsx-p))
         (c-start (if in-jsx "{/* " "// "))
         (c-end   (if in-jsx " */}" "")))
    (let ((comment-start c-start)
          (comment-end   c-end)
          (comment-style (if in-jsx 'multi-line comment-style)))
      (cond
       ((use-region-p) (comment-or-uncomment-region beg end))
       (t              (comment-line 1))))))

;; Bind gc/gcc in tsx-ts-mode to the smart toggler
(after! treesit
  (map! :map tsx-ts-mode-map
        :n "gc"  #'my/tsx-smart-comment
        :v "gc"  #'my/tsx-smart-comment
        :n "gcc" #'my/tsx-smart-comment))
