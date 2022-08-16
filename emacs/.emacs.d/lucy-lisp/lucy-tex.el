;; -*- lexical-binding: t -*-

(use-package auctex
  :hook
  ((LaTeX-mode . LaTeX-math-mode)
   (LaTeX-mode . reftex-mode)
   (LaTeX-mode . prettify-symbols-mode)
   (LaTeX-mode . eglot-ensure))
  :init
  (require 'tex)
  (setq TeX-parse-self t
	TeX-save-query nil
	TeX-view-program-selection '((output-pdf "PDF Tools"))
	TeX-master t
	TeX-source-correlate-mode t
	TeX-source-correlate-start-server t)
  (add-hook 'TeX-after-compilation-finished-functions
	    #'TeX-revert-document-buffer)
  ;; remove built-in `chktex' flymake backend
  (defun disable-latex-flymake ()
    (remove-hook 'flymake-diagnostic-functions #'LaTeX-flymake))
  (advice-add #'TeX-latex-mode :after #'disable-latex-flymake))

(use-package pdf-tools
  :config
  (pdf-loader-install))

(use-package laas
  :hook (LaTeX-mode . laas-mode))

(provide 'lucy-tex)
