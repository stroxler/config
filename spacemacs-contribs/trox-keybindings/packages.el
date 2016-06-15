;;; packages.el --- custom keybindings layer for Steven Troxler
;;
;; Copyright (c) 2016 Steven Troxler
;;
;; Author: Steven Troxler <steven.troxler@gmail.com>
;;
;; This file is not part of GNU Emacs.
;;
;;; License: Unlicense


(setq trox-keybindings-packages
  '(
    (evil-osx-clipboard :location
      (recipe :fetcher github :repo "stroxler/evil-osx-clipboard.el"))
    (py2tmux :location
      (recipe :fetcher github :repo "stroxler/py2tmux.el"))
    )
  )


;; the init is important so the package loads
(defun trox-keybindings/init-evil-osx-clipboard ()
  "Set both the osx defaults s-c and s-v, and linux C-C and C-V"
  (use-package evil-osx-clipboard
    :defer t
    :init
    (progn
      (evil-osx-clipboard/set-osx-defaults))))

(defun trox-keybindings/init-py2tmux ()
  "Set sending a line or region to osl and osr"
  (use-package py2tmux
    :defer t
    :init
    (progn
      (spacemacs/set-leader-keys "osl" 'py2tmux/line-to-tmux)
      (spacemacs/set-leader-keys "osr" 'py2tmux/region-to-tmux)
      )))
