;; Amesk patches

(load-file "~/emacs/cedet-1.0/common/cedet.el")
;;(global-ede-mode 1)                      ; Enable the Project management system
;;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
;;(global-srecode-minor-mode 1)            ; Enable template insertion menu

(add-to-list 'load-path "~/emacs/ecb-2.40")
(require 'ecb-autoloads)

(defun my-ecb-activate-hook ()
  (setq ecb-tip-of-the-day nil)
  (global-semantic-tag-folding-mode))

(add-hook 'ecb-activate-hook  'my-ecb-activate-hook)

;;;;(ede-cpp-root-project "UniNav"
;;;;                :name "UniNav Project"
;;;;                :file "~/uninav/CMakeLists.txt"
;;;;                :include-path '("/"
;;;;                                "/src"
;;;;                               )
;;;;                :system-include-path '("~/exp/include")
;;;;                :spp-table '(("isUnix" . "")
;;;;                             ("BOOST_TEST_DYN_LINK" . "")))


;;(ede-cpp-root-project "UniNav"
;;
;;                :name "UniNav Project"
;;                :file "~/uninav/CMakeLists.txt"
;;                :include-path '("/"
;;                                "/src/public"
;;                               )
;;                :system-include-path '("~/include"))


;;(pc-selection-mode)

(setq compile-command "cd ${PWD%/src/*} && ./hammer build")
(setq compilation-scroll-output t)
(setq is-ecb-active nil)

(defun ecb-toggle-proc ()
  (interactive)
  (if is-ecb-active
      ((lambda () (setq is-ecb-active nil) (ecb-deactivate)))
    ((lambda () (setq is-ecb-active t) (ecb-activate)))))

(global-set-key (kbd "<f7>") ' recompile)
(global-set-key (kbd "C-x e") ' ecb-toggle-proc)
(global-set-key (kbd "C-x C-k") ' kill-this-buffer)
(global-set-key (kbd "C-<kp-home>") ' beginning-of-buffer)
(global-set-key (kbd "C-<kp-end>") ' end-of-buffer)
(global-set-key [(C tab)] 'buffer-menu)
(global-set-key (kbd "M-g") 'goto-line)


;;(require 'maxframe)
;;(add-hook 'window-setup-hook 'maximize-frame t)

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;;
;; ecb-eshell-recenter
;; ecb-eshell-buffer-sync

(setq path-to-ctags "/usr/bin/ctags-exuberant") ;; <- your ctags path here
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
    (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name)))
  )

(setq path-to-cpplint "/home/amesk/bin/cpplint")
(setq path-to-dcpplint "/home/amesk/bin/dcpplint")
(setq cpplint-buffer-name "*cpplint*")

(defun cpplint ()
  "Invokes cpplint on a current buffer"
  (interactive)
  (get-buffer-create cpplint-buffer-name)
  (shell-command
   (format "%s %s" path-to-cpplint  buffer-file-name)
   cpplint-buffer-name cpplint-buffer-name)
  (switch-to-buffer cpplint-buffer-name)
  (compilation-mode)
  )
(global-set-key (kbd "C-x C-g") ' cpplint)

(defun dcpplint (dir-name)
  "Invokes cpplint on a current buffer"
  (interactive "DDirectory: ")
  (get-buffer-create cpplint-buffer-name)
  (shell-command
   (format "%s %s" path-to-dcpplint dir-name)
   cpplint-buffer-name cpplint-buffer-name)
  (switch-to-buffer cpplint-buffer-name)
  (compilation-mode)
  )
(global-set-key (kbd "C-x M-g") ' dcpplint)

(defun beautify_cpp ()
  "Invokes C++ beautifier on a current buffer"
  (interactive)
  (shell-command
   (format "%s %s" "~/bin/beautify_cpp"  buffer-file-name))
   (load-file  buffer-file-name)
   )

; make whitespace-mode use just basic coloring
(setq whitespace-style (quote
                        ( spaces tabs newline space-mark tab-mark newline-mark)))

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

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq column-number-mode t)

;; compile window splits always vertically
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;; People say that this mess up ECB
;;
;; (defadvice split-window (after move-point-to-new-window activate)
;;  "Moves the point to the newly created window after splitting."
;;  (other-window 1))

(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))

;;
;; Resize window (recursive-version)
;;
;; (defun v-resize (key)
;;  "interactively resize the window"
;;  (interactive "cHit +/- to enlarge/shrink")
;;    (cond
;;      ((eq key (string-to-char "+"))
;;         (enlarge-window 1)
;;         (call-interactively 'v-resize))
;;      ((eq key (string-to-char "-"))
;;         (enlarge-window -1)
;;         (call-interactively 'v-resize))
;;      (t (push key unread-command-events))))
;; (global-set-key "\C-c+" 'v-resize)

;;
;; Resize window interactively
;;
(defvar enlarge-window-char ?+)
(defvar shrink-window-char ?-)
(defun resize-window (&optional arg)
  "Interactively resize the selected window.
  Repeatedly prompt whether to enlarge or shrink the window until the
  response is neither `enlarge-window-char' or `shrink-window-char'.
  When called with a prefix arg, resize the window by ARG lines."
  (interactive "p")
  (let ((prompt (format "Enlarge/Shrink window (%c/%c)? "
                        enlarge-window-char shrink-window-char))
        response)
    (while (progn
             (setq response (read-event prompt))
             (cond ((equal response enlarge-window-char)
                    (enlarge-window arg)
                    t)
                   ((equal response shrink-window-char)
                    (enlarge-window (- arg))
                    t)
                   (t nil))))
    (push response unread-command-events)))

(global-set-key (kbd "C-x w") 'resize-window)

(load-file '"~/.emacs.d/amesk/cmake-mode.el")

(setq uninav-page-script "~/projects/uninav-page-muse/uninav-page-muse.el")
(if (file-exists-p uninav-page-script) (load-file uninav-page-script) )

;;; init.el ends here
