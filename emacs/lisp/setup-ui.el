;;; setup-ui.el --- UI and Theme configuration -*- lexical-binding: t; -*-

(set-face-attribute 'default nil :height 200) ; Set default zoom higher (14.0pt)

(use-package doom-themes
  :demand t
  :config (load-theme 'doom-one t))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

(use-package nerd-icons)

(setq display-line-numbers-type 'relative)
(setq-default display-line-numbers-width 4)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'after-init-hook #'show-paren-mode)

(provide 'setup-ui)
