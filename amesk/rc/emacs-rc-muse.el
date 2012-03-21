(cond
 ((equal (amesk/get-short-hostname) "vottl-amesk")
    (setq uninav-page-muse-base "~/projects/uninav-page-muse/"))
 ((equal (amesk/get-short-hostname) "VOTTD-AMESK7")
    (setq uninav-page-muse-base "E:/Projects/uninav-page-muse/"))
 (t (uninav-page-muse-base "undefined")))

(setq uninav-page-script (concat uninav-page-muse-base "uninav-page-muse.el"))
(if (file-exists-p uninav-page-script) (load-file uninav-page-script) )
