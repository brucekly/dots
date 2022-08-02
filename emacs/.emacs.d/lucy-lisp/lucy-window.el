;; -*- lexical-binding: t -*-

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(setq window-combination-resize t)

(require 'windmove)
(windmove-default-keybindings '(ctrl))
(windmove-swap-states-default-keybindings '(ctrl shift))

(require 'winner)
(add-hook 'after-init-hook #'winner-mode)

(let ((map global-map))
  (define-key map (kbd "C-x C-p") #'previous-buffer)
  (define-key map (kbd "C-x C-n") #'next-buffer)
  (define-key map (kbd "C-x <left>") #'winner-undo)
  (define-key map (kbd "C-x <right>") #'winner-redo))

(use-package transpose-frame
  :bind
  ("C-x M-r" . rotate-frame-clockwise))

(provide 'lucy-window)
