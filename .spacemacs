;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.
;;
;; to reload, <SPC f e R>

(defun dotspacemacs/layers ()
  "Configuration Layers declaration."
  (setq-default

   dotspacemacs-distribution 'spacemacs

   dotspacemacs-configuration-layer-path '("~/.spacemacs-contribs/")

   dotspacemacs-configuration-layers
   '(
     osx
     better-defaults
     emacs-lisp
     git
     github
     version-control
     markdown
     c-c++
     latex
     python
     ipython-notebook
     javascript
     html
     yaml
     ess ; emacs speaks statistics - really R
     clojure
     haskell
     eyebrowse
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     syntax-checking
     ;; autocomplete config vars courtesey of Jeff Wu
     ;; (likely they're originally from Jonathan Reem)
     (auto-completion
      :variables
      auto-completion-return-key-behavior nil
      auto-completion-tab-key-behavior 'complete
      auto-completion-complete-with-key-sequence "kj"
      auto-completion-complete-with-key-sequence-delay 0.1
      auto-completion-private-snippets-directory nil
      auto-completion-enable-snippets-in-popup t
      auto-completion-enable-help-tooltip t
      auto-completion-enable-sort-by-usage t
      )
     )


   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '()

   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()

   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))


(defun dotspacemacs/init ()
  "The only thing this function should do is modify spacemacs config vars"
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '(recents projects)
   dotspacemacs-startup-recent-list-size 5
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(spacemacs-dark
                         solarized-light
                         solarized-dark
                         zenburn)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-command-key ":"
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-micro-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers nil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup `changed
   ))


(defun dotspacemacs/user-init ()
  "Called after `dotspacemacs/init' but before layer configuration executes.
   You should prefer to put custom code in `dotspacemacs/user-config', but
   if you must define variables *before* packages are loaded, then you
   can put the definitions here."
  )


(defun dotspacemacs/user-config ()
  "This function is called at the very end of Spacemacs initialization after
   layers configuration.
   Most custom configuration should go here."

  ;; TODO make myself a spacemacs layer or two and get the logic out of here

  ;; get emacs to consider underscores as part of a word
  (modify-syntax-entry ?_ "w" (standard-syntax-table))
  ;; set backspace to clear highlighting
  (define-key evil-normal-state-map [backspace] (kbd ":noh"))

  ;; ess stuff:
  ;; disable mapping _ to <-, enable mapping c-, (think c-<) to <-
  (add-hook 'ess-mode-hook
            (lambda () (ess-toggle-underscore nil)))
  (add-hook 'ess-mode-hook
            (lambda ()  (define-key evil-insert-state-map [(control ?,)]  (kbd "<-"))))

  ;; py2tmux integration
  ;;
  ;; TODO
  ;; - add a line variant (need to save excursion and set mark and point to start/end)
  ;; - factor this out into a real library / layer, hopefully adding some context-specific
  ;;   stuff like cpaste boundaries, %run commands, etc.
  ;; - make it so the same binding, SPC tt, can work in both normal mode (for lines)
  ;;   and visual selection mode (for regions). This probably requires evil hooks.
  (defun send-to-tmux (start end session-name)
    (let ((command (format "py2tmux send-content --session %s" session-name)))
      (shell-command-on-region start end command))
      )
  (defun get-end-of-line ()
      (save-excursion
        (end-of-line)
        (point)))
  (defun get-beginning-of-line ()
      (save-excursion
        (beginning-of-line)
        (point)))
  (defun line-to-tmux ()
    (interactive)
    (let ((start (get-beginning-of-line))
          (end   (get-end-of-line)))
      (send-to-tmux start end "emacs")
      ))
  (defun region-to-tmux (start end)
    (interactive "r")
    (region-to-tmux start end "emacs")
    )
  (spacemacs/set-leader-keys "tt" 'line-to-tmux)
  (spacemacs/set-leader-keys "ott" 'region-to-tmux)
)


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
