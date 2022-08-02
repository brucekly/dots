;; -*- lexical-binding: t -*-

(setq user-full-name "Lucy McPhail"
      user-mail-address "lucy.mcphail.p@gmail.com")

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (with-temp-buffer (write-file custom-file)))
(load custom-file)

(add-to-list 'load-path (locate-user-emacs-file "lucy-lisp"))

(when (equal system-type 'darwin) (require 'lucy-mac))

(require 'lucy-essentials)
(require 'lucy-appearance)
(require 'lucy-completion)
(require 'lucy-window)
(require 'lucy-git)
(require 'lucy-mail)
(require 'lucy-org)
(require 'lucy-tex)
(require 'lucy-lsp)
(require 'lucy-langs)
(require 'lucy-writing)
