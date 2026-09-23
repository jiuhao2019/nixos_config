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
[_c_]create         [_o_]export-table  [_v_]valign-toggle  [_u_]insert-row
[_l_]insert-column  [_x_]del-column
  "
  ("c"   org-table-create )
  ("o"   org-table-export-to-spreadsheet )
  ("v"   valign-mode )
  ("u"   org-table-insert-row )
  ("l"   org-table-insert-column )
  ("x"   org-table-delete-column )
  ("q"   keyboard-quit :color blue))

(defhydra hydra-org-link (:color blue :hint nil )
  "
☞ org-link
[_o_]open  [_t_]toggle-show  [_i_]insert
  "
  ( "o"   org-open-at-point )
  ( "t"   org-toggle-link-display )
  ( "i"   org-insert-link )
  ( "q"   keyboard-quit :color blue))

(defhydra hydra-org-block (:color blue :hint nil )
  "
☞ org-block
[_i_]insert-c-src  [_I_]insert-select
  "
  ("i"   my-org-region-to-c-src)
  ("I"   org-insert-structure-template)
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

(defhydra hydra-org-footnote (:color blue :hint nil )
  "
☞ org-footnote
[_a_]action  [_r_]ref  [_d_]def
  "
  ( "a"   my-org-footnote-action-after  )
  ( "r"   org-footnote-goto-previous-reference )
  ( "d"   org-footnote-goto-definition )
  ( "q"   keyboard-quit :color blue))

(defhydra hydra-org-misc (:color blue :hint nil )
  "
☞ org-misc
[_i_]toggle-inline-img  [_o_]export-html     [_n_]narrow-to-subtree
[_h_]html-to-org        [_e_]eval-expression
  "
  ( "i"   org-toggle-inline-images )
  ( "o"   org-html-export-to-html )
  ( "n"   org-toggle-narrow-to-subtree )
  ( "h"   my-html-to-org )
  ( "e"   eval-expression )
  ( "q"   keyboard-quit :color blue))

(defhydra hydra-org (:color blue :hint nil )
  "
☞ org
[_a_]+agenda [_b_]+block [_l_]+link [_n_]+note
[_t_]+tag    [_e_]+table [_x_]+misc [_c_]+capture
[_f_]+fn
  "
  ( "a"   hydra-org-agenda/body)
  ( "b"   hydra-org-block/body)
  ( "l"   hydra-org-link/body)
  ( "n"   hydra-org-note/body)
  ( "c"   hydra-org-capture/body)
  ( "t"   hydra-org-tag/body)
  ( "e"   hydra-org-table/body)
  ( "f"   hydra-org-footnote/body)
  ( "x"   hydra-org-misc/body)
  ( "q"   keyboard-quit :color blue))

(defhydra hydra-vim-tab-bar (:color blue :hint nil )
  "
☞ vim-tab-bar
[_e_]new  [_s_]switch  [_n_]next   [_N_]prev
[_x_]close
  "
  ( "e"   tab-new  )
  ( "s"   tab-switch  )
  ( "n"   tab-bar-switch-to-next-tab  )
  ( "N"   tab-bar-switch-to-prev-tab  )
  ( "x"   tab-close  )
  ( "q"   keyboard-quit :color blue))

(defhydra hydra-file (:color blue :hint nil )
  "
☞ file
[_d_]dired           [_e_]ranger  [_r_]rg  [_o_]old-file-open
[_c_]old-file-clear
  "
  ("d"   dired)
  ("e"   ranger)
  ("r"   rgrep)
  ("o"   my-recent-files-open)
  ("c"   my-recent-files-clear)
  ("q"   keyboard-quit :color blue))

(defhydra hydra-motion (:color blue :hint nil )
  "
☞ motion
[_f_]f     [_F_]F     [_j_]motion
[_t_]t     [_T_]T
  "
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
  ("|"   evil-window-vsplit)
  ("-"   evil-window-split)
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
  "x" '(hydra-misc/body :wk "+misc"))


(provide 'user-keybind)
