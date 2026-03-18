;;; setup-keys.el --- Centralized keybindings configuration -*- lexical-binding: t; -*-

(use-package general
  :demand t
  :config
  (general-evil-setup t)

  ;; ── Helper Functions ───────────────────────────────────────

  (defun my/minibuffer-quit ()
    "Abort the minibuffer."
    (interactive)
    (abort-recursive-edit))

  (defun corfu-toggle ()
    "Toggle completion suggestions. If visible, quit; otherwise, trigger completion."
    (interactive)
    (if (and (bound-and-true-p corfu-mode)
             (corfu--visible-p))
        (corfu-quit)
      (completion-at-point)))

  (defun save-and-kill-buffer ()
    "Save the current buffer and then kill it."
    (interactive)
    (save-buffer)
    (kill-this-buffer))

  ;; ── Global Bindings ────────────────────────────────────────

  (general-define-key
   :keymaps 'global
   "C-SPC" #'corfu-toggle)

  ;; ── Evil State Overrides ───────────────────────────────────

  (general-define-key
   :states 'insert
   "C-SPC" #'corfu-toggle
   "C-y"   #'corfu-insert)

  ;; (general-define-key
  ;;  :states '(normal visual)
  ;;  ":" #'execute-extended-command)

  ;; ── Leader Key Setup (SPC) ─────────────────────────────────

  (general-create-definer my/leader-keys
    :keymaps '(normal visual)
    :prefix "SPC")

  (my/leader-keys
    ","   '(switch-to-buffer :which-key "switch buffer")
    "."   '(find-file :which-key "find file")

    ;; Buffers
    "b"  '(:ignore t :which-key "buffers")
    "bb" '(switch-to-buffer :which-key "switch")
    "bd" '(kill-this-buffer :which-key "kill buffer")
    "bn" '(next-buffer :which-key "next")
    "bp" '(previous-buffer :which-key "prev")

    ;; Code / LSP
    "c"  '(:ignore t :which-key "code")
    "ca" '(eglot-code-actions :which-key "code actions")
    "cf" '(eglot-format-buffer :which-key "format")
    "cr" '(eglot-rename :which-key "rename")
    "cs" '(consult-eglot-symbols :which-key "symbols")

    ;; Files
    "f"  '(:ignore t :which-key "files")
    "ff" '(find-file :which-key "find file")
    "fr" '(consult-recent-file :which-key "recent")
    "fs" '(save-buffer :which-key "save")

    ;; Project
    "p"  '(:ignore t :which-key "project")
    "pp" '(projectile-switch-project :which-key "switch")
    "pf" '(projectile-find-file :which-key "find file")
    "ps" '(consult-ripgrep :which-key "search project")
    "pa" '(projectile-add-known-project :which-key "add project")

    ;; Search
    "s"  '(:ignore t :which-key "search")
    "sr" '(consult-ripgrep :which-key "ripgrep")
    "ss" '(consult-line :which-key "line")
    "si" '(consult-imenu :which-key "imenu")

    ;; Terminal
    "t" '(eat :which-key "new eat")

    ;; Window
    "w"  '(:ignore t :which-key "windows")
    "wd" '(delete-window :which-key "delete")
    "wh" '(windmove-left :which-key "←")
    "wj" '(windmove-down :which-key "↓")
    "wk" '(windmove-up :which-key "↑")
    "wl" '(windmove-right :which-key "→")
    "ws" '(split-window-below :which-key "split h")
    "wv" '(split-window-right :which-key "split v")
    "ww" '(other-window :which-key "other window")

    ;; Help
    "h"  '(:ignore t :which-key "help")
    "hf" '(describe-function :which-key "function")
    "hk" '(describe-key :which-key "key")
    "hv" '(describe-variable :which-key "variable")

    "g"  '(:ignore g :which-key "commenting")
    "gc" '(comment-dwim :which-key "comment")
    "gg" '(comment-box :which-key "comment")
    
    )


  ;; ── Package-Specific Maps ──────────────────────────────────

  ;; Vertico
  (general-define-key

   "TAB"      #'vertico-next
   "<tab>"    #'vertico-next
   "S-TAB"    #'vertico-previous
   "<backtab>" #'vertico-previous
   "C-y"      #'vertico-exit)

  ;; Corfu
  (general-define-key
   :keymaps 'corfu-map
   "TAB"      #'corfu-next
   "<tab>"    #'corfu-next
   "S-TAB"    #'corfu-previous
   "<backtab>" #'corfu-previous
   "C-y"      #'corfu-insert)

  ;; Consult
  (general-define-key
   "C-s" #'consult-line)

  ;; Embark
  (general-define-key
   "C-."   #'embark-act
   "C-;"   #'embark-dwim
   "C-h B" #'embark-bindings))

(provide 'setup-keys)
