;;; init.el

;; ── Performance Optimization ────────────────────────────────
(setq straight-check-for-modifications '(check-on-save find-when-checking))
(setq-default gc-cons-threshold (* 16 1024 1024)) ; 16MB after startup

;; ── Straight.el Bootstrap ───────────────────────────────────
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; ── Load Path ───────────────────────────────────────────────
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-defer t)

;; ── Environment ─────────────────────────────────────────────
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :config
  (exec-path-from-shell-initialize))

(let ((npm-bin (expand-file-name "~/.npm-global/bin"))
      (local-bin (expand-file-name "~/.local/bin"))
      (cargo-bin (expand-file-name "~/.cargo/bin")))
  (dolist (path (list npm-bin local-bin cargo-bin))
    (when (file-directory-p path)
      (add-to-list 'exec-path path)
      (setenv "PATH" (concat path ":" (getenv "PATH"))))))

;; ── Core Modules ────────────────────────────────────────────
(require 'setup-ui)
(require 'setup-evil)
(require 'setup-completion)
(require 'setup-projects)
(require 'setup-terminal)
(require 'setup-git)
(require 'setup-lsp)
(require 'setup-languages)
(require 'setup-keys)

;; ── Sane Defaults ───────────────────────────────────────────
(setq-default
 tab-width 4
 indent-tabs-mode nil
 truncate-lines t
 fill-column 80)

(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(setq make-backup-files nil
      create-lockfiles nil
      auto-save-default nil)

;; Scrolling
(setq scroll-margin 15
      scroll-step 1
      scroll-conservatively 101
      scroll-preserve-screen-position t
      mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil)

;; Hooks
(add-hook 'after-init-hook #'global-auto-revert-mode)
(add-hook 'after-init-hook #'save-place-mode)
(add-hook 'after-init-hook #'savehist-mode)
(add-hook 'after-init-hook #'electric-pair-mode)

(provide 'init)
