;;; setup-keys.el --- Ultimate Absolute Zero Keybindings -*- lexical-binding: t; -*-

(use-package general
  :demand t
  :config
  (general-evil-setup t)

  (defun my/purge-all-keys ()
    "Programmatically unbinds every key in Emacs to enforce a strict whitelist."
    (let ((new-global (make-keymap)))
      (let ((i 32))
        (while (<= i 126)
          (define-key new-global (vector i) #'self-insert-command)
          (setq i (1+ i))))
      (define-key new-global (kbd "RET")     #'newline)
      (define-key new-global (kbd "TAB")     #'indent-for-tab-command)
      (define-key new-global (kbd "DEL")     #'backward-delete-char-untabified)
      (define-key new-global (kbd "<backspace>") #'backward-delete-char)
      (define-key new-global (kbd "C-g")     #'keyboard-quit)
      (define-key new-global (kbd "M-x")     #'execute-extended-command)
      (define-key new-global (kbd "<left>")     #'left-char)
      (define-key new-global (kbd "<right>")     #'right-char)
      
      (use-global-map new-global))

    (setq emulation-mode-map-alists nil)

    (my/filter-minor-mode-maps))

  (defvar my/allowed-minor-mode-prefixes
    '("eat" "magit" "git-gutter")
    "List of string prefixes for minor modes whose keymaps should NOT be purged.")

  (defun my/filter-minor-mode-maps (&rest _)
    "Purge minor mode maps, keeping only those whose names match a prefix in `my/allowed-minor-mode-prefixes`."
    (let ((keep-p (lambda (cons)
                    (let ((mode-name (symbol-name (car cons))))
                      (seq-some (lambda (prefix)
                                  (string-prefix-p prefix mode-name))
                                my/allowed-minor-mode-prefixes)))))
      (setq minor-mode-map-alist (seq-filter keep-p minor-mode-map-alist))
      (setq minor-mode-overriding-map-alist (seq-filter keep-p minor-mode-overriding-map-alist))))

  ;; (my/purge-all-keys)

  ;; Hook it so that any plugin loaded *after* this also gets its minor-mode keys purged
  ;; (add-hook 'after-load-functions #'my/filter-minor-mode-maps)

  ;; ── Helper Functions ───────────────────────────────────────

  (defun my/minibuffer-quit ()
    (interactive)
    (abort-recursive-edit))

  (defun corfu-toggle ()
    (interactive)
    (if (and (bound-and-true-p corfu-mode) (corfu--visible-p))
        (corfu-quit)
      (completion-at-point)))

  (global-set-key [escape] 'keyboard-escape-quit)

  ;; Completion
  (general-define-key
   :keymaps 'global
   "C-SPC" #'corfu-toggle)

  (general-define-key
   :states 'insert
   "C-SPC" #'corfu-toggle
   "C-y"   #'corfu-insert)

  ;; Leader Key Setup (SPC)
  (general-create-definer my/leader-keys
    :keymaps '(normal visual)
    :prefix "SPC")

  (my/leader-keys
    "SPC" '(switch-to-buffer :which-key "switch buffer") "."   '(find-file :which-key "find file")
    "b"  '(:ignore t :which-key "buffers")
    "bb" '(switch-to-buffer :which-key "switch")
    "bd" '(kill-this-buffer :which-key "kill buffer")

    "c"  '(:ignore t :which-key "code")
    "ca" '(eglot-code-actions :which-key "code actions")
    "cf" '(eglot-format-buffer :which-key "format")
    "cc" '(comment-dwim :which-key "format")

    "f"  '(:ignore t :which-key "files")
    "ff" '(find-file :which-key "find file")
    "fs" '(save-buffer :which-key "save")

    "p"  '(:ignore t :which-key "project")
    "pp" '(projectile-switch-project :which-key "switch")
    "pf" '(projectile-find-file :which-key "find file")
    "ps" '(consult-ripgrep :which-key "search project")

    "s"  '(:ignore t :which-key "search")
    "sr" '(consult-ripgrep :which-key "ripgrep")
    "ss" '(consult-line :which-key "line")
    
    "t"  '(eat :which-key "terminal")

    "g" '(magit-status :which-key "status"))

  ;; Minibuffer / Completion Maps
  (general-define-key
   :keymaps 'minibuffer-local-map
   "C-w"  #'backward-kill-word)

  (general-define-key
   :keymaps 'vertico-map
   "<escape>"  #'my/minibuffer-quit
   "<tab>"     #'vertico-next
   "<backtab>" #'vertico-previous
   "C-y"       #'vertico-insert)

  (general-define-key
   :keymaps 'corfu-map
   "<tab>"      #'corfu-next
   "<backtab>"  #'corfu-previous
   "C-y"        #'corfu-insert))

(provide 'setup-keys)
