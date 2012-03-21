(global-set-key (kbd "<f7>") ' recompile)
(global-set-key (kbd "C-x e") ' amesk/ecb-toggle-proc)
(global-set-key (kbd "C-x C-k") ' kill-this-buffer)
(global-set-key (kbd "C-<kp-home>") ' beginning-of-buffer)
(global-set-key (kbd "C-<kp-end>") ' end-of-buffer)
(global-set-key [(C tab)] 'buffer-menu)
(global-set-key (kbd "C-x w") 'amesk/resize-window)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-x C-g") ' amesk/cpplint)
(global-set-key (kbd "C-x M-g") ' amesk/dcpplint)
(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))
