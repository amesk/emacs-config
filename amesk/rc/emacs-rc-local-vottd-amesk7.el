(when (string-equal system-type "windows-nt")
(progn
(setq cygwin-bin "c:\\cygwin\\bin")
(setq gnu-bin "C:\\GnuWin32\\gnuwin32\\bin")
(setenv "PATH"
(concat cygwin-bin ";" gnu-bin ";" (getenv "PATH")))
(setq exec-path '(cygwin-bin gnu-bin))))
(setq grep-use-null-device nil)
(setq grep-find-use-xargs t)
(grep-compute-defaults)
