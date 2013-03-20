;;; -*- Mode: Emacs-Lisp -*-
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  Maximize window on start
;;
;;  File: rc-maxframe.el
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

(require 'maxframe)

(defun amesk/try-maximize ()
  (when (display-graphic-p)
    (if (eq system-type 'gnu/linux)
        (toggle-fullscreen)
      (maximize-frame))))

(add-hook 'window-setup-hook 'amesk/try-maximize)

;;; rc-maxframe.el ends here
