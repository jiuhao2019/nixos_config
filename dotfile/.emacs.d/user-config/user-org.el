;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                           org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'org)
;; capture目录
(defvar my-capture-directory "~/Downloads/note/capture-file/")
;; counsel-find-file 进入目录
(defun my-counsel-find-capture ()
  (interactive)
  (let ((default-directory (expand-file-name my-capture-directory)))
    (counsel-find-file)))

(setq org-directory "~/Downloads/note/org-files/")
(defun my/counsel-org-find ()
  (interactive)
  (counsel-find-file org-directory))

;; 如果不存在，则递归创建目录
(defconst my-org-dir "~/Downloads/note/")
(make-directory my-org-dir t)

(setq org-default-notes-file
      "~/Downloads/note/inbox.org")

(setq org-capture-templates
      '(
        ("t" "Todo" entry
         (file "~/Downloads/note/capture-file/tasks.org")
         "* TODO %?\n  %U\n")

        ("n" "Note" entry
         (file "~/Downloads/note/capture-file/inbox.org")
         "* %U %?\n")

        ("j" "Journal" entry
         (file+datetree "~/Downloads/note/capture-file/journal.org")
         "* %U\n%?\n")
        ))

;; 这个选项用于强制 TODO 依赖关系。
;; 当一个父任务包含未完成的子任务时，父任务不能被标记为 DONE。
(setq org-enforce-todo-dependencies t)

