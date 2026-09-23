;; -*- lexical-binding: t; -*-

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  theme
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(load-theme 'wombat t) ;;emacs自带的
;;(require 'suscolors-theme)
;;(load-theme 'suscolors t)
;;
;; doom-theme
;; (require 'doom-themes)
;; (setq doom-themes-enable-bold t
;;       doom-themes-enable-italic t)
;; (load-theme 'doom-sourcerer t)

;; foggy night theme
(require 'foggy-night-theme)
(load-theme 'foggy-night t)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  diy的modeline
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default mode-line-format
	      '((:eval (if buffer-file-name (abbreviate-file-name buffer-file-name) "%b"))
		" "
                (:eval (if (buffer-modified-p) "[+]" " "))

                ;;mode-line-buffer-identification
                ;; 动态生成空格，按窗口宽度的 1/5 计算
                (:eval (let ((space-width (/ (window-width) 3))) (make-string space-width ? )))
                mode-line-position
                mode-line-end-spaces))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  激活/非激活tab颜色
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-face-attribute 'tab-bar-tab nil
                    :foreground "#8f8f8f"
                    :background "#4b4b4b"
                    :weight 'bold)
(set-face-attribute 'tab-bar-tab-inactive nil
                    :foreground "#6d6d6d"
                    :background "#292929"
                    :weight 'normal)

(provide 'user-ui)
