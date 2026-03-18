;;; setup-languages.el --- Language specific configuration -*- lexical-binding: t; -*-

;; Folding (za, zo, etc.)
(use-package hideshow
  :hook (prog-mode . hs-minor-mode))

(setq major-mode-remap-alist
      '((c-mode . c-ts-mode)
        (c++-mode . c++-ts-mode)
        (rust-mode . rust-ts-mode)
        (python-mode . python-ts-mode)
        (javascript-mode . js-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (cmake-mode . cmake-ts-mode)))

(use-package rust-mode :mode "\\.rs\\'")
(use-package typescript-mode :mode "\\.ts\\'")
(use-package cmake-mode 
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'")
  :config (use-package cmake-font-lock :after cmake-mode :hook (cmake-mode . cmake-font-lock-activate)))

(use-package web-mode 
  :mode ("\\.html?\\'" "\\.js\\'")
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-code-indent-offset 2))

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "pandoc"))

(defun my/markdown-preview-eww ()
  "Preview markdown in the built-in EWW browser."
  (interactive)
  (let ((tmp-file (make-temp-file "markdown-preview" nil ".html")))
    (shell-command-to-string (format "pandoc %s -o %s" (buffer-file-name) tmp-file))
    (eww-open-file tmp-file)))

(provide 'setup-languages)
