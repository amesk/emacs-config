;;; -*- Mode: Emacs-Lisp -*-
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  Force load of these modules
;;
;;  File: rc-force-load.el
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

(require 'dired-details+)
(require 'cmake-mode)
(require 'color-theme)
(require 'tango-dark-theme)

(add-to-list 'auto-mode-alist '("\\.cmake$" . cmake-mode))
(add-to-list 'auto-mode-alist '("CMakeLists\.txt$" . cmake-mode))


;;; rc-force-load.el ends here
