;;;
;;;
;;;

(require 'fill-column-indicator)
(require 'google-c-style)

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
  (google-make-newline-indent))

(add-hook 'c-mode-common-hook 'amesk/customize-cpp)
