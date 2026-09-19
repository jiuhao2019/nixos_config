;; -*- lexical-binding: t; -*-

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;                                                           vim-tab-bar
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;  The default keybindings for Emacs’s built-in tab-bar are as follows:
  ;;
  ;;  C-x t 2: Create a new tab (tab-bar-new-tab / tab-new)
  ;;  C-x t b RET: Switch to a buffer in a new tab (switch-to-buffer-other-tab)
  ;;  C-x t f RET: Open a file in a new tab (find-file-other-tab)
  ;;  C-x t d RET: Open Dired in a new tab (dired-other-tab)
  ;;  C-x t t C-x b RET: Use the tab-bar command prefix,
  ;;  then run any buffer-related command (e.g., other-tab-prefix, followed by switch-to-buffer)
  ;;  C-x t o or C-TAB: Switch to the next tab (tab-bar-switch-to-next-tab)
  ;;  S-C-TAB: Switch to the previous tab (tab-bar-switch-to-prev-tab)
  ;;  C-x t RET: Switch to a named tab with completion (tab-switch)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (require 'vim-tab-bar)
  (add-hook 'after-init-hook #'vim-tab-bar-mode)

(provide 'user-tab)
