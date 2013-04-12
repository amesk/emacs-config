;;; -*- Mode: Emacs-Lisp -*-
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  Doxymacs support
;;
;;  File: rc-doxymacs.el
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

(require 'doxymacs)
(setq doxymacs-doxygen-style "Qt")
(setq doxymacs-command-character "\\")


;;; Tuned default templates
;;

(setq doxymacs-blank-multiline-comment-template
 '("/*!" > n "    \brief" p > n "    " > n "*/" > n))

(setq doxymacs-blank-singleline-comment-template
 '("/// " > p))

(defconst doxymacs-file-comment-template
 '("/*!" > n
   "    " (doxymacs-doxygen-command-char) "file   "
   (if (buffer-file-name)
       (file-name-nondirectory (buffer-file-name))
     "") > n
   "    " (doxymacs-doxygen-command-char) "author " (user-full-name)
   (doxymacs-user-mail-address)
   > n
   "    " (doxymacs-doxygen-command-char) "date   " (current-time-string) > n
   "    " > n
   "    " (doxymacs-doxygen-command-char) "brief  " (p "Brief description of this file: ") > n
   " " > n
   " " p > n
   "*/" > n))

(defconst doxymacs-function-comment-template
 '((let ((next-func (doxymacs-find-next-func)))
     (if next-func
	 (list
	  'l
	  "/*!" '> 'n
	  "    \\brief " 'p '> 'n
	  "    " '> 'n
	  (doxymacs-parm-tempo-element (cdr (assoc 'args next-func)))
	  (unless (string-match
                   (regexp-quote (cdr (assoc 'return next-func)))
                   doxymacs-void-types)
	    '(l "    " > n "    " (doxymacs-doxygen-command-char)
		"return " (p "Returns: ") > n))
	  " */" '>)
       (progn
	 (error "Can't find next function declaration.")
	 nil)))))

(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

(add-hook 'c-mode-common-hook 'doxymacs-mode)

(add-to-list 'auto-mode-alist '("\\.dox$" . c++-mode))

;;; rc-doxymacs.el ends here
