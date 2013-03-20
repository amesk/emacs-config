;;; -*- Mode: Emacs-Lisp -*-
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  Resize window interactively
;;
;;  File: rc-interactive-resize-window.el
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

(defvar amesk/enlarge-window-char ?+)
(defvar amesk/shrink-window-char ?-)
(defun amesk/resize-window (&optional arg)
  "Interactively resize the selected window.
Repeatedly prompt whether to enlarge or shrink
the window until the response is neither
`amesk/enlarge-window-char' or `amesk/shrink-window-char'.
When called with a prefix arg, resize the window by ARG lines."
  (interactive "p")
  (let ((prompt (format "Enlarge/Shrink window (%c/%c)? "
                        amesk/enlarge-window-char amesk/shrink-window-char))
        response)
    (while (progn
             (setq response (read-event prompt))
             (cond ((equal response amesk/enlarge-window-char)
                    (enlarge-window arg)
                    t)
                   ((equal response amesk/shrink-window-char)
                    (enlarge-window (- arg))
                    t)
                   (t nil))))
    (push response unread-command-events)))

;;; TODO - is this better?
;;
;; Resize window (recursive-version)
;;
;; (defun v-resize (key)
;;  "interactively resize the window"
;;  (interactive "cHit +/- to enlarge/shrink")
;;    (cond
;;      ((eq key (string-to-char "+"))
;;         (enlarge-window 1)
;;         (call-interactively 'v-resize))
;;      ((eq key (string-to-char "-"))
;;         (enlarge-window -1)
;;         (call-interactively 'v-resize))
;;      (t (push key unread-command-events))))
;; (global-set-key "\C-c+" 'v-resize)

;;; rc-interactive-resize-window.el ends here
