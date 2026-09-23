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
(custom-set-faces)
