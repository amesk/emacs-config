;;; -*- Mode: Emacs-Lisp -*-
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  This is the first thing to get loaded.
;;
;;  "Emacs outshines all other editing software in approximately the
;;  same way that the noonday sun does the stars. It is not just bigger
;;  and brighter; it simply makes everything else vanish."
;;  -Neal Stephenson, "In the Beginning was the Command Line"
;;
;;  File: init.el
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

;;; Where all the magic begins

;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Load path etc.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(setq amesk/config-base dotfiles-dir)
(setq amesk/rc-files-base (concat  dotfiles-dir "rc/"))

(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "/plugins"))
(add-to-list 'load-path (concat dotfiles-dir "/rc"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

(push "~/.emacs.d/plugins" load-path)

(setq rc-list (list "rc-elpa.el"
                    "rc-defuns.el"
                    "rc-force-load.el"
                    "rc-eshell.el"
                    "rc-maxframe.el"
                    "rc-ecb.el"
                    "rc-tags.el"
                    "rc-cpplint.el"
                    "rc-yasnippet.el"
                    "rc-auto-insert.el"
                    "rc-reverse-input-method.el"
                    "rc-customize-cpp-devel.el"
                    "rc-muse.el"
                    "rc-text-translator.el"
                    "rc-edit-server.el"
                    "rc-registers.el"
                    "rc-org-mode.el"
                    "rc-ispell.el"
                    "rc-misc.el"
                    "rc-project-uninav.el"
                    "rc-win-resize.el"
                    "rc-keybindings.el"))

(dolist (m rc-list) (load-file (concat amesk/rc-files-base m)))

(if (fboundp 'amesk/get-short-hostname)
    (let* ((fname (concat amesk/rc-files-base "rc-local-" (amesk/get-short-hostname) ".el")))
      (when (file-exists-p fname)
        (load fname))))

(load custom-file 'noerror)

;;; init.el ends here
