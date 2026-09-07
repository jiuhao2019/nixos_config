;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;auto complete
;; ivy
(require 'ivy)
(setq ivy-use-virtual-buffers t
      ivy-count-format "(%d/%d) "
      enable-recursive-minibuffers t)
(setq ivy-initial-inputs-alist nil)
(ivy-mode 1)
;; ivy 快捷键
(define-key ivy-minibuffer-map
            (kbd "TAB")
            #'ivy-alt-done)
;; ivy 排序方式
(setq ivy-re-builders-alist
      '((t . ivy--regex-ignore-order)))
;; Ivy-rich
(require 'ivy-rich)
(ivy-rich-mode 1)

;; Swiper
(require 'swiper)
(global-set-key (kbd "C-s") #'swiper)

;; Counsel
(require 'counsel)
(setq counsel-M-x-transformer #'identity)
(counsel-mode 1)
(global-set-key (kbd "M-x") #'counsel-M-x)
(global-set-key (kbd "C-x C-f") #'counsel-find-file)
(global-set-key (kbd "C-x b") #'counsel-switch-buffer)
(global-set-key (kbd "C-h f") #'counsel-describe-function)
(global-set-key (kbd "C-h v") #'counsel-describe-variable)

;; company 自动补全
(require 'company)
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)
;; 全局开启
(global-company-mode 1)
;; 快捷键
(with-eval-after-load 'company
  ;; 补全选择
  (define-key company-active-map (kbd "C-n")
              #'company-select-next)
  (define-key company-active-map (kbd "C-p")
              #'company-select-previous)

  (define-key company-active-map (kbd "M-n")
              #'company-select-next)
  (define-key company-active-map (kbd "M-p")
              #'company-select-previous)
  ;; Tab确认
  (define-key company-active-map (kbd "TAB")
              #'company-complete-selection)
  (define-key company-active-map (kbd "<tab>")
              #'company-complete-selection))
;; 候选排序增强（如果安装了 company-prescient）
(require 'company-prescient nil t)
(company-prescient-mode 1)
;; UI增强（如果安装了 company-box）
(require 'company-box)
(add-hook 'company-mode-hook #'company-box-mode)

;;;;;;;;;;;;;;;;;;;;;;end of auto complete


(provide 'user-autocomplete)
