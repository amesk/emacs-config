(require 'maxframe)

(defun amesk/try-maximize ()
  (when (display-graphic-p)
    (if (eq system-type 'gnu/linux)
        (toggle-fullscreen)
      (maximize-frame))))

(add-hook 'window-setup-hook 'amesk/try-maximize)
