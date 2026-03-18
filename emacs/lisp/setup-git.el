;;; setup-git.el --- Git and Magit Configuration -*- lexical-binding: t; -*-

(use-package magit
  :commands magit-status
  :custom
  ;; Show granular diffs per word instead of just whole lines
  (magit-diff-refine-hunk 'all)
  ;; Show the status buffer in a new full-screen window, closing others
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

(provide 'setup-git)