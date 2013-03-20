;;; rc-auto-insert.el ---
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  auto-insert stuff
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory (concat amesk/config-base "auto-insert/"))
(setq auto-insert 'other)
(setq auto-insert-query nil)

(setq auto-insert-alist '(("\\.muse$" . ["insert.muse"])
                          ("\\.sh$" . ["insert.sh" amesk/auto-update-defaults])
                          ("\\.el$" . ["insert.el" amesk/auto-update-defaults])
                          ("\\.py$" . ["insert.py" amesk/auto-update-defaults])
                          ("\\.mak$" . ["insert.py" amesk/auto-update-defaults])
                          ("[Mm]akefile$" . ["insert.py" amesk/auto-update-defaults])
                          ("CMakeLists.txt$" . ["insert.cmake" amesk/auto-update-defaults])
                          ("\\.cmake$" . ["insert.cmake" amesk/auto-update-defaults])
                          ("\\.cpp$" . ["insert.cpp" amesk/auto-update-c-source-file])
                          ("\\.h$"   . ["insert.h" amesk/auto-update-header-file])
                          ("\\.hpp$"   . ["insert.h" amesk/auto-update-header-file])
                          ("\\.c$" . ["insert.cpp" amesk/auto-update-c-source-file])
                          ))

(defun amesk/compute-header-guard (hdr-name)
 (let ((name hdr-name))
   (if (string-match "^.+/uninav/src/" name)
       (progn
         (setq name (upcase (replace-match "src/" t t name)))
         (while (string-match "[./\\]" name)
           (setq name (replace-match "_" t t name)))
         (concat name "_"))
       (concat (upcase (file-name-nondirectory (file-name-sans-extension hdr-name))) "_H_"))))

;; TODO - find uninav in more intelligent way

(defun amesk/auto-replace-header-name ()
(let ((name (amesk/compute-header-guard buffer-file-name)))
  (save-excursion
    (when (string-match "^.+/uninav/src/" name)
      (replace-string "<Project>" "UniNav Project"))
    (while (search-forward "###" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match name)
        (subst-char-in-region (point-min) (point-max) ?. ?_)
        (subst-char-in-region (point-min) (point-max) ?- ?_))))))

(defun amesk/auto-replace-file-name ()
  (save-excursion
    ;; Replace @@@ with file name
    (while (search-forward "(>>FILE<<)" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match (file-name-nondirectory buffer-file-name) t)
        ))
    )
  )

(defun amesk/auto-replace-file-name-no-ext ()
  (save-excursion
    ;; Replace @@@ with file name
    (while (search-forward "(>>FILE_NO_EXT<<)" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match (file-name-sans-extension (file-name-nondirectory buffer-file-name)) t)
        ))
    )
  )

(defun amesk/insert-today ()
  "Insert today's date into buffer"
  (interactive)
  (insert (format-time-string "%A, %B %e %Y" (current-time))))

(defun amesk/auto-replace-date-time ()
  (save-excursion
    ;; replace DDDD with today's date
    (while (search-forward "(>>DATE<<)" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match "" t)
        (amesk/insert-today)
        ))))

(defun amesk/auto-update-header-file ()
  (amesk/auto-replace-header-name)
  (amesk/auto-replace-file-name)
  )

(defun amesk/auto-update-c-source-file ()
  (save-excursion
    ;; Replace HHHH with file name sans suffix
    (while (search-forward "HHHH" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match (concat (file-name-sans-extension (file-name-nondirectory buffer-file-name)) ".h") t))))
  (amesk/auto-replace-file-name)
  (amesk/auto-replace-date-time))

(defun amesk/auto-update-defaults ()
  (amesk/auto-replace-file-name)
  (amesk/auto-replace-file-name-no-ext)
  (amesk/auto-replace-date-time)
  )

;;; rc-auto-insert.el ends here
