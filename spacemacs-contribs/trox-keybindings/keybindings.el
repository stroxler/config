;; disable mapping _ to <-, enable mapping c-, (think c-<) to <-
(add-hook 'ess-mode-hook
          (lambda () (ess-toggle-underscore nil)))
(add-hook 'ess-mode-hook
          (lambda () (define-key evil-insert-state-map [(control ?,)]
                                  (kbd "<-"))))


;; copy-paste behavior
;; NOTE this probably belongs in its own layer, maybe even package
;;   - as a general rule, I don't want inside-emacs copy-paste to affect
;;     clipboard because it clobbers my clipmenu history
;;   - but I do want
;;     (a) the ability to copy-paste to system using super-c and super-v
;;     (b) the ability to toggle on system clipboard integration

;; turn off the system clipboard by default


;; set ocy and ocn (clipboard yes vs cliboard no) for toggling
(spacemacs/set-leader-keys "ocy" 'trox/toggle-on-pbcopy)
(spacemacs/set-leader-keys "ocn" 'trox/toggle-off-pbcopy)

;; set osl and osr (send line / send region) to send to tmux
(spacemacs/set-leader-keys "osl" 'trox/line-to-tmux)
(spacemacs/set-leader-keys "osr" 'trox/region-to-tmux)
