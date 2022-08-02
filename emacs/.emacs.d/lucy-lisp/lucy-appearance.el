;; -*- lexical-binding: t -*-

(setq frame-title-format "%b")

(line-number-mode t)
(column-number-mode t)
(show-paren-mode t)

(setq display-time-24hr-format t
      display-time-default-load-average nil)

(display-time-mode t)

(setq shr-color-visible-luminance-min 80)

(use-package modus-themes
  :bind ("<f5>" . modus-themes-toggle)
  :defer nil
  :init
  (setq modus-themes-italic-constructs t
	modus-themes-bold-constructs t
	modus-themes-mixed-fonts t
	modus-themes-syntax '(green-strings yellow-comments)
	modus-themes-mode-line nil)
  (modus-themes-load-themes)
  :config
  (modus-themes-load-vivendi))

(use-package minions
  :config
  (setq minions-mode-line-lighter ";")
  (setq minions-prominent-modes
	(list 'defining-kbd-macro
	      'narrow-mode
	      'flymake-mode
	      'flycheck-mode
	      'projectile-mode))
  (minions-mode t))

(use-package fontaine
  :bind
  (("C-c f" . #'fontaine-set-preset)
   ("C-c F" . #'fontaine-set-face-font))
  :defer nil
  :config
  (setq x-underline-at-descent-line t)
  (setq fontaine-presets
	'((regular
	   :default-family "Iosevka Fixed"
	   :default-weight regular
	   :default-height 110
	   :variable-pitch-family "Noto Sans")
	  (presentation
	   :default-family "Iosevka Fixed"
	   :default-weight regular
	   :default-height 240
	   :variable-pitch-family "Noto Sans")))
  (fontaine-set-preset 'regular))

(provide 'lucy-appearance)
