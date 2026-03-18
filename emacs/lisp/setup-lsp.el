;;; setup-lsp.el --- Tree-sitter and LSP configuration -*- lexical-binding: t; -*-

(use-package treesit
  :straight nil
  :demand t
  :config
  (setq treesit-font-lock-level 4)
  (setq treesit-language-source-alist
        '((bash "https://github.com/tree-sitter/tree-sitter-bash")
          (c "https://github.com/tree-sitter/tree-sitter-c")
          (cmake "https://github.com/uyha/tree-sitter-cmake")
          (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
          (css "https://github.com/tree-sitter/tree-sitter-css")
          (elisp "https://github.com/Wilfred/tree-sitter-elisp")
          (go "https://github.com/tree-sitter/tree-sitter-go")
          (html "https://github.com/tree-sitter/tree-sitter-html")
          (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
          (json "https://github.com/tree-sitter/tree-sitter-json")
          (make "https://github.com/alemuller/tree-sitter-make")
          (markdown "https://github.com/ikatyang/tree-sitter-markdown")
          (python "https://github.com/tree-sitter/tree-sitter-python")
          (rust "https://github.com/tree-sitter/tree-sitter-rust")
          (toml "https://github.com/ikatyang/tree-sitter-toml")
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
          (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
          (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

  (defun my/install-missing-grammars ()
    (interactive)
    (require 'cl-lib)
    (dolist (lang treesit-language-source-alist)
      (unless (treesit-language-available-p (car lang))
        (message "Installing tree-sitter grammar for %s..." (car lang))
        (cl-letf (((symbol-function 'y-or-n-p) (lambda (&rest _args) t)))
          (treesit-install-language-grammar (car lang))))))

  (run-with-idle-timer 2 nil #'my/install-missing-grammars))

(use-package eglot
  :straight nil
  :hook ((c-ts-mode c++-ts-mode rust-ts-mode python-ts-mode typescript-ts-mode js-ts-mode html-mode cmake-ts-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(python-ts-mode . ("pyright-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs '(typescript-ts-mode . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(js-ts-mode . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(html-mode . ("vscode-html-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(cmake-ts-mode . ("cmake-language-server")))
  :custom
  (eglot-autoshutdown t)
  (eglot-send-changes-idle-time 0.1))

(use-package consult-eglot :after (consult eglot))

(provide 'setup-lsp)
