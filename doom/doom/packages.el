(package! catppuccin-theme)

;; Tailwind setup
(package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))

(unpin! org-roam)
(package! org-roam-ui)

(package! plantuml-mode)

(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))
