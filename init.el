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

(add-to-list 'load-path dotfiles-dir)

(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

(add-to-list 'load-path (concat dotfiles-dir "/plugins"))
(add-to-list 'load-path (concat dotfiles-dir "/rc"))

;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

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

(if (fboundp 'amesk/get-short-hostname)
    (let* ((fname (concat amesk/rc-files-base "emacs-rc-local-" (amesk/get-short-hostname) ".el")))
      (when (file-exists-p fname)
        (load fname))))

(load custom-file 'noerror)

;;; init.el ends here
