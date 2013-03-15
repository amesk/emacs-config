(require 'edit-server)

;; Don't start the server unless we can verify that it isn't running.
;; (require 'server)
;; (when (and (functionp 'server-running-p) (not (server-running-p)))
;;  (server-start))

(edit-server-start)