;;默认折叠所有标题
(setq org-startup-folded 'content)

;;将列表视为heading,也可以折叠
(setq org-cycle-include-plain-lists 'integrate)

;; | 设置     | 作用                                             |
;; | ------- | ------------------------------------------------ |
;; | `nil`   | 优先使用图片中的 `#+ATTR_ORG: :width` 属性；如果没有，则按图片原始大小显示 |
;; | `(300)` | 所有图片默认显示为 300 像素宽                                         |
;; | `300`   | 与 `(300)` 类似，但官方更推荐列表形式                                  |
;; | `t`     | 忽略 `#+ATTR_ORG`，始终使用图片原始大小                                |
(setq org-image-actual-width nil)

;;导出时保留原样换行
(setq org-export-preserve-breaks t)

;; 当 TODO 状态切换为 DONE 时，自动记录完成时间
(setq org-log-done nil)
(setq org-log-into-drawer nil)

;; 用 TAB 折叠/展开标题时，Drawer 会保持隐藏
(setq org-cycle-hide-drawer-startup t)

(setq org-html-validation-link nil)
(setq org-html-postamble nil)
(setq org-html-head-include-default-style nil)
(setq org-html-head-include-scripts nil)
(setq org-html-htmlize-output-type 'css)

;;对称加密时缓存密码，不用每次打开和保存都输入
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

(setq org-agenda-start-with-log-mode t)
(setq org-agenda-span 7)

(setq org-todo-keywords
      '((sequence "TODO(t@/!)" "PENDING(p@/!)" "|" "FINISHED(f@/!)" "NOTE(n@/!)" )))
(setq org-tag-alist
      '(("toc" . ?1)
	("work" . ?2)))

;; reduce space between header and tags
(setq org-tags-column 47)

(add-hook 'org-mode-hook (defun user/org-mode-setup()
			   (org-indent-mode)
			   (variable-pitch-mode 1)))
;; 禁用自动缩进
(setq org-startup-indented nil)

;; 设置折叠时保留的空行数量
(setq org-cycle-separator-lines 1)

;; 次级title不继承上级tag
(setq org-use-tag-inheritance nil)

;; 设置标题字体大小
(custom-set-faces
 '(org-level-1 ((t (:height 1.0  :weight medium))))
 '(org-level-2 ((t (:height 0.97 :weight medium))))
 '(org-level-3 ((t (:height 0.97 :weight medium))))
 '(org-level-4 ((t (:height 0.97 :weight medium))))
 '(org-level-5 ((t (:height 0.97 :weight medium)))))

;; 右边提示有括号，符号不用下划线
(set-face-attribute 'org-ellipsis nil :underline nil)

;; 所有 #+begin_src xxx 和 #+end_src 本身字符都会被隐藏
(defun my/org-hide-block-delimiters ()
  "Hide #+begin_xxx / #+end_xxx lines in org-mode."
  (font-lock-add-keywords
   nil
   '(("^#\\+\\(begin\\|end\\)_[a-zA-Z0-9_-]+.*" ;; 匹配 #+begin_xxx / #+end_xxx
      0 'org-hide prepend))
   'append))
(add-hook 'org-mode-hook #'my/org-hide-block-delimiters)

;; 打开org文件默认折叠所有内容
(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'find-file-hook (lambda () (org-overview)) nil t)))

;; agenda界面的移动键
(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "j") 'org-agenda-next-line)
  (define-key org-agenda-mode-map (kbd "k") 'org-agenda-previous-line)
  (define-key org-agenda-mode-map (kbd "h") 'org-agenda-earlier)
  (define-key org-agenda-mode-map (kbd "l") 'org-agenda-later))

;; 关闭emacs后关闭后台gpg-agent，清除缓存的密码
(add-hook 'kill-emacs-hook (defun personal-kill-gpg-agent ()
			     (shell-command "pkill gpg-agent")))

;; 含义：只有 _{...} / ^{...} 才会被当作上下标。
(setq org-use-sub-superscripts '{})

;; ;;;;;;;;;;;;;;;;;
;; 设置tag背景和前景色
;; ;;;;;;;;;;;;;;;;;
;; (custom-set-faces
;;  '(org-tag
;;    ((t (:foreground "white"
;; 		    :background "#5f87ff"
;; 		    :weight bold
;; 		    :height 0.8)))))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add frame borders and window dividers
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(modify-all-frames-parameters
 '((right-divider-width . 10)
   (internal-border-width . 10)))
(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))
(set-face-background 'fringe (face-attribute 'default :background))

(setq
 ;; Edit settings
 org-auto-align-tags nil
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-agenda-tags-column 0
 org-ellipsis "…")

;; 这样 C-c C-q 会进入 minibuffer 输入模式，而不是弹出选择界面
(setq org-use-fast-tag-selection nil)

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                           org-bullets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Org Agenda files
;; ============================================================
;; 只有这里的文件参与 Agenda
(setq org-agenda-files
      (append
       (directory-files-recursively "~/Downloads/note/org-files" "\\.org$")))
;(setq org-agenda-files
;      '("~/Downloads/note/org-files/inbox.org"
;        "~/Downloads/note/projects/project-a.org"
;        "~/Downloads/note/projects/project-b.org"))

;; 将标题refile到哪里去 -> 目标文件夹或文件
;;能refile到哪些级别标记去，这里设置能去的是最大第9层标题
;; ------------------------------------------------------------
;; Org Refile Targets
;;
;; 每次执行 Refile 时动态获取 .org 文件
;; 不会出现 *.org 作为目标
;; ------------------------------------------------------------
(setq org-refile-targets
      '((nil :maxlevel . 9)))

(defcustom my-org-directories
  '("~/Downloads/note/capture-file/"
    "~/Downloads/note/org-files/")
  "Directories containing Org files used as refile targets."
  :type '(repeat directory)
  :group 'org)

(defun my-org-refile-files ()
  "Return all Org files under `my-org-directories`."
  (delete-dups
   (apply #'append
          (mapcar
           (lambda (directory)
             (when (file-directory-p directory)
               (directory-files-recursively
                (expand-file-name directory)
                "\\.org\\'")))
           my-org-directories))))

(defun my-org-refile-targets ()
  "Return dynamic Org refile targets."
  (append
   '((nil :maxlevel . 9))
   (mapcar
    (lambda (file)
      (cons file '(:maxlevel . 9)))
    (my-org-refile-files))))

(defun my-org-refile-refresh-targets ()
  "Refresh Org refile targets."
  (interactive)
  (setq org-refile-targets
        (my-org-refile-targets)))

(my-org-refile-refresh-targets)

;; org-refile 时可以直接搜索完整路径，比逐级进入目录式选择快
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                      slice Image display
; 将插入的image显示为切割模式，以规避滚动时大图片跳闪
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'org-sliced-images)
(org-sliced-images-mode 1)


 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                 valign,含中文的表格能对齐
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'valign)
(setq valign-max-table-size 10000)  ;; 表格内容超过字节,自动跳过处理表格
(setq valign-fancy-bar t)         ;; 竖线全高，与文本对齐
(setq valign-ellipses nil)          ;; 省略号显示
(setq valign-enforce-alignment t)
(setq valign-resize-separator t)
(setq valign-autorefresh-rate 1.5)  ;; 刷新
(add-hook 'org-mode-hook #'valign-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             end of org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             org-super links
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'org-super-links)
(setq org-super-links-related-into-drawer t)
(setq org-super-links-backlink-drawer "BACKLINKS")

(require 'imenu-list)
(setq imenu-list-focus-after-activation t)
(setq imenu-list-auto-resize t)
(setq imenu-list-after-jump-hook nil)
(add-hook 'imenu-list-after-jump-hook #'recenter-top-bottom)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             end of org-node
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'user-org)
