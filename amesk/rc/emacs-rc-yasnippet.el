(add-to-list 'load-path "~/emacs/yasnippet")
(require 'yasnippet)

(yas/initialize)
(eval-after-load 'yasnippet
  '(progn
    (setq yas/snippet-dirs (concat amesk/config-base "snippets"))
    (yas/load-snippet-dirs)))

;; (setq yas/root-directory (concat amesk/config-base "snippets"))
;; (yas/global-mode 1)
;; (setq yas/snippet-dirs (concat amesk/config-base "snippets"))
;; (yas/load-snippet-dirs)
;; (yas/load-directory yas/root-directory)

;; hook for automatic reloading of changed snippets
(defun amesk/update-yasnippets-on-save ()
  (when (string-match yas/root-directory buffer-file-name)
    (yas/load-snippet-dirs)
    ))

(add-hook 'after-save-hook 'amesk/update-yasnippets-on-save)
