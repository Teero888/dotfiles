;;; setup-projects.el --- Projectile and search configuration -*- lexical-binding: t; -*-

(use-package projectile
  :hook (after-init . projectile-mode)
  :config
  (setq projectile-indexing-method 'hybrid)
  :custom
  (projectile-completion-system 'default))

(use-package rg :straight t)

(provide 'setup-projects)
