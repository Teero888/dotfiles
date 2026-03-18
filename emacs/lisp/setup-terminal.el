;;; setup-terminal.el

(use-package eat
  :hook (after-init . eat-eshell-mode)
  :config
  (add-hook 'eat-mode-hook (lambda () (setq-local scroll-margin 0)))
  
  (with-eval-after-load 'evil
    (setq evil-insert-state-cursor 'bar)
    (setq evil-normal-state-cursor 'box)
    (evil-set-initial-state 'eat-mode 'insert)
    
    (define-key eat-mode-map (kbd "<escape>") 'evil-normal-state)
    (define-key eat-char-mode-map (kbd "<escape>") 'evil-normal-state)
    
    ; (evil-define-key 'insert eat-mode-map (kbd "C-w") 'eat-self-input)
    ; (evil-define-key 'insert eat-mode-map (kbd "C-c") 'eat-self-input)
    ; (evil-define-key 'insert eat-mode-map (kbd "C-d") 'eat-self-input)
    ; (evil-define-key 'insert eat-mode-map (kbd "C-l") 'eat-self-input)
    ; (evil-define-key 'insert eat-mode-map (kbd "C-y") 'eat-self-input)
    ; (evil-define-key 'insert eat-mode-map (kbd "C-v") 'eat-yank)
    
    (add-hook 'evil-insert-state-entry-hook
              (lambda () (when (derived-mode-p 'eat-mode) (eat-char-mode))))
    (add-hook 'evil-normal-state-entry-hook
              (lambda () (when (derived-mode-p 'eat-mode) (eat-line-mode)))))

  :custom
  (eat-kill-buffer-on-exit t)
  (eat-term-name "xterm-256color"))

(provide 'setup-terminal)
