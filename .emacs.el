;; HACK make ssl stop complaining
;; NOTE: first must run
;;   brew install libressl
(require 'gnutls)
(add-to-list 'gnutls-trustfiles "/usr/local/etc/openssl/cert.pem")

;; HACK fix use-package
;; NOTE: first must run:
;;   mkdir ~/_extra_emacs_packages
;;   git clone git@github.com:jwiegley/use-package.git ~/_extra_emacs_packages/use-package
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "~/_extra_emacs_packages/use-package")
  (require 'use-package))



;;; from https://emacs.stackexchange.com/questions/19936/running-spacemacs-alongside-regular-emacs-how-to-keep-a-separate-emacs-d/20508#20508

;;; Commentary:
;;; This code mimics the behaviour of `startup.el' to let the
;;; usage of the custom init directory behave just like the
;;; one and only "~/.emacs.d".
;;;
;;; By setting the environment variable `EMACS_USER_DIRECTORY'
;;; the user-emacs-directory can be chosen and if there is an
;;; `init.el' the configuration from that directory will be used.
;;; If the environment variable is not set or there is no `init.el'
;;; the default configuration directory `~/.emacs.d/' will be used.
;;;
;;; The variable `server-name' will be set to the name of the directory
;;; chosen as start path.  So if the server will be started, it can be
;;; reached with 'emacsclient -s servername'.
;;;
;;; This now works with a current version of spacemacs but does not
;;; work with `async-start' in general, if the code executed with `async'
;;; uses `user-init-dir' or makes other assumptions about the emacs
;;; start-directory.

;;; Code:
(let* ((user-init-dir-default
    (file-name-as-directory (concat "~" init-file-user "/.emacs.d")))
       (user-init-dir
    (file-name-as-directory (or (getenv "EMACS_USER_DIRECTORY")
                    user-init-dir-default)))
       (user-init-file-1
    (expand-file-name "init" user-init-dir)))
  (setq user-emacs-directory user-init-dir)
  (with-eval-after-load "server"
    (setq server-name
      (let ((server--name (file-name-nondirectory
                   (directory-file-name user-emacs-directory))))
        (if (equal server--name ".emacs.d")
        "server"
          server--name))))
  (setq user-init-file t)
  (load user-init-file-1 t t)
  (when (eq user-init-file t)
    (setq user-emacs-directory user-init-dir-default)
    (load (expand-file-name "init" user-init-dir-default) t t)))

(provide '.emacs)

