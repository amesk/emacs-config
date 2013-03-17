;;; rc-eproject.el ---
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  <Project>
;;
;;  <Description>
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

;; require doesn't handle the job!
;; (require 'eproject)
(load-file (concat dotfiles-dir "plugins/eproject.el"))

;; (dolist (func '(eproject-compile
;;                 eproject-eshell-cd-here
;;                 eproject-multi-isearch-buffers
;;                 eproject-todo
;;                 eproject-grep
;;                 eproject-revisit-project
;;                 eproject-project-root
;;                 eproject-open-all-project-files
;;                 eproject-kill-project-buffers
;;                 eproject-ibuffer
;;                 eproject-find-file
;;                 eproject-ifind-file))
;;   (autoload func "eproject-extras"))

(define-project-type uninav (generic)
  (look-for "uninav_config.h.in")
  :irrelevant-files (".git/"))

(add-hook 'after-change-major-mode-hook
          (lambda ()
            (when (and (buffer-file-name)
                       (not eproject-root))
              (eproject-maybe-turn-on))))


(add-hook 'uninav-project-file-visit-hook
      (lambda ()
        (set (make-local-variable 'compile-command)
             (format "cd %s; ./hammer config build" (eproject-root)))))


;;; rc-eproject.el ends here
