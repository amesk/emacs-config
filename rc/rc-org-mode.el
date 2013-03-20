;;; -*- Mode: Emacs-Lisp -*-
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  Org-mode configuration
;;
;;  File: rc-org-mode.el
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

;; (global-set-key "\e\el" 'org-store-link)
;; (global-set-key "\e\ec" 'org-capture)
;; (global-set-key "\e\ea" 'org-agenda)
;; (global-set-key "\e\eb" 'org-iswitchb)

(setq org-agenda-files (quote ("~/.org/")))

;my prefer identation
;; (setq org-startup-indented t) ; # +STARTUP: hidestars
(setq org-open-at-point t) ; open link on <RET>

;;logging stuff
(setq org-log-done (quote time))
(setq org-log-into-drawer nil)
(setq org-log-redeadline (quote note))
(setq org-log-reschedule (quote time))
;;todo keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t!)" "NEXT(n!)" "WAITING(w@/!)" "STARTED(s!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              (sequence "QUOTE(Q!)" "QUOTED(D!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
              (sequence "OPEN(O!)" "|" "CLOSED(C!)"))))

;; (org-tag-alist '(("UniNav" . ?u)
;;                  ("EMacs" . ?e)
;;                  ("Personal" . ?p)
;;                  ("Network" . ?e)
;;                  ("Collections" . ?o)
;;                  ("Navigation" . ?n)
;;                  ("Logging" . ?g)
;;                  ("Logbook" . ?l)
;;                  ("HA" . ?h)
;;                  ("Kernel" . ?k)
;;                  ("Infrastructure" . ?i)
;;                  ("Charts" . ?c)))

;;; rc-org-mode.el ends here
