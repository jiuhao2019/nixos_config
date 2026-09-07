;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 which-key
;;在 which-key popup 里：
;;
;;C-h k / C-h b：看 keymap（备用）
;;q：退出菜单
;;C-g：退出菜单
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'which-key)
(setq which-key-idle-delay 0.5)
(setq which-key-separator " → ")
(setq which-key-maximum-display-columns 4)
(setq which-key-max-description-length 40)
(setq which-key-sort-order #'which-key-prefix-then-key-order)

(which-key-mode)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 hydra
;; :exit
;; The :exit key is inherited by every head (they can override it) and influences what will happen after executing head's command:

;; :exit nil (the default) means that the hydra state will continue - you'll still see the hint and be able to use short bindings.
;; :exit t means that the hydra state will stop.
;; :foreign-keys
;; The :foreign-keys key belongs to the body and decides what to do when a key is pressed that doesn't belong to any head:

;; :foreign-keys nil (the default) means that the hydra state will stop and the foreign key will do whatever it was supposed to do if there was no hydra state.
;; :foreign-keys warn will not stop the hydra state, but instead will issue a warning without running the foreign key.
;; :foreign-keys run will not stop the hydra state, and try to run the foreign key.
;; :color
;; The :color key is a shortcut. It aggregates :exit and :foreign-keys key in the following way:

;; | color    | toggle                     |
;; |----------+----------------------------|
;; | red      |                            |
;; | blue     | :exit t                    |
;; | amaranth | :foreign-keys warn         |
;; | teal     | :foreign-keys warn :exit t |
;; | pink     | :foreign-keys run          |
;; It's also a trick to make you instantly aware of the current hydra keys that you're about to press: the keys will be highlighted with the appropriate color.
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'hydra)

(defhydra hydra-org-agenda (:color blue :hint nil )
  "
☞ org-todo
[_l_]list [_s_]toggle-state [_a_]archive
"
  ("l"   org-todo-list )
  ("s"   org-todo )
  ("a"   org-archive-subtree )
  ("q"   keyboard-quit :color blue))

(defhydra hydra-org-table (:color blue :hint nil )
  "
☞ org-table
[_c_]create [_o_]export_table
  "
  ("c"   org-table-create )
  ("o"   org-table-export-to-spreadsheet )
  ("q"   keyboard-quit :color blue))

(defhydra hydra-org-link (:color blue :hint nil )
  "
☞ org-link
[_i_]insert-inline [_o_]open [_t_]toggle-display  [_I_]insert-at-title
[_d_]delete
  "
  ( "o"   org-open-at-point )
  ( "t"   org-toggle-link-display )
  ( "i"   org-super-links-quick-insert-inline-link)
  ( "I"   org-super-links-link)
  ( "d"   org-super-links-delete-link)
  ( "q"   keyboard-quit :color blue))
;; i 当前光标位置插入link，且被插入的title也会增加此位置所属title的link
;; I 当前title插入link，且被插入的title也会增加此title的link

(defhydra hydra-org-block (:color blue :hint nil )
  "
☞ org-block
[_i_]insert
  "
  ("i"   org-insert-structure-template)
  ("q"   keyboard-quit :color blue))

(defhydra hydra-org-note (:color blue :hint nil )
  "
☞ org-note
[_f_]find-note [_p_]find-pdf
  "
  ("f"   my/counsel-org-find)
  ("p"   my-counsel-find-file-papers)
  ("q"   keyboard-quit :color blue))

(defhydra hydra-org-capture (:color blue :hint nil )
  "
☞ org-capture
[_c_]capture [_r_]refile [_o_]open-capture-folder
  "
  ("c"   counsel-org-capture)
  ("r"   org-refile)
  ("o"   my-counsel-find-capture)
  ("q"   keyboard-quit :color blue))

(defhydra hydra-org-tag (:color blue :hint nil )
  "
☞ org-tag
[_l_]list [_e_]edit
  "
  ( "l"   org-tags-view  )
  ( "e"   org-set-tags-command  )
  ( "q"   keyboard-quit :color blue))

(defhydra hydra-org-misc (:color blue :hint nil )
  "
☞ org-misc
[_i_]toggle-inline-img  [_o_]export-html [_n_]narrow-to-subtree
[_l_]imenu-list
  "
  ( "i"   org-toggle-inline-images )
  ( "o"   org-html-export-to-html )
  ( "n"   org-toggle-narrow-to-subtree )
  ( "l"   imenu-list-smart-toggle )
  ( "q"   keyboard-quit :color blue))

(defhydra hydra-org (:color blue :hint nil )
  "
☞ org
[_a_]+agenda [_b_]+block [_l_]+link [_n_]+note
[_t_]+tag    [_e_]+table [_x_]+misc [_c_]+capture
  "
  ( "a"   hydra-org-agenda/body)
  ( "b"   hydra-org-block/body)
  ( "l"   hydra-org-link/body)
  ( "n"   hydra-org-note/body)
  ( "c"   hydra-org-capture/body)
  ( "t"   hydra-org-tag/body)
  ( "e"   hydra-org-table/body)
  ( "x"   hydra-org-misc/body)
  ( "q"   keyboard-quit :color blue))

(defhydra hydra-vim-tab-bar (:color blue :hint nil )
  "
☞ vim-tab-bar
[_e_]new  [_s_]switch  [_n_]next   [_p_]prev
[_x_]close
  "
  ( "e"   tab-new  )
  ( "s"   tab-switch  )
  ( "n"   tab-bar-switch-to-next-tab  )
  ( "p"   tab-bar-switch-to-prev-tab  )
  ( "x"   tab-close  )
  ( "q"   keyboard-quit :color blue))

(defhydra hydra-win (:color pink :hint nil )
  "
☞ window
[_j_]dec-height [_k_]inc-height [_h_]inc-width  [_l_]dec-width
[_x_]delete
  "
  ("x"   evil-window-delete)
  ("j"   evil-window-increase-height)
  ("k"   evil-window-decrease-height)
  ("h"   evil-window-increase-width)
  ("l"   evil-window-decrease-width)
  ("q"   keyboard-quit :color blue))

(defhydra hydra-file (:color blue :hint nil )
  "
☞ file
[_d_]dired [_e_]ranger [_r_]rg
  "
  ("d"   dired)
  ("e"   ranger)
  ("r"   rgrep)
  ("q"   keyboard-quit :color blue))

(defhydra hydra-motion (:color blue :hint nil )
  "
☞ motion
[_f_]find     [_F_]find-backward     [_j_]char
[_t_]find-to  [_T_]find-backward-to  [_c_]pinyin
  "
  ("c"   avy-goto-char)
  ("j"   avy-goto-char-timer)
  ("f"   evil-avy-find-char)
  ("F"   evil-avy-find-char-backward)
  ("t"   evil-avy-find-char-to)
  ("T"   evil-avy-find-char-to-backward)
  ("q"   keyboard-quit :color blue))

(defhydra hydra-misc (:color blue :hint nil )
  "
☞ misc
[_a_]truncate  [_c_]close-all-buffer    [_|_]split
[_-_]vsplit    [_w_]del-trailing-space
  "
  ("a"   toggle-truncate-lines)
  ("c"   my/clean-buffers)
  ("|"   evil-window-split)
  ("-"   evil-window-vsplit)
  ("w"   delete-trailing-whitespace)
  ("q"   keyboard-quit :color blue))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 general
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'general)

(general-create-definer user/leader-keys
  :states '(normal visual)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "SPC")
(user/leader-keys
  "f" '(hydra-file/body :wk "+file")
  "j" '(hydra-motion/body :wk "+motion")
  "o" '(hydra-org/body :wk "+org")
  "t" '(hydra-vim-tab-bar/body :wk "+tab")
  "w" '(hydra-win/body :wk "+win")
  "x" '(hydra-misc/body :wk "+misc"))


(provide 'user-keybind)
