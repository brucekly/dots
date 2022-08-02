;; -*- lexical-binding: t; -*-

(use-package vc
  :config
  (setq vc-follow-symlinks t))

(use-package projectile
  :defer nil
  :bind
  ("C-c p" . projectile-command-map)
  :custom
  (projectile-mode-line-function
   (lambda ()
     (format " P[%s]" (projectile-project-name))))
  :config
  (projectile-mode t)
  (add-to-list 'projectile-globally-ignored-directories
	       "^\\./straight/$"))

(use-package magit
  :bind
  (("C-x g" . magit)
   ("C-x M-g" . magit-dispatch))
  :init
  (require 'magit-diff)
  (setq magit-diff-refine-hunk t)
  (require 'magit-repos))

(provide 'lucy-git)
