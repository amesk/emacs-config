;;; rc-project-uninav.el ---
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  UniNav project configuration
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

(require 'flymake)

;; require doesn't handle the job, otherwize define-project-type is
;; not available!
(require 'eproject)
(load-file (concat dotfiles-dir "plugins/eproject.el"))

(setq cpplint-abspath "/home/amesk/projects/uninav/uninav/tools/cpplint.py")

(defun flymake-cpplint-init ()
  (list "python" (list cpplint-abspath
                       (flymake-init-create-temp-buffer-copy
                        'flymake-create-temp-inplace))))

(setq flymake-err-line-patterns
      (list (list "\\([^:]*\\):\\([0-9]+\\):\\(.+\\)$" 1 2 nil 3)))

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
             (format "cd %s; ./hammer config build" (eproject-root)))
        (set (make-local-variable 'flymake-err-line-patterns)
             (list (list "\\([^:]*\\):\\([0-9]+\\):\\(.+\\)$" 1 2 nil 3)))
        (set (make-local-variable 'flymake-allowed-file-name-masks)
             (list '(".+\\.cpp$" flymake-cpplint-init)
                   '(".+\\.h$" flymake-cpplint-init)))
        (save-excursion
          (unless (search-forward "Soloviev" nil t)
            (flymake-mode t)))))


;; (global-set-key [f3] 'flymake-display-err-menu-for-current-line)
;; (global-set-key [f4] 'flymake-goto-next-error)

;; (add-hook 'find-file-hook 'flymake-find-file-hook)

;; (push '(".+\\.c$" flymake-c-init) flymake-allowed-file-name-masks)
;; (push '(".+\\.h$" flymake-c-init) flymake-allowed-file-name-masks)


;;; rc-project-uninav.el ends here
