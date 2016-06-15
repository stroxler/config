;;;; NOTE this stuff definitely belongs in a package
;;;; it's all my p2tmux integration

(defun trox/send-to-tmux (start end session-name)
  "send the text in current-buffer between start and end
   to the tmux session with name session-name"
  (let ((command (format "py2tmux send-content --session %s" session-name)))
    (shell-command-on-region start end command))
  )

(defun trox/get-end-of-line ()
  "return the int location of the end of current line"
  (save-excursion
    (end-of-line)
    (point)))

(defun trox/get-beginning-of-line ()
  "return the int location of the start of current line"
  (save-excursion
    (beginning-of-line)
    (point)))

(defun trox/line-to-tmux ()
  "send the current line to the tmux session named 'emacs'"
  (interactive)
  (let ((start (trox/get-beginning-of-line))
        (end   (trox/get-end-of-line)))
    (trox/send-to-tmux start end "emacs")
    ))

(defun trox/region-to-tmux (start end)
  "send the current region to the tmux session named 'emacs'"
  (interactive "r")
  (trox/send-to-tmux start end "emacs")
  )



;; NOTE once again these probably belong in a package
;; these functions are from
;;  http://emacs.stackexchange.com/questions/653/how-can-i-find-out-in-which-keymap-a-key-is-bound
;;
;; They won't be needed once emacs 25 comes out, so between
;; that and the fact that the code isn't mine, I'm not going to make a
;; package out of them.
(defun trox/key-binding-at-point (key)
  (mapcar (lambda (keymap) (when (keymapp keymap)
                             (lookup-key keymap key)))
          (list
           ;; More likely
           (get-text-property (point) 'keymap)
           (mapcar (lambda (overlay)
                     (overlay-get overlay 'keymap))
                   (overlays-at (point)))
           ;; Less likely
           (get-text-property (point) 'local-map)
           (mapcar (lambda (overlay)
                     (overlay-get overlay 'local-map))
                   (overlays-at (point))))))


(defun trox/locate-key-binding (key)
  "Determine in which keymap KEY is defined."
  (interactive "kPress key: ")
  (let ((ret
         (list
          (key-binding-at-point key)
          (minor-mode-key-binding key)
          (local-key-binding key)
          (global-key-binding key))))
    (when (called-interactively-p 'any)
      (message "At Point: %s\nMinor-mode: %s\nLocal: %s\nGlobal: %s"
               (or (nth 0 ret) "") 
               (or (mapconcat (lambda (x) (format "%s: %s" (car x) (cdr x)))
                              (nth 1 ret) "\n             ")
                   "")
               (or (nth 2 ret) "")
               (or (nth 3 ret) "")))
    ret))
