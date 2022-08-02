;; -*- lexical-binding: t -*-

(use-package flycheck)

(use-package yasnippet
  :config
  (yas-global-mode t))

(use-package lsp-mode
  :after (flycheck yasnippet)
  :init
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024))
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-modeline-code-actions-segments '(count))
  (setq lsp-modeline-diagnostics-enable nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  :commands lsp)

(provide 'lucy-lsp)
