;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                             lisp-path
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ((base-dir (expand-file-name "lisp" user-emacs-directory)))
  (when (file-directory-p base-dir)
    (add-to-list 'load-path base-dir)
    (dolist (dir (directory-files base-dir t "^[^.]+"))
      (when (file-directory-p dir)
        (add-to-list 'load-path dir)))))

(let ((base-dir (expand-file-name "user-config" user-emacs-directory)))
  (when (file-directory-p base-dir)
    (add-to-list 'load-path base-dir)
    (dolist (dir (directory-files base-dir t "^[^.]+"))
      (when (file-directory-p dir)
        (add-to-list 'load-path dir)))))


(require 'user-base)
(require 'user-evil)
(require 'user-tab)
(require 'user-motion)
(require 'user-ui)
(require 'user-file-explorer)
(require 'user-autocomplete)
(require 'user-org)
(require 'user-keybind)
(require 'user-font)


(custom-set-variables)
(custom-set-faces
 '(tab-bar
   ((t (:background "#292929"
        :foreground "#787878"
        :box nil))))
 '(tab-bar-tab
   ((t (:background "#6b83ac"
        :foreground "#292929"
        :weight bold
        :box nil))))
 '(tab-bar-tab-inactive
   ((t (:background "#3a3a3a"
        :foreground "#787878"
        :weight normal
        :box nil)))))
