;; -*- lexical-binding: t; -*-

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;                                                           evil
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (require 'compat)
  (require 'cl-lib)
  (require 'queue)
  (require 'goto-chg)
  (require 'evil)
  (require 'annalist)
  (require 'evil-collection)
  (require 'evil-surround)
  (require 'spinner)
  (require 'dash)
  (require 's)
  (require 'f)

  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

  ;; ----- Setting cursor colors
  (setq evil-emacs-state-cursor    '("#649bce" box))
  (setq evil-normal-state-cursor   '("#d9a871" box))
  (setq evil-operator-state-cursor '("#ebcb8b" hollow))
  (setq evil-visual-state-cursor   '("#677691" box))
  (setq evil-insert-state-cursor   '("#eb998b" (bar . 2)))
  (setq evil-replace-state-cursor  '("#eb998b" hbar))
  (setq evil-motion-state-cursor   '("#ad8beb" box))

  (evil-mode)
  (setq evil-want-C-i-jump nil)
  (setq evil-search-wrap nil);; 禁用搜索结果循环
  (evil-collection-init)
  (global-evil-surround-mode)

(provide 'user-evil )
