;; -*- lexical-binding: t; -*-

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;                                                           光标跳转
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (require 'avy)

  ;; 打关键字时给匹配结果加一个灰背景，更醒目
  (setq avy-background t)

  ;; 搜索所有 window，即所有「可视范围」
  (setq avy-all-windows t)

  ;; 「关键字输入完毕」信号的触发时间
  (setq avy-timeout-seconds 0.3)

 (require 'evil-avy)
 (require 'ace-pinyin)
 (require 'pinyinlib)
 (ace-pinyin-global-mode +1)


(provide 'user-motion)
