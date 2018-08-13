;;  SQL stuff This is mostly copy pasted from
;;  https://truongtx.me/2014/08/23/setup-emacs-as-an-sql-database-client
(require 'sql)

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

(setq sql-send-terminator t)



(defun my-sql-connect (product connection)
  (setq sql-product product)
  (sql-connect connection))


;; Configure postres and redshift

(setq sql-postgres-program "psql")

(defun sql-redshift ()
  "Connect to reshift."
  (interactive)
  (my-sql-connect 'postgres 'redshift))

;; Configure presto

(setq sql-presto-program "sane-presto"
      sql-presto-login-params '((user :default "stroxler")
                                (database :default "")))

(add-to-list 'sql-product-alist
             '(presto
               :name "Presto"
               :free-software t
               :font-lock sql-mode-postgres-font-lock-keywords
               :sqli-program sql-presto-program
               :sqli-login sql-presto-login-params
               :sqli-comint-func sql-comint-presto
               :prompt-regexp "^\\w*[#>] "
               :prompt-length 8
               :prompt-cont-regexp "^\\w*[-(]*[#>] "
               :input-filter sql-remove-tabs-filter
               :terminator ("\\(^\\s-*\\\\g$\\|;\\)" . "\\g")))

(defun sql-comint-presto (product options)
  (let ((sql-login-delay 0.9))
    (sql-comint product options)))

(defun sql-presto ()
  "Connect to presto."
  (interactive)
  (let ((sql-product 'presto))
    (sql-connect 'presto)))

;; Example of how to configure presto:
;;
;; (add-to-list 'sql-connection-alist
;;            '(presto
;;              (sql-product 'presto)
;;              (sql-user "stroxler")
;;              (sql-port 8889)
;;              (sql-database "whatever-it-is")))
;;
;; If you do this, then running M-x sql-presto will pop open
;; a presto buffer.


;; Put actual connections in a separate file, which we don't
;; version control.
(if (file-exists-p "~/emacs-sql-connections.el")
    (load "~/emacs-sql-connections.el"))
