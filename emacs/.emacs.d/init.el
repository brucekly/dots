;; init.el
;; -*- lexical-binding: t; -*-

(require 'package)

(setq package-archives
      '(("elpa" . "https://elpa.gnu.org/packages/")
	("elpa-devel" . "https://elpa.gnu.org/devel/")
	("nongnu" . "https://elpa.nongnu.org/nongnu/")
	("melpa" . "https://melpa.org/packages/")))

(setq package-archive-priorities
      '(("elpa" . 2)
	("nongnu" . 1)))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq vc-follow-symlinks t)

(org-babel-load-file (expand-file-name "README.org" user-emacs-directory))
