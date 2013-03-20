;;; -*- Mode: Emacs-Lisp -*-
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  ECB configuration
;;
;;  File: rc-ecb.el
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

(load-file "~/emacs/cedet-1.0/common/cedet.el")
;; (global-ede-mode 1)                      ; Enable the Project management system
;; (semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
;; (global-srecode-minor-mode 1)            ; Enable template insertion menu

(add-to-list 'load-path "~/emacs/ecb-2.40")
(require 'ecb-autoloads)

(defun amesk/ecb-activate-hook ()
  (setq ecb-tip-of-the-day nil)
  (global-semantic-tag-folding-mode))

(add-hook 'ecb-activate-hook  'amesk/ecb-activate-hook)

;;;;(ede-cpp-root-project "UniNav"
;;;;                :name "UniNav Project"
;;;;                :file "~/uninav/CMakeLists.txt"
;;;;                :include-path '("/"
;;;;                                "/src"
;;;;                               )
;;;;                :system-include-path '("~/exp/include")
;;;;                :spp-table '(("isUnix" . "")
;;;;                             ("BOOST_TEST_DYN_LINK" . "")))


;;(ede-cpp-root-project "UniNav"
;;
;;                :name "UniNav Project"
;;                :file "~/uninav/CMakeLists.txt"
;;                :include-path '("/"
;;                                "/src/public"
;;                               )
;;                :system-include-path '("~/include"))

(setq amesk/is-ecb-active nil)

(defun amesk/ecb-toggle-proc ()
  (interactive)
  (if amesk/is-ecb-active
      ((lambda () (setq amesk/is-ecb-active nil) (ecb-deactivate)))
    ((lambda () (setq amesk/is-ecb-active t) (ecb-activate)))))


;;; TODO - use them
;; ecb-eshell-recenter
;; ecb-eshell-buffer-sync

;;; rc-ecb.el ends here
