(setq path-to-ctags "/usr/bin/ctags-exuberant") ;; <- your ctags path here
(defun amesk/create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
    (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name))))
