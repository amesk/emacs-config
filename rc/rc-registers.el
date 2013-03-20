;;; rc-registers.el ---
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  Shortcuts to some buffers
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

;; Registers allow you to jump to a file or other location
;; quickly. Use C-x r j followed by the letter of the register (i for
;; init.el, r for this file) to jump to it.

;; You should add registers here for the files you edit most often.

(dolist (r `((?i (file . ,(concat dotfiles-dir "init.el")))
             (?o (file . ,"~/.org/startup.org"))))
  (set-register (car r) (cadr r)))

;;; rc-registers.el ends here
