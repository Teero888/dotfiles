;;; early-init.el --- Startup performance & UI suppression -*- lexical-binding: t; -*-

;; ── UI Performance ──────────────────────────────────────────
(setq frame-inhibit-implied-resize t)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)

;; Background and fonts early to prevent flickering
(push '(background-color . "#282c34") default-frame-alist)
(push '(foreground-color . "#bbc2cf") default-frame-alist)
(push '(font . "JetBrainsMono NFM") default-frame-alist) ; Set font early

;; Disable some UI elements that are redundant
(setq menu-bar-mode nil
      tool-bar-mode nil
      scroll-bar-mode nil)

;; ── Package.el — disable it since we use straight.el ────────
(setq package-enable-at-startup nil)

;; ── GC tuning — defer garbage collection during startup ─────
;; Use a large threshold during startup, then lower it in emacs-startup-hook
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)
                  gc-cons-percentage 0.1)))

;; ── File handler — skip regexp checks during startup ────────
(defvar my/saved-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda () (setq file-name-handler-alist my/saved-file-name-handler-alist)))

;; ── Native comp — no popup warnings ─────────────────────────
(setq native-comp-async-report-warnings-errors nil)

;; ── Startup message suppression ─────────────────────────────
(setq inhibit-startup-screen t
      inhibit-startup-message t
      initial-scratch-message nil)

;; Faster loading
(setq load-prefer-newer t)
