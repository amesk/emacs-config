;; Determine projects location

(cond
 ((equal (amesk/get-short-hostname) "vottl-amesk")
    (setq amesk-projects-base "~/projects/"))
 ((equal (amesk/get-short-hostname) "amesker-5935")
    (setq amesk-projects-base "~/projects/"))
 ((equal (amesk/get-short-hostname) "VOTTD-AMESK7")
    (setq amesk-projects-base "E:/Projects/"))
 (t (amesk-projects-base "undefined")))

;; Now, include muse modules

(require 'muse-mode)
(require 'muse-html)
(require 'muse-colors)
(require 'muse-wiki)
(require 'muse-latex)
(require 'muse-texinfo)
(require 'muse-docbook)
(require 'muse-project)
(require 'muse-book)

;; So, let's roll

(add-to-list 'auto-mode-alist '("\\.muse$" . muse-mode))

(custom-set-variables
 '(muse-html-encoding-default (quote utf-8))
 '(muse-html-meta-content-encoding (quote utf-8))
 '(muse-html-charset-default "utf-8")
 '(muse-file-extension "muse")
 '(muse-mode-auto-p nil)
 '(muse-wiki-allow-nonexistent-wikiword nil)
 '(muse-wiki-use-wikiword nil)
 '(muse-ignored-extensions (quote ("bz2" "gz" "[Zz]" "rej" "orig" "png" "gitignore" "gif"
                                   "css" "jpg" "html" "sh" "lftp" "pdf")))
 '(muse-html-table-attributes '"border=\"1\" cellspacing=\"0\"")
 )

(defun amesk-muse-mode-hook ()
  (setq auto-fill-mode t)
  (flyspell-mode 1)
  (footnote-mode 1)
  )
(add-hook 'muse-mode-hook 'amesk-muse-mode-hook)

(setq uninav-page-muse-base (concat amesk-projects-base "uninav-page-muse/"))
(setq amesk-blogspot-base (concat amesk-projects-base "amesk-blogspot/"))

(muse-derive-style "uninav-page-html" "html"
                   :header (concat uninav-page-muse-base "header.tmpl")
                   :footer (concat uninav-page-muse-base "footer.tmpl"))

(muse-derive-style "amesk-blogspot-html" "html"
                   :header ""
                   :footer ""
                   :style-sheet "")

(muse-derive-style "uninav-page-pdf" "pdf"
                   :header (concat uninav-page-muse-base "header.tex")
                   :footer (concat uninav-page-muse-base "footer.tex"))

(setq muse-project-alist
      `(
        ("uninav-page"
          (,@(muse-project-alist-dirs uninav-page-muse-base) :default "index")
          ,@(muse-project-alist-styles uninav-page-muse-base
                                       uninav-page-muse-base
                                       "uninav-page-html")
          (:base "uninav-page-pdf"
                 :path (concat uninav-page-muse-base "/en")
                 :include "/alexott-cv-en[^/]*$")
          (:base "uninav-page-pdf"
                 :path (concat uninav-page-muse-base "/ru")
                 :include "/alexott-cv-ru[^/]*$"))
               )
             )

(setq  uninav-spec-base
       (expand-file-name (concat uninav-page-muse-base
                                 "ru/UniNav/UNINAV_2_spec/")))

(muse-derive-style "uninav-spec-book-pdf" "book-pdf"
                   :header (concat uninav-page-muse-base "book-header.tex")
                   :footer (concat uninav-page-muse-base "book-footer.tex")
                   :publish 'muse-book-publish)

(add-to-list 'muse-project-alist
             `("UNINAV_2_spec"
               (:nochapters t  ; do automatically add chapters
                :book-chapter "Основная спецификация"
                ,(concat uninav-spec-base "index")

                :book-chapter "Внутренние подсистемы"
                ,(concat uninav-spec-base "AddInfoServer")
                ,(concat uninav-spec-base "MagnDeclination")
                ,(concat uninav-spec-base "NavKernel")
                ,(concat uninav-spec-base "Playback")
                ,(concat uninav-spec-base "QtWidgets")
                ,(concat uninav-spec-base "TargetsTracks")
                ,(concat uninav-spec-base "ShipLogBook")
                ,(concat uninav-spec-base "Multiunits")
                ,(concat uninav-spec-base "OnlineCheckRoute")
                ,(concat uninav-spec-base "ShipTrack")
                ,(concat uninav-spec-base "Opersit")
                ,(concat uninav-spec-base "SystemLogBook ")

                :book-chapter "Картография и математика"
                ,(concat uninav-spec-base "GeoCalcSimplifiedItf")
                ,(concat uninav-spec-base "ChartToolbar")
                ,(concat uninav-spec-base "PolarGeoCalc")

                :book-chapter "Пользовательский интерфейс"
                ,(concat uninav-spec-base "MultiunitsPage")
                ,(concat uninav-spec-base "MonitoringPage")
                ,(concat uninav-spec-base "NavigationPage")

                :book-chapter "Подключение к  MFD"
                ,(concat uninav-spec-base "PureSlaveNavData")
                ,(concat uninav-spec-base "PureSlaveCharts")

                :book-chapter "Инсталляционный пакет"
                ,(concat uninav-spec-base "WindowsInstaller")
                ,(concat uninav-spec-base "DebianInstaller")

                :book-end t ; the rest will not be placed in the book
                :default "index")
              (:base "uninav-spec-book-pdf"
               :path "~/public_pdf"
               :include ,(concat uninav-spec-base "index.*$"))
              ))


;; (add-to-list 'muse-project-alist
;;              `("amesk-blogspot" (,@(muse-project-alist-dirs amesk-blogspot-base)
;;                                  :default "index")
;;                ,@(muse-project-alist-styles amesk-blogspot-base
;;                                        amesk-blogspot-base
;;                                       "amesk-blogspot-html")))

(defun muse-gen-relative-name (name)
  (concat
   (file-name-directory (muse-wiki-resolve-project-page (muse-project)))
   name))

(defun muse-mp-detect-language ()
  (let ((lang "NN")
        (cur-dir (file-name-directory (muse-current-file)))
        )
    (let ((smatch (string-match "/\\(ru\\|en\\|de\\)/" cur-dir)))
      (when smatch
        (setq lang (substring cur-dir (+ smatch 1) (+ smatch 3)))))
    lang))

(load-file (concat uninav-page-muse-base "/uninav-page-menu.el"))

(defun muse-uninav-generate-menu ()
  (let* ((menu-lang (muse-mp-detect-language))
         (menu-struct (assoc menu-lang uninav-page-menu))
         (menu-string "")
         (rel-dir (file-name-directory (muse-wiki-resolve-project-page (muse-project))))
         (rel-path (if (> (length rel-dir) 2)   (substring rel-dir 3) ""))
         (cur-path-muse (muse-current-file))
         (cur-path-html (replace-regexp-in-string "\\.muse" ".html" cur-path-muse))
         )
      (when menu-struct
        (let ((menu-list (if (not (null menu-struct)) (cdr menu-struct))))
          (setq menu-string
                (concat "<ul class=\"avmenu\">"
                        (apply #'concat
                               (mapcar
                                (lambda (x)
                                  (concat "<li><a href=\"" rel-path (car x)
                                          (if (string-match (concat "/" menu-lang "/" (car x))
                                                            cur-path-html)
                                              "\" class=\"current\""
                                            "\"")
                                          ">" (cdr x) "</a></li>"))
                                menu-list))
                        "</ul>"))))
      menu-string))

(defun muse-get-current-project-root (fname)
  (let ((dname (file-truename (file-name-directory fname)))
        (rname (file-name-directory (muse-wiki-resolve-project-page (muse-project)))))
    (file-truename (concat dname rname))))

(defun muse-get-file-relative-name (fname)
  (substring (file-truename fname) (length (muse-get-current-project-root fname))))

(defun generate-change-date (file)
  (when (file-exists-p file)
    (let* ((fa (file-attributes file))
           (mod-time (nth 6 fa)))
      (format-time-string "%d.%m.%Y %R" mod-time))))
