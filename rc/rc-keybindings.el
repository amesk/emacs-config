;;; -*- Mode: Emacs-Lisp -*-
;;
;;  Copyright (C) 2012 Transas MIP Ltd.
;;
;;  Personal Emacs configuration
;;
;;  Set up some handy key bindings
;;
;;  File: rc-keybindings.el
;;
;;  Author: amesk <alexei.eskenazi@transas.com>
;;

;; You know, like Readline.
(global-set-key (kbd "C-M-h") 'backward-kill-word)

;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; Completion that uses many different methods to find options.
(global-set-key (kbd "M-/") 'hippie-expand)

;; Perform general cleanup.
(global-set-key (kbd "C-c n") 'cleanup-buffer)

;; Turn on the menu bar for exploring new modes
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)

;; Font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Jump to a definition in the current file. (This is awesome.)
(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; File finding
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Window switching. (C-x o goes to the next window)
(windmove-default-keybindings) ;; Shift+direction
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;; back one
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; forward two

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Start a regular shell if you prefer that.
(global-set-key (kbd "C-x M-m") 'shell)

;; Invoke a shell command
(global-set-key (kbd "C-x !") 'shell-command)

;; If you want to be able to M-x without meta (phones, etc)
(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Fetch the contents at a URL, display it raw.
;; (global-set-key (kbd "C-x C-h") 'view-url)

;; Help should search more than just commands
(global-set-key (kbd "C-h a") 'apropos)

;; Should be able to eval-and-replace anywhere.
(global-set-key (kbd "C-c e") 'eval-and-replace)

;; For debugging Emacs modes
(global-set-key (kbd "C-c p") 'message-point)

;; So good!
(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-c q") 'join-line)

(global-set-key (kbd "M-\\") 'kill-forward-whitespace)

;; This is a little hacky since VC doesn't support git add internally
(eval-after-load 'vc
  (define-key vc-prefix-map "i" '(lambda () (interactive)
                                   (if (not (eq 'Git (vc-backend buffer-file-name)))
                                       (vc-register)
                                     (shell-command (format "git add %s" buffer-file-name))
                                     (message "Staged changes.")))))

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;; Org
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(global-set-key (kbd "C-x e") 'amesk/ecb-toggle-proc)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
(global-set-key (kbd "C-<kp-home>") 'beginning-of-buffer)
(global-set-key (kbd "C-<kp-end>") 'end-of-buffer)
(global-set-key [(C tab)] 'buffer-menu)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-x C-g") 'amesk/cpplint)
(global-set-key (kbd "C-x M-g") 'amesk/dcpplint)
(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))
(global-set-key "\C-x\M-t" 'text-translator)

(global-set-key (kbd "C-x b") 'amesk/switch-to-buffer-wrap)

(defun amesk/c-mode-common-hook ()
  (define-key c-mode-base-map (kbd "M-o") 'amesk/switch-h-cpp))
(add-hook 'c-mode-common-hook 'amesk/c-mode-common-hook)

(global-set-key "\C-x\M-t" 'text-translator)

;; Local keys for org-mode
(add-hook 'org-load-hook
            (lambda ()
              (define-key org-mode-map "\C-n" 'org-next-link)
              (define-key org-mode-map "\C-p" 'org-previous-link)))

;; rc-uninav.el keybindings

(global-set-key (kbd "<f7>") 'recompile)
(global-set-key (kbd "<f5>") (lambda () (interactive)(shell-command "cd ~/projects/uninav/out/bin && ./plotter&")))
(global-set-key (kbd "C-c f f") '(lambda () (interactive)(flymake-mode 1)))
(global-set-key (kbd "C-c f F") '(lambda () (interactive)(flymake-mode -1)))
(global-set-key (kbd "C-c f e") 'flymake-display-err-menu-for-current-line)
(global-set-key (kbd "C-c f g") 'flymake-goto-next-error)

;; rc-win-resize.el keybindings

(global-set-key [C-S-up] 'amesk/win-resize-enlarge-horiz)
(global-set-key [C-S-down] 'amesk/win-resize-minimize-horiz)
(global-set-key [C-S-left] 'amesk/win-resize-enlarge-vert)
(global-set-key [C-S-right] 'amesk/win-resize-minimize-vert)

;;; rc-keybindings.el ends here
