;;; setup-eww.el --- EWW configuration -*- lexical-binding: t; -*-

(use-package eww
  :defer t
  :config
  (general-define-key
   :keymaps 'eww-mode-map
   :states 'normal
   "DEL" #'eww-back-url
   "<backspace>" #'eww-back-url))

(provide 'setup-eww)
