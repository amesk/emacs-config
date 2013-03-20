;;; rc-tags.el ---
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  CEDET independet tags support
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

(setq path-to-ctags "/usr/bin/ctags-exuberant") ;; <- your ctags path here
(defun amesk/create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
    (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name))))

;;; rc-tags.el ends here
