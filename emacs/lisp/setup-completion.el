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
  (corfu-preview-current nil)
  (corfu-preselect 'first)      ; Always preselect the first candidate
  (corfu-on-at-pt-timer-delay 0.0) ; Smoothness for immediate display
  :config
  ;; Enable the Echo extension
  (corfu-echo-mode 1)
  ;; This allows Corfu to trigger even when deleting characters
  (with-eval-after-load 'corfu
    (general-define-key
     :keymaps 'corfu-map
     "C-j" #'corfu-next
     "C-k" #'corfu-previous))
  )

;; Embark (Actions for everything)
(use-package embark
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(provide 'setup-completion)
