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
(require 'user-md)
(require 'user-keybind)
(require 'user-font)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
