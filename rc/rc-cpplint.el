;;; rc-cpplint.el ---
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  <Description>
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

(setq amesk/path-to-cpplint "/home/amesk/bin/cpplint")
(setq amesk/path-to-dcpplint "/home/amesk/bin/dcpplint")
(setq amesk/cpplint-buffer-name "*cpplint*")

(defun amesk/cpplint ()
  "Invokes cpplint on a current buffer"
  (interactive)
  (get-buffer-create amesk/cpplint-buffer-name)
  (shell-command
   (format "%s %s" amesk/path-to-cpplint  buffer-file-name)
   amesk/cpplint-buffer-name amesk/cpplint-buffer-name)
  (switch-to-buffer amesk/cpplint-buffer-name)
  (compilation-mode)
  )

(defun amesk/dcpplint (dir-name)
  "Invokes cpplint on a current buffer"
  (interactive "DDirectory: ")
  (get-buffer-create amesk/cpplint-buffer-name)
  (shell-command
   (format "%s %s" amesk/path-to-dcpplint dir-name)
   amesk/cpplint-buffer-name amesk/cpplint-buffer-name)
  (switch-to-buffer amesk/cpplint-buffer-name)
  (compilation-mode)
  )

(defun amesk/beautify_cpp ()
  "Invokes C++ beautifier on a current buffer"
  (interactive)
  (shell-command
   (format "%s %s" "~/bin/beautify_cpp"  buffer-file-name))
   (load-file  buffer-file-name)
   )

;;; rc-cpplint.el ends here
