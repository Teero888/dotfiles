;;; setup-terminal.el --- Terminal Emulation -*- lexical-binding: t; -*-

(use-package eat
  :hook
  (eshell-load . eat-eshell-mode)
  (eshell-load . eat-eshell-visual-command-mode)
  :custom
  (eat-kill-buffer-on-exit t)
  (eat-enable-mouse t)
  ;; Use a universally recognized terminal type to prevent "unknown terminal" 
  ;; errors in bash, ssh, and programs like 'clear'
  (eat-term-name "xterm-256color")
  :config
  ;; Increase scrollback buffer size
  (setq eat-term-scrollback-size 10000)

  ;; Ensure EAT intercepts all standard terminal control keys in Evil insert mode.
  ;; `evil-collection` misses a few like C-c by design, but for a true terminal 
  ;; feel, we want them sent straight to the shell process ONLY in insert mode.
  (with-eval-after-load 'evil
    (evil-define-key 'insert eat-mode-map
      (kbd "C-c") #'eat-self-input  ;; Sigint
      (kbd "C-l") #'eat-self-input  ;; Clear
      (kbd "C-d") #'eat-self-input  ;; EOF
      (kbd "C-z") #'eat-self-input  ;; Suspend
      (kbd "C-w") #'eat-self-input  ;; Delete word
      (kbd "C-u") #'eat-self-input  ;; Delete line
      (kbd "C-r") #'eat-self-input  ;; Reverse search
      (kbd "C-p") #'eat-self-input
      (kbd "C-n") #'eat-self-input
      (kbd "C-a") #'eat-self-input
      (kbd "C-e") #'eat-self-input
      (kbd "C-<left>") #'eat-self-input
      (kbd "C-<right>") #'eat-self-input
      (kbd "C-y") #'eat-self-input
      (kbd "C-v") #'eat-yank
      (kbd "<backspace>") #'eat-self-input
      (kbd "DEL") #'eat-self-input
      (kbd "<delete>") #'eat-self-input
      (kbd "RET") #'eat-self-input
      (kbd "<return>") #'eat-self-input)))

(provide 'setup-terminal)
