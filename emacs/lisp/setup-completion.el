;;; setup-completion.el

(use-package vertico
  :hook (after-init . vertico-mode))

(use-package orderless
  :custom (completion-styles '(orderless basic)))

(use-package marginalia
  :hook (after-init . marginalia-mode))

(use-package consult
  :init
  ;; Use consult-xref for xref-show-xrefs-function
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

(use-package corfu
  :hook (after-init . global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 0)
  (corfu-auto-delay 0.0)
  (corfu-quit-at-boundary t)
  (corfu-preview-current nil))

;; Embark (Actions for everything)
(use-package embark
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(provide 'setup-completion)
