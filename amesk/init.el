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

(global-set-key (kbd "C-B") ' recompile)
(global-set-key (kbd "C-x e") ' ecb-toggle-proc)
(global-set-key (kbd "C-x C-k") ' kill-this-buffer)
(global-set-key (kbd "C-<kp-home>") ' beginning-of-buffer)
(global-set-key (kbd "C-<kp-end>") ' end-of-buffer)

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
(defun cpplint ()
  "Invokes cpplint on current buffer"
  (interactive)
  (get-buffer-create "*cpplint*")
  (shell-command
   (format "%s %s" path-to-cpplint  buffer-file-name)
   "*cpplint*" "*cpplint*")
  (switch-to-buffer "*cpplint*")
  (compilation-mode)
  )
(global-set-key (kbd "C-x C-g") ' cpplint)

(global-set-key [(C tab)] 'buffer-menu)

;;; init.el ends here
