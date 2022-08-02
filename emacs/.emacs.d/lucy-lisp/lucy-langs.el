;; -*- lexical-binding: t -*-

(use-package editorconfig
  :config
  (editorconfig-mode t))

(use-package cc-mode
  :hook (c-mode-common . lsp-deferred))

(use-package python
  :hook (python-mode . lsp-deferred)
  :config
  (setq python-indent-def-block-scale 1))

(use-package haskell-mode
  :hook (haskell-mode . interactive-haskell-mode)
  :init
  (require 'haskell-interactive-mode)
  (require 'haskell-process))

(use-package elisp-slime-nav
  :hook ((emacs-lisp-mode ielm-mode) . elisp-slime-nav-mode))

(use-package slime
  :config
  (require 'slime-autoloads)
  (slime-setup '(slime-fancy))
  (setq slime-net-coding-system 'utf-8-unix)
  (setq inferior-lisp-program "sbcl"))

(provide 'lucy-langs)
