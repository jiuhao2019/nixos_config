;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  dired文件夹浏览
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'dired)
(setq dired-dwim-target t)
(setq dired-listing-switches "-alGhv --group-directories-first")
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq dired-kill-when-opening-new-dired-buffer t)
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  okular打开pdf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 文献目录
(defvar my-papers-directory "/mnt/hgfs/chengzhao/datasheet/")
;; counsel-find-file 进入文献目录
(defun my-counsel-find-file-papers ()
  (interactive)
  (let ((default-directory (expand-file-name my-papers-directory)))
    (counsel-find-file)))
;; (global-set-key (kbd "C-c p") #'my-counsel-find-file-papers)
;; PDF 使用 Okular 打开，不进入 doc-view-mode
(defun my-find-file-use-okular (orig-fun filename &rest args)
  (if (and (stringp filename)
           (string-match-p "\\.pdf\\'" filename))
      (progn
        (start-process "okular" nil "okular" filename)
        nil)
    (apply orig-fun filename args)))
(advice-add 'find-file :around #'my-find-file-use-okular)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  ranger
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ranger)

(provide 'user-file-explorer)
