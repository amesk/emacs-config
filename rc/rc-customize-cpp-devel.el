;;; (insert (file-name-nondirectory buffer-file-name)) ---
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  Generic C++ oriented stuff
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;


;; We use mostly C++, not C
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

(setq compile-command "cd ${PWD%/src/*} && ./hammer build")
(setq compilation-scroll-output t)

(require 'fill-column-indicator)
(require 'google-c-style)

;;;
;;; Force Google C++-style
;;;


(defun amesk/customize-cpp ()
  "Customize C++ coding style & visualization options for
   Google style conformance"
  (setq whitespace-style '(faces tabs tab-mark lines-tail))
  (setq whitespace-line-column 81)
  ;; make whitespace-mode use “¶” for newline and “▷” for tab.
  ;; together with the rest of its defaults
  (setq whitespace-display-mappings
        '(
          (space-mark 32 [183] [46]) ; normal space, ·
          (space-mark 160 [164] [95])
          (space-mark 2208 [2212] [95])
          (space-mark 2336 [2340] [95])
          (space-mark 3616 [3620] [95])
          (space-mark 3872 [3876] [95])
          (newline-mark 10 [182 10]) ; newlne, ¶
          (tab-mark 9 [9655 9] [92 9]) ; tab, ▷
          ))
  (setq fill-column 81)
  (fci-mode)
  (whitespace-mode)
  (google-set-c-style)
  (google-make-newline-indent)
  ;; end files with a newline
  (setq require-final-newline t))

(add-hook 'c-mode-common-hook 'amesk/customize-cpp)

;;;
;;; Define switch between cpp/h
;;;

(defvar amesk/header-switches '(("h" . ("cpp" "cc" "c"))
                                ("hpp" . ("cpp" "cc"))
                                ("cpp" . ("h" "hpp"))
                                ("c" . ("h"))
                                ("C" . ("H"))
                                ("H" . ("C" "CPP" "CC"))
                                ("cc" . ("h" "hpp"))))

(defun amesk/string-without-last (string n)
  "This function truncates from the STRING last N characters."
  (substring string 0 (max 0(- (length string) n))))

(defun amesk/switch-h-cpp ()
  "Switch header and body file according to `amesk/header-switches' var.
The current buffer's file name extention is searched in
`amesk/header-switches' variable to find out extention for file's counterpart,
for example *.hpp <--> *.cpp."
  (interactive)
  (let* ((ext (file-name-extension (buffer-file-name)))
         (base-name (amesk/string-without-last (buffer-name) (length ext)))
         (base-path (amesk/string-without-last (buffer-file-name) (length ext)))
         (count-ext (cdr (find-if (lambda (i) (string= (car i) ext)) amesk/header-switches))))
    (cond
     (count-ext
      (unless
          (or
           (loop for b in (mapcar (lambda (i) (concat base-name i)) count-ext)
                 when (bufferp (get-buffer b)) return (switch-to-buffer b))
           (loop for c in (mapcar (lambda (count-ext) (concat base-path count-ext)) count-ext)
                 when (file-exists-p c) return (find-file c)))
        (message "There is no corresponding pair (header or body) file.")))
     (t
      (message "It is not a header or body file! See amesk/header-switches variable.")))))

;;; rc-customize-cpp-devel.el ends here
