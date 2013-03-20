;;; -*- Mode: Emacs-Lisp -*-
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  Local settings for vottd-amesk7.transas.com
;;
;;  File: rc-local-vottd-amesk7.el
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

(when (string-equal system-type "windows-nt")
(progn
(setq cygwin-bin "c:\\cygwin\\bin")
(setq gnu-bin "C:\\GnuWin32\\gnuwin32\\bin")
(setenv "PATH"
(concat cygwin-bin ";" gnu-bin ";" (getenv "PATH")))
(setq exec-path '(cygwin-bin gnu-bin))))
(setq grep-use-null-device nil)
(setq grep-find-use-xargs t)
(grep-compute-defaults)

;;; rc-local-vottd-amesk7.el ends here
