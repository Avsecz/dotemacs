;; config for markdown and wiki

(install-package 'markdown-mode 
		 'mediawiki
		 'gnuplot
		 'gnuplot-mode
		 )

;; --------------------------------------------
;; wiki

(require 'mediawiki)
(define-key mediawiki-mode-map (kbd "C-c C-n") 'mediawiki-next-header)
(define-key mediawiki-mode-map (kbd "C-c C-p")   'mediawiki-prev-header)
;; call mywiki by M-x mywiki
(defun wiki()
  (interactive)(mediawiki-site "mywiki")
  )
;; (global-set-key (kbd "C-...") 'wiki)

;; Setup mediawiki pages
(custom-set-variables
 '(mediawiki-site-alist
   (quote
    (("Wikipedia" "http://en.wikipedia.org/w/" "username" "password" "Main Page")
     ("mywiki" "http://gagneurweb.genzentrum.lmu.de/wiki/" "" "" "aggagneur:BayesRare_home"))))
)

;; --------------------------------------------
;; markdown

(require 'markdown-mode)

;; (autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t) 
(add-to-list 'auto-mode-alist'("\\.md" . markdown-mode))
;; word count shortcut
(define-key markdown-mode-map (kbd "C-c C-RET") 'count-words)

;; --------------------------------------------
;; gnuplot

;; specify the gnuplot executable (if other than /usr/bin/gnuplot)
(setq gnuplot-program "/usr/bin/gnuplot")

(require 'gnuplot)
;; ;; specify the gnuplot executable (if other than /usr/bin/gnuplot)
(setq gnuplot-program "/usr/bin/gnuplot")

;; ;; automatically open files ending with .gp or .gnuplot in gnuplot mode
(add-to-list 'auto-mode-alist
	     '("\\.\\(gnu\\|gnuplot\\)$" . gnuplot-mode) t)
