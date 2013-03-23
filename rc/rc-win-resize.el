;;; -*- Mode: Emacs-Lisp -*-
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  Interactive window resizing functions
;;
;;  File: win-resize.el
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

(defun amesk/win-resize-top-or-bot ()
"Figure out if the current window is on top, bottom or in the middle"
(let* ((win-edges (window-edges))
       (this-window-y-min (nth 1 win-edges))
       (this-window-y-max (nth 3 win-edges))
       (fr-height (frame-height)))
  (cond ((eq 0 this-window-y-min) "top")
        ((eq (- fr-height 1) this-window-y-max) "bot") (t "mid"))))

(defun amesk/win-resize-left-or-right ()
"Figure out if the current window is to the left, right or in the middle"
(let* ((win-edges (window-edges))
       (this-window-x-min (nth 0 win-edges))
       (this-window-x-max (nth 2 win-edges))
       (fr-width (frame-width)))
  (cond ((eq 0 this-window-x-min) "left")
        ((eq (+ fr-width 2) this-window-x-max) "right")
        (t "mid"))))

(defun amesk/win-resize-enlarge-horiz ()
  (interactive)
  (cond ((equal "top" (amesk/win-resize-top-or-bot)) (enlarge-window -1))
        ((equal "bot" (amesk/win-resize-top-or-bot)) (enlarge-window 1))
        ((equal "mid" (amesk/win-resize-top-or-bot)) (enlarge-window -1))
        (t (message "nil"))))

(defun amesk/win-resize-minimize-horiz ()
  (interactive)
  (cond ((equal "top" (amesk/win-resize-top-or-bot)) (enlarge-window 1))
        ((equal "bot" (amesk/win-resize-top-or-bot)) (enlarge-window -1))
        ((equal "mid" (amesk/win-resize-top-or-bot)) (enlarge-window 1))
        (t (message "nil"))))

(defun amesk/win-resize-enlarge-vert ()
  (interactive)
  (cond ((equal "left" (amesk/win-resize-left-or-right)) (enlarge-window-horizontally -1))
        ((equal "right" (amesk/win-resize-left-or-right)) (enlarge-window-horizontally 1))
        ((equal "mid" (amesk/win-resize-left-or-right)) (enlarge-window-horizontally -1))))

(defun amesk/win-resize-minimize-vert ()
  (interactive)
  (cond ((equal "left" (amesk/win-resize-left-or-right)) (enlarge-window-horizontally 1))
        ((equal "right" (amesk/win-resize-left-or-right)) (enlarge-window-horizontally -1))
        ((equal "mid" (amesk/win-resize-left-or-right)) (enlarge-window-horizontally 1))))

;;; amesk/win-resize.el ends here
