;; -*- lexical-binding: t -*-

(use-package olivetti
  :bind ("C-c o" . olivetti-mode))

(use-package logos
  :bind
  (([remap narrow-to-region] . #'logos-narrow-dwim)
   ([remap forward-page] . #'logos-forward-page-dwim)
   ([remap backward-page] . #'logos-backward-page-dwim)
   ("C-c l" . #'logos-focus-mode))
  :config
  (setq logos-outlines-are-pages t)
  (setq logos-outline-regexp-alist
	`((emacs-lisp-mode . "^;;;+ ")
	  (org-mode . "^\\*+ +")
	  (markdown-mode . "^\\#+ +")
	  (t . ,(or outline-regexp logos--page-delimiter))))
  (setq-default logos-hide-mode-line t
		logos-hide-buffer-boundaries t
		logos-olivetti t))

(provide 'lucy-writing)
