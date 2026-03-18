;;; setup-evil.el --- Vim keybindings and leaders -*- lexical-binding: t; -*-

(use-package evil
  :demand t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config (evil-collection-init))

(use-package evil-commentary
  :after evil
  :config (evil-commentary-mode))

(use-package which-key
  :straight nil
  :hook (after-init . which-key-mode)
  :custom (which-key-idle-delay 0.3))

(provide 'setup-evil)
