;; in ess mode:
;;   disable mapping _ to <-, enable mapping c-, (think c-<) to <-
(add-hook 'ess-mode-hook
          (lambda () (ess-toggle-underscore nil)))
(add-hook 'ess-mode-hook
          (lambda () (define-key evil-insert-state-map [(control ?,)]
                                  (kbd "<-"))))
