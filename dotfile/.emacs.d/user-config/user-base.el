;; -*- lexical-binding: t; -*-

(blink-cursor-mode -1)
;; blink 3次即停止,设置0，则一直闪烁
(setq blink-cursor-blinks 1)
;; 闪烁间隔
(setq blink-cursor-interval 0.3)
;; 输入后多久开始闪
(setq blink-cursor-delay 0.2)
;;disables help in a pop-up window
(tooltip-mode -1)

;; fringe 是窗口左右两侧的小区域
;; 用于显示：行继续箭头,git diff标记等
(fringe-mode '(30 . 30));; 左右分别设置30

;;显示列号
(column-number-mode t)

;;不在modeline显示光标处代码相关信息
(global-eldoc-mode -1)

;; 会隐藏大量message输出，不建议全局开启
;; 但实际发现没有太大区别
(setq inhibit-message t)

;; 不显示相关message
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-message "")

(setq-default indicate-buffer-boundaries 'none)   ;; 不显示缓冲区边界信息
(setq-default indicate-empty-lines nil)           ;; 不显示空行指示
(setq-default echo-keystrokes 0)                  ;; 不显示键盘输入的回显
(setq echo-area-message-timeout 0)                ;; 禁止显示回显消息
(setq minibuffer-message-timeout 0)               ;; 禁止 minibuffer 中的提示消息
(setq ring-bell-function 'ignore)                 ;; 禁用铃声和提示
(setq imagemagick-enabled-types t)
(setq debug-on-warning nil)
;; 启用全局显示行号
;;(global-display-line-numbers-mode 1)
;; 设置显示相对行号
(setq display-line-numbers-type 'visual)
(setq scroll-preserve-screen-position nil)
(setopt
 use-file-dialog nil
 use-dialog-box nil
 use-short-answers t
 read-process-output-max #x100
 create-lockfiles nil
 recenter-redisplay nil
 next-screen-context-lines 1
 inhibit-compacting-font-caches t
 frame-resize-pixelwise t
 inhibit-quit nil
 fast-but-imprecise-scrolling nil
 auto-save-list-file-name nil
 history-length 1000
 history-delete-duplicates t
 bidi-display-reordering nil
 read-buffer-completion-ignore-case t
 completion-ignore-case t
 delete-by-moving-to-trash t
 visible-bell t
 minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt)
 redisplay-skip-fontification-on-input t
 cursor-in-non-selected-windows nil)
(setq load-prefer-newer t)

;; 这两个选项可让光标在顶或底移动后不自动跳屏中间
(setq scroll-step 1)  ; 设置每次滚动的行数
(setq scroll-conservatively 10000)  ; 更平滑的滚动

(setq bookmark-save-flag nil);;自动保存bookmark，内置插件

(add-hook 'prog-mode-hook #'hs-minor-mode);;折叠块(注释，大括号)，内置插件
(add-hook 'org-mode-hook
          (lambda ()
            (setq show-trailing-whitespace t)))
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq show-trailing-whitespace t)))
;; 记住文件离开时光标位置
(setq save-place-file "~/.emacs.d/save_cursor_place")
(save-place-mode 1)

;; 指定自动保存文件的文件名，也可以不用指定
(setq prescient-save-file
      (expand-file-name "var/prescient-save.el"
                        user-emacs-directory))
;; 作用：
;; Emacs 退出时
;; 检查：
;; ~/.emacs.d/var/prescient-save.el
;; 若缺少 lexical-binding
;; 自动加到文件头
;; 防止下次 native-comp warning
(defun my-fix-prescient-lexical-binding ()
  (let ((file (expand-file-name
               "~/.emacs.d/var/prescient-save.el")))
    (when (file-exists-p file)
      (with-temp-buffer
        (insert-file-contents file)

        (goto-char (point-min))

        (unless (re-search-forward "lexical-binding:" 3 t)
          (goto-char (point-min))
          (insert ";; -*- lexical-binding: t -*-\n\n")
          (write-region nil nil file nil 'silent))))))
(add-hook 'kill-emacs-hook
          #'my-fix-prescient-lexical-binding)


;; 开启自动备份和保存
(setq make-backup-files nil               ;; backup of a file the first time it is saved.
      backup-by-copying nil             ;; 默认重命名方式备份较复制方式更好
      version-control nil                 ;; version numbers for backup files
      delete-old-versions t             ;; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 0               ;; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 0               ;; NEWEST VERSIONS TO KEEP WHEN A NEW NUMBERED BACKUP IS MADE (DEfault: 2)
      auto-save-default t               ;; auto-save every buffer that visits a file
      auto-save-timeout 30              ;; 每x秒自动保存
      auto-save-interval 30)            ;; 每输入x个字符自动保存

;; Disable Bidirectional Text Scanning
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; Skip Fontification During Input
(setq redisplay-skip-fontification-on-input t)

;; Don’t Render Cursors in Non-Focused Windows
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; Save the Clipboard Before Killing
(setq save-interprogram-paste-before-kill t)

;;No Duplicates in the Kill Ring
(setq kill-do-not-save-duplicates t)

;; Persist the Kill Ring Across Sessions
(setq savehist-additional-variables
      '(search-ring regexp-search-ring kill-ring))

;; Auto-Select Help Windows
(setq help-window-select t)

;; 让PROPERTIES等字符本身显示颜色同背景，以便隐藏
(with-eval-after-load 'org
  (custom-theme-set-faces
   'user
   '(org-drawer ((t (:foreground "#2e3440"))))))

(defun my/clean-buffers ()
  (interactive)
  (dolist (buf (buffer-list))
    (let ((name (buffer-name buf)))
      (unless (member name '("*scratch*" "*Messages*"))
        (kill-buffer buf)))))

(provide 'user-base)
