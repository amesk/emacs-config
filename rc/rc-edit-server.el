;;; rc-edit-server.el ---
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  Emacs Edit server configuration
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

(require 'edit-server)

;; Don't start the server unless we can verify that it isn't running.
;; (require 'server)
;; (when (and (functionp 'server-running-p) (not (server-running-p)))
;;  (server-start))

(edit-server-start)

;;; rc-edit-server.el ends here
