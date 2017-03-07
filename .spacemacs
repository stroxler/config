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
     fzf-layer

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
     (spell-checking :variables spell-checking-enable-by-default nil)
     syntax-checking

     ;; autocomplete config vars courtesey of Jeff Wu
     ;;   note that I'm using kj for completion, because the default
     ;;   emacs tab   behavior is awesome when doing python code
     (auto-completion
      :variables
      auto-completion-return-key-behavior 'cycle
      auto-completion-tab-key-behavior 'complete
      ;; I'm dropping the completion sequence because it's easier to
      ;; bounce back and forth with other editors if I use a really standard
      ;; completion behavior.
      ;; --------------------
      ;; auto-completion-complete-with-key-sequence "kj"
      ;; auto-completion-complete-with-key-sequence-delay 0.2
      auto-completion-private-snippets-directory "~/spacemacs-snippets/"
      auto-completion-enable-snippets-in-popup t
      auto-completion-enable-help-tooltip t
      auto-completion-enable-sort-by-usage t
      )
     org

     ;; provides better file navigation based on language semantics
     semantic

     ;; file browsers
     ranger

     ;; languages
     emacs-lisp
     go
     haskell
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
     (scala :variables scala-enable-eldoc t)
     haskell
     )


   dotspacemacs-additional-packages
   '(
     ;; ob-ipython, see https://github.com/gregsexton/ob-ipython
     (ob-ipython)
     ;; TODO: remove this? I think I have a layer for it now
     (fzf :location
      (recipe :fetcher github :repo "bling/fzf.el"))
     )

   dotspacemacs-excluded-packages) '()

   dotspacemacs-delete-orphan-packages t
   )


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
                         solarized-dark
                         solarized-light
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
  (global-auto-revert-mode t)                            ;; reload files
  (modify-syntax-entry ?_ "w" (standard-syntax-table))   ;; _ is part of word
  (turn-off-pbcopy)                                      ;; no auto clipboard
  (setq vc-follow-symlinks t)                            ;; auto follow symlinks
  (run-with-timer 0 60 'turn-off-pbcopy)

  ;; turn off smartparens (space t p can turn it on when you want it)
  (spacemacs/toggle-smartparens-globally-off)
  (remove-hook 'prog-mode-hook #'smartparens-mode)
  ;;;; This block is an alternative: leave smartparens on but disable specific
  ;;;; auto-generated symbol pairs (smartparens does do some other cool stuff
  ;;;; if you learn how to use it
  ;; (eval-after-load 'smartparens
  ;;   '(progn
  ;;      (sp-pair "(" nil :actions :rem)
  ;;      (sp-pair "[" nil :actions :rem)
  ;;      (sp-pair "'" nil :actions :rem)
  ;;      (sp-pair "\"" nil :actions :rem)))

  ;; make ' behave like ;, and ; behave like :. Also map backspace to :noh
  (spacemacs/set-leader-keys ";" 'helm-M-x)
  (define-key evil-normal-state-map (kbd "'") 'evil-repeat-find-char)
  (define-key evil-normal-state-map (kbd ";") 'evil-ex)
  (define-key evil-motion-state-map (kbd ";") 'evil-ex)
  (define-key evil-normal-state-map [backspace] 'evil-search-highlight-persist-remove-all)

  ;; make avy more powerful for motion across all windows and frames
  ;;  (there's a tradeoff here because the key sequences get longer, but avy
  ;;   appears to choose shorter sequences for the active window so it's not much
  ;;   of a tradeoff)
  (setq avy-all-windows 'all-frames)

  ;;;; make anaconda-mode use pytest rather than nose
  ;; NOTE so far this isn't working after reload, but maybe restart will help
  (setq-default dotspacemacs-configuration-layers
                '((python :variables python-test-runner 'pytest)))

  ;;;; set up ob-ipython stuff

  ;; register it with org-babel
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ipython . t)))

  ;; turn off confirm inputs for ipython blocks
  (defun my-org-confirm-babel-evaluate (lang body)
    (not (string= lang "ipython")))
  (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

  ;; auto display images inline
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)


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

  ;; set up some FZF bindings
  ;; TODO make a layer for this

  (defun fzf-kode ()
    (interactive)
    (fzf-directory "/kode/"))

  (defun fzf-dropbox-work ()
    (interactive)
    (fzf-directory "~/Dropbox/work/"))

  (defun fzf-dropbox-me ()
    (interactive)
    (fzf-directory "~/Dropbox/me/"))

  ;; set up hard-coded searches
  (spacemacs/set-leader-keys "fk" 'fzf-kode)
  (spacemacs/set-leader-keys "fww" 'fzf-dropbox-work)
  (spacemacs/set-leader-keys "fmm" 'fzf-dropbox-me)

  ;; set up fn and fl as synonyms for ff (these bindings do slightly
  ;; different things from ff in my vim setup; the helm file finder is
  ;; more powerful, so they can all map to the same action here)
  (spacemacs/set-leader-keys "fl" 'spacemacs/helm-find-files)
  (spacemacs/set-leader-keys "fn" 'spacemacs/helm-find-files)

  ;; scala stuff
  (setq ensime-startup-snapshot-notification nil)

  ;; fix evil and company integration
  ;;   Note: I found this solution via a combination of
  ;;   https://github.com/company-mode/company-mode/issues/15
  ;;   and digging around the spacemacs completion layer source code
  (mapc #'evil-declare-change-repeat
        '(spacemacs//auto-completion-key-sequence-end))

  ;; haskell stuff: uses ~/.local/bin for executables
  (add-to-list 'exec-path "~/.local/bin/")
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)


)


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
