;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.
;;
;; to reload, <SPC f e R>

(defun dotspacemacs/layers ()
  "Configuration Layers declaration."
  (setq-default

   dotspacemacs-distribution 'spacemacs

   dotspacemacs-configuration-layer-path '("~/spacemacs-contribs/")

   dotspacemacs-configuration-layers
   '(
     ;; my stuff
     trox-keybindings

     ;; general stuff
     osx
     better-defaults
     git
     github
     version-control
     eyebrowse
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     syntax-checking

     ;; autocomplete config vars courtesey of Jeff Wu
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

     ;; languages
     emacs-lisp
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
    )


   dotspacemacs-additional-packages
   '(
     )

   dotspacemacs-excluded-packages '()

   dotspacemacs-delete-orphan-packages t
   ))


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
   dotspacemacs-themes '(
                         solarized-light
                         spacemacs-dark
                         zenburn
                        )
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

  ;; changes global emacs behavior
  (modify-syntax-entry ?_ "w" (standard-syntax-table))   ;; _ is part of word
  (turn-off-pbcopy)                                      ;; no auto clipboard
  (setq vc-follow-symlinks t)                            ;; auto follow symlinks


  ;; make ' behave like ;, and ; behave like :. Also map backspace to :noh
  (spacemacs/set-leader-keys ";" 'helm-M-x)
  (define-key evil-normal-state-map (kbd "'") 'evil-repeat-find-char)
  (define-key evil-normal-state-map (kbd ";") 'evil-ex)
  (define-key evil-motion-state-map (kbd ";") 'evil-ex)
  (define-key evil-normal-state-map [backspace] 'evil-search-highlight-persist-remove-all)

  ;; make ess mode behave nicer. Note that sometimes you'll have to
  ;; re-disable underscore stuff; just run M-x ess-toggle-underscore
  (add-hook 'ess-mode-hook
            (lambda () (ess-toggle-underscore nil)))
  (add-hook 'ess-mode-hook
            (lambda () (define-key evil-insert-state-map [(control ?,)]
                         (kbd "<-"))))

  ;; some projectile stuff
  (setq projectile-globally-ignored-file-suffixes
        '("pyc"))
)


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
