;; Amesk patches

(defun amesk/get-short-hostname ()
  (let* ((sys-name (system-name))
         (idx (string-match "\\." sys-name)))
    (if idx
        (substring sys-name 0 idx)
      sys-name)))

(setq compile-command "cd ${PWD%/src/*} && ./hammer build")
(setq compilation-scroll-output t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq column-number-mode t)
;; compile window splits always vertically
(setq split-height-threshold 0)
(setq split-width-threshold nil)

(push "~/.emacs.d/amesk/plugins" load-path)

(setq amesk/config-base "~/.emacs.d/amesk/")
(setq amesk/rc-files-base (concat  amesk/config-base "rc/"))

(load-file (concat amesk/rc-files-base "emacs-rc-force-load.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-maxframe.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-ecb.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-tags.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-cpplint.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-yasnippet.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-auto-insert.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-interactive-resize-window.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-reverse-input-method.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-customize-cpp-devel.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-keybindings.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-muse.el"))


(let* ((fname (concat amesk/rc-files-base "emacs-rc-local-" (amesk/get-short-hostname) ".el")))
  (when (file-exists-p fname)
    (load fname)))

;;; init.el ends here
