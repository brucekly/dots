;; -*- lexical-binding: t -*-

(use-package org
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture))
  :config
  (require 'org-tempo)
  (setq calendar-week-start-day 1
	org-agenda-start-on-weekday 1
	org-agenda-files "~/org/agenda-files.txt"
	org-enforce-todo-dependencies t
	org-enforce-todo-checkbox-dependencies t)
  (add-to-list 'org-structure-template-alist
	       '("el" . "src emacs-lisp"))

(setq org-refile-targets org-agenda-files
      org-refile-use-outline-path 'file
      org-refile-allow-creating-parent-nodes t
      org-outline-path-complete-in-steps nil)

(setq org-capture-templates
      '(("t" "TODO entry" entry
	 (file+headline "~/org/personal.org" "Inbox")
	 (file "~/org/tpl-todo.txt"))
	("m" "Mail" entry
	 (file+headline "personal.org" "Inbox")
	 (file "~/org/tpl-mail.txt")))))

(provide 'lucy-org)
