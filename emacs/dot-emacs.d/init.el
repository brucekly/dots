(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-splash-screen t)

(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'list-buffers 'ibuffer)

;; Mac-specific changes
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super)
  (setq ns-function-modifier 'hyper)
  (setq mac-pass-command-to-system nil)
  (menu-bar-mode t))

(when window-system
  (setq frame-title-format "%b"
	use-dialog-box nil)
  (tooltip-mode -1)
  (blink-cursor-mode -1))

(setq ring-bell-function (lambda () nil))

(setq delete-by-moving-to-trash t)

(setq disabled-command-function nil)

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups" user-emacs-directory))))

(setq frame-resize-pixelwise t)

(show-paren-mode t)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (with-temp-buffer (write-file custom-file)))
(load custom-file)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(set-frame-font "Iosevka Fixed 12")

(use-package color-theme-sanityinc-tomorrow
  :config
  (load-theme 'sanityinc-tomorrow-night t))

(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis)
(show-paren-mode t)

(blink-cursor-mode 0)

(setq-default indicate-empty-lines t)

(global-hl-line-mode t)

(line-number-mode t)
(column-number-mode t)

(require 'diminish)
(eval-after-load "elisp-slime-nav" '(diminish #'elisp-slime-nav-mode))
(eval-after-load "hindent" '(diminish #'hindent-mode))
(eval-after-load "smartparens" '(diminish #'smartparens-mode))
(eval-after-load "company" '(diminish #'company-mode))
(eval-after-load "whitespace-cleanup-mode" '(diminish #'whitespace-cleanup-mode))
(eval-after-load "subword" '(diminish #'subword-mode))

(setq-default word-wrap t)

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (display-line-numbers-mode t)
        (goto-line (read-number "Goto line: ")))
    (display-line-numbers-mode -1)))

(global-set-key [remap goto-line] #'goto-line-with-feedback)

(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))

(global-set-key (kbd "C-<backspace>") #'switch-to-last-buffer)

(defun open-config ()
  (interactive)
  (find-file
   (expand-file-name
    (concat user-emacs-directory "init.el"))))

(global-set-key (kbd "C-c i") #'open-config)

(defun eval-and-replace ()
  "Replace the preceding sexp with its value"
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
	     (current-buffer))
    (error (message "Invalid expression")
	   (insert (current-kill 0)))))

(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)

(global-set-key (kbd "C-c e") 'eval-and-replace)

(defadvice kill-line (before kill-line-autoreindent activate)
  (when (and (eolp) (not (bolp)))
    (save-excursion
      (forward-char 1)
      (just-one-space 1))))

(use-package multiple-cursors
  :bind
  (("C-S-c C-S-c" . 'mc/edit-lines)
   ("C->" . 'mc/mark-next-like-this)
   ("C-<" . 'mc/mark-previous-like-this)
   ("C-c C-<" . 'mc/mark-all-like-this)))

(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

(use-package company
  :custom
  (company-tooltip-align-annotations t)
  :init
  (global-company-mode t))

(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package vertico
  :init
  (vertico-mode t))

(use-package vertico-directory
  :ensure nil
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word)))

(use-package marginalia
  :init
  (marginalia-mode t))

(use-package org
  :bind (("C-c a" . org-agenda)
	 ("C-c c" . org-capture))
  :config
  (require 'org-tempo)
  (setq calendar-week-start-day 1)
  (setq org-agenda-start-on-weekday 1)
  (setq org-adapt-indentation nil)
  (add-to-list 'org-agenda-files
	       (expand-file-name "~/Dropbox/org/index.org"))
  (add-to-list 'org-structure-template-alist
	       '("el" . "src emacs-lisp"))
  (set-face-attribute 'org-checkbox nil
		      :box nil))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  (when (daemonp)
    (exec-path-from-shell-initialize)))

(use-package dumb-jump
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (sp-use-paredit-bindings)
  (smartparens-global-mode))

(use-package magit
  :bind (("C-x g" . magit)
	 ("C-x M-g" . magit-dispatch)))

(use-package projectile
  :bind (("C-c p" . projectile-command-map)
	 ("s-p" . projectile-command-map))
  :init
  (projectile-mode t))

(use-package tex
  :ensure auctex
  :hook (TeX-mode . LaTeX-math-mode)
  :config
  (require 'font-latex)
  (set-face-attribute 'font-latex-script-char-face nil
		      :foreground nil)
  (setq font-latex-fontify-script nil
	font-latex-fontify-sectioning 'color
	TeX-auto-save t
	TeX-parse-self t
	TeX-save-query nil
	TeX-view-program-selection '((output-pdf "PDF Viewer"))
	TeX-view-program-list
	'(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
  (setq-default TeX-master nil
		TeX-source-correlate-mode t
		TeX-source-correlate-start-server t))

(setq python-shell-interpreter "python3")

(use-package company-jedi
  :init
  (add-to-list 'company-backends 'company-jedi)
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t))

(use-package haskell-mode
  :hook (haskell-mode . interactive-haskell-mode)
  :bind (:map haskell-mode-map
	      ("C-c h" . haskell-hoogle))
  :init
  (setq haskell-hoogle-command "hoogle")
  (require 'haskell-interactive-mode)
  (require 'haskell-process))

(use-package hindent
  :hook (haskell-mode . hindent-mode))

(use-package elisp-slime-nav
  :hook ((emacs-lisp-mode ielm-mode) . elisp-slime-nav-mode))

(use-package slime
  :config
  (require 'slime-autoloads)
  (slime-setup '(slime-fancy slime-company))
  (setq slime-net-coding-system 'utf-8-unix)
  (setq inferior-lisp-program "sbcl"))

(use-package slime-company
  :after (slime company)
  :config
  (setq slime-company-completion 'fuzzy
        slime-company-after-completion 'slime-company-just-one-space))

(use-package restclient)

(use-package company-restclient
  :config
  (add-to-list 'company-backends 'company-restclient))
