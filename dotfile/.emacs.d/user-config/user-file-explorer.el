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
(add-hook 'dired-mode-hook
          (lambda ()
            (display-line-numbers-mode 1)
            (setq-local display-line-numbers 'relative)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  okular打开pdf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 文献目录
(setq my-papers-directory
  (expand-file-name "/mnt/hgfs/chengzhao/datasheet/"))
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  recent file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq my-recent-files-file
  (expand-file-name "~/Downloads/emacs-temp-data/emacs-recent-files"))
(make-directory
 (file-name-directory my-recent-files-file)
 t)
(defvar my-recent-files-max 100
  "Maximum number of recent files to keep.")
(defvar my-recent-files nil)
(defun my-recent-files-load ()
  "Load recent files from disk."
  (when (file-exists-p my-recent-files-file)
    (with-temp-buffer
      (insert-file-contents my-recent-files-file)
      (setq my-recent-files
            (condition-case nil
                (read (current-buffer))
              (error nil))))))
(defun my-recent-files-save ()
  "Save recent files to disk."
  (make-directory (file-name-directory my-recent-files-file) t)
  (with-temp-file my-recent-files-file
    (prin1 my-recent-files (current-buffer))))
(defun my-recent-files-add ()
  "Add current file to recent files."
  (when-let ((file (buffer-file-name)))
    (setq file (file-truename file))
    (setq my-recent-files
          (cons file (delete file my-recent-files)))
    (when (> (length my-recent-files) my-recent-files-max)
      (setcdr (nthcdr (1- my-recent-files-max)
                      my-recent-files) nil))
    (my-recent-files-save)))
(defun my-recent-files-open ()
  "Open a recent file."
  (interactive)
  (my-recent-files-load)
  (let ((files (seq-filter #'file-exists-p my-recent-files)))
    (when-let ((file (completing-read "Recent file: " files nil t)))
      (find-file file))))
(my-recent-files-load)
(add-hook 'find-file-hook #'my-recent-files-add)
;;(global-set-key (kbd "C-x C-r") #'my-recent-files-open)
(defun my-recent-files-clear ()
  "Clear all recent files."
  (interactive)
  (setq my-recent-files nil)
  (my-recent-files-save)
  (message "Recent files cleared"))
(defun my-recent-files-remove-current ()
  "Remove current file from recent files."
  (interactive)
  (when-let ((file (buffer-file-name)))
    (setq file (file-truename file))
    (setq my-recent-files (delete file my-recent-files))
    (my-recent-files-save)
    (message "Removed: %s" file)))
;;(global-set-key (kbd "C-x C-R") #'my-recent-files-clear)


(provide 'user-file-explorer)
