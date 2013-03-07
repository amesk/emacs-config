;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;
;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Load path etc.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; Load up ELPA, the package manager

(add-to-list 'load-path dotfiles-dir)

(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

(add-to-list 'load-path (concat dotfiles-dir "/plugins"))
(add-to-list 'load-path (concat dotfiles-dir "/rc"))

;; (require 'package)
;; (dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
;;                   ("elpa" . "http://tromey.com/elpa/")))
;;   (add-to-list 'package-archives source t))
;; (package-initialize)
;; ;; (require 'starter-kit-elpa)
;; (require 'emacs-rc-elpa)

;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

;; backport some functionality to Emacs 22 if needed
;; (require 'dominating-file)

;; Load up starter kit customizations

;; (require 'starter-kit-defuns)
;; (require 'starter-kit-bindings)
;; (require 'starter-kit-misc)
;; (require 'starter-kit-registers)
;; (require 'starter-kit-eshell)
;; (require 'starter-kit-lisp)
;; (require 'starter-kit-perl)
;; (require 'starter-kit-ruby)
;; (require 'starter-kit-js)

;;; Ripped from starter-kit-defuns.el
;; (defun regen-autoloads (&optional force-regen)
;;   "Regenerate the autoload definitions file if necessary and load it."
;;   (interactive "P")
;;   (let ((autoload-dir (concat dotfiles-dir "/elpa-to-submit"))
;;         (generated-autoload-file autoload-file))
;;     (when (or force-regen
;;               (not (file-exists-p autoload-file))
;;               (some (lambda (f) (file-newer-than-file-p f autoload-file))
;;                     (directory-files autoload-dir t "\\.el$")))
;;       (message "Updating autoloads...")
;;       (let (emacs-lisp-mode-hook)
;;         (update-directory-autoloads autoload-dir))))
;;   (load autoload-file))
;;
;; (regen-autoloads)

;; You can keep system- or user-specific customizations here
;; (setq system-specific-config (concat dotfiles-dir system-name ".el")
;;       user-specific-config (concat dotfiles-dir user-login-name ".el")
;;       user-specific-dir (concat dotfiles-dir user-login-name))
;; (add-to-list 'load-path user-specific-dir)
;;
;; (if (file-exists-p system-specific-config) (load system-specific-config))
;; (if (file-exists-p user-specific-dir)
;;   (mapc #'load (directory-files user-specific-dir nil ".*el$")))
;; (if (file-exists-p user-specific-config) (load user-specific-config))

;;; init.el ends here

(put 'scroll-left 'disabled nil)

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

(push "~/.emacs.d/plugins" load-path)

(setq amesk/config-base "~/.emacs.d/")
(setq amesk/rc-files-base (concat  dotfiles-dir "rc/"))

(load-file (concat amesk/rc-files-base "emacs-rc-elpa.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-defuns.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-force-load.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-eshell.el"))
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
(load-file (concat amesk/rc-files-base "emacs-rc-text-translator.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-edit-server.el"))
(load-file (concat amesk/rc-files-base "emacs-rc-misc.el"))

(let* ((fname (concat amesk/rc-files-base "emacs-rc-local-" (amesk/get-short-hostname) ".el")))
  (when (file-exists-p fname)
    (load fname)))

(server-start)

(load custom-file 'noerror)

;;; init.el ends here
