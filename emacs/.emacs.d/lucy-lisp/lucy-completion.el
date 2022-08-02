;; -*- lexical-binding: t -*-

(setq completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

(setq enable-recursive-minibuffers t)

(use-package vertico
  :config
  (vertico-mode t))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :config
  (marginalia-mode t))

(use-package consult
  :bind
  (("C-x r b" . consult-bookmark)
   ("C-x M-:" . consult-complex-command)
   ("C-x M-m" . consult-minor-mode-menu)
   ("C-x M-k" . consult-kmacro)
   ([remap goto-line] . consult-goto-line)
   ("M-K" . consult-keep-lines)
   ("M-F" . consult-focus-lines)
   ("M-s M-b" . consult-buffer)
   ("M-s M-e" . consult-flymake)
   ("M-s M-f" . consult-find)
   ("M-s M-g" . consult-grep)
   ("M-s M-i" . consult-imenu)
   ("M-s M-l" . consult-line)
   ("C-x r r" . consult-register))
  :init
  (advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)
  (setq xref-show-xrefs-function #'consult-xref
	xref-show-definitions-function #'consult-xref)
  (setq consult-project-function (lambda (_) (projectile-project-root))))

(use-package consult-dir
  :bind
  (("C-x C-d" . consult-dir)
   :map minibuffer-local-completion-map
   ("C-x C-d" . consult-dir)
   ("C-x C-j" . consult-dir-jump-file))
  :config
  (setq consult-dir-project-list-function #'consult-dir-projectile-dirs))

(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-separator ?\s)
  (corfu-quit-at-boundary nil)
  (corfu-quit-no-match nil)
  (corfu-preview-current nil)
  (corfu-echo-documentation nil)
  :init
  (global-corfu-mode)
  (setq tab-always-indent 'complete)
  :config
  (defun corfu-enable-always-in-minibuffer ()
    "Enable Corfu in the minibuffer if Vertico/Mct are not active."
    (unless (or (bound-and-true-p mct--active)
		(bound-and-true-p vertico--input))
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1))

(use-package corfu-doc
  :hook
  (corfu-mode . corfu-doc-mode))

(use-package cape
  :config
  (setq cape-dabbrev-min-length 3)
  (dolist (backend '(cape-symbol cape-keyword cape-file cape-dabbrev))
    (add-to-list 'completion-at-point-functions backend)))

(use-package pcmpl-args)

(provide 'lucy-completion)
