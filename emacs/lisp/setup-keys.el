;;; setup-keys.el --- Ultimate Absolute Zero Keybindings -*- lexical-binding: t; -*-

(use-package general
  :demand t
  :config
  (general-evil-setup t)

  ;; ─ Helper Functions ─

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
   "C-y"   #'corfu-insert
   "C-k"   nil)

  ;; Leader Key Setup (SPC)
  (general-create-definer my/leader-keys
    :keymaps '(normal visual)
    :prefix "SPC")

  (general-define-key
   :states '(normal visual motion)
   "C-j" #'evil-next-line
   "C-k" #'evil-previous-line)

  ;; Magit: C-hjkl movement (C-j UP, C-k DOWN)
  (defun my/scrub-magit-maps ()
    (dolist (sym '(magit-file-section-map
                   magit-hunk-section-map
                   magit-untracked-section-map
                   magit-stashed-section-map
                   magit-commit-section-map
                   magit-branch-section-map
                   magit-remote-section-map
                   magit-tag-section-map
                   magit-module-commit-section-map))
      (when (boundp sym)
        (let ((m (symbol-value sym)))
          (when (keymapp m)
            (define-key m (kbd "C-h") nil)
            (define-key m (kbd "C-k") nil)
            (define-key m (kbd "C-j") nil)
            (define-key m (kbd "C-l") nil))))))

  (with-eval-after-load 'magit
    ;; Bind globally in all magit modes
    (general-define-key
     :keymaps '(magit-mode-map
                magit-status-mode-map
                magit-diff-mode-map
                magit-log-mode-map
                magit-section-mode-map)
     :states '(normal visual motion emacs)
     "C-h" #'evil-backward-char
     "C-k" #'previous-line
     "C-j" #'next-line
     "C-l" #'evil-forward-char)

    ;; Scrub text properties when magit loads, and also hook into magit-refresh
    ;; to ensure they are scrubbed even if lazy-loaded later!
    (my/scrub-magit-maps)
    (add-hook 'magit-refresh-buffer-hook #'my/scrub-magit-maps))

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
   "C-j"       #'vertico-next
   "C-k"       #'vertico-previous
   "C-y"       #'vertico-insert)

  (general-define-key
   :keymaps 'corfu-map
   "<tab>"      #'corfu-next
   "<backtab>"  #'corfu-previous
   "C-j"        #'corfu-next
   "C-k"        #'corfu-previous
   "C-y"        #'corfu-insert))

(provide 'setup-keys)
