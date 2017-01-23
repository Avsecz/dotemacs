;; ESS - Emacs speaks statistics config file

;; install required packages (if they are not installed already):
(install-package 'ess 
		 'ess-R-object-popup
		 'polymode
		 ;; 'r-autoyas 		;maybe ? 
		 )

;; I compiled it from source
;; (add-to-list 'load-path "~/.emacs.d/ess-14.09/lisp/")
(require 'ess-site)
(require 'ess-eldoc) ;; - giving
(require 'ess-R-object-popup)
(define-key ess-mode-map (kbd "C-c C-g") 'ess-R-object-popup)
(define-key comint-mode-map (kbd "C-c C-g") 'ess-R-object-popup)
;; we load ess

;; set style to Rstudio
;; http://stackoverflow.com/questions/17608936/ess-set-tab-whitespace-level
(setq ess-default-style 'RStudio)
;; (setq ess-offset-arguments 'prev-line)

;; optimize the output width
;; 
;; useful to run it everytime you change your window-width with *R* buffer, 
(define-key inferior-ess-mode-map (kbd "C-c w") 'ess-execute-screen-options)
;; set the proper screen width after running R
;; http://stackoverflow.com/questions/12520543/how-do-i-get-my-r-buffer-in-emacs-to-occupy-more-horizontal-space
(add-hook 'ess-R-post-run-hook 'ess-execute-screen-options)



;; (add-hook 'ess-mode-hook 'turn-on-visual-line-mode)

;; enable synthax checking - uses lintr R> install.packages("lintr")
(require 'flycheck)
;; (add-hook 'ess-mode-hook (lambda () (flycheck-mode t)))   ;; enable it manually every time

;; (add-hook 'ess-mode-hook 'flyspell-prog-mode)
;; (add-hook 'ess-mode-hook 'ess-roxy-mode)

;; (setq inferior-R-args "--vanilla") ;; allways run vanilla R
(setq inferior-R-args "--no-restore-data --no-save")
;;(add-hook 'ess-mode-hook 'auto-complete-mode)
(setq ess-ask-for-ess-directory t)  ;;  ask for directory after starting M-x R ?

(setq inferior-ess-same-window nil) ;; open R in the same window ?

;;(speedbar-add-supported-extension ".R")
(setq ess-help-own-frame 'one)
(require 'ess-rutils)
(eval-after-load "ess-rutils"
  '(global-set-key [(control c) (f6)] 'ess-rutils-rsitesearch))


;; this to get rid of .ess_weave() function not found error  
;; (setq ess-swv-processing-command "%s(%s)") 


;; poleg C-c C-z komande
(define-key comint-mode-map (kbd "C-c C-SPC") 'ess-switch-to-inferior-or-script-buffer)
(define-key ess-mode-map (kbd "C-c C-SPC") 'ess-switch-to-inferior-or-script-buffer)
(define-key ess-watch-mode-map (kbd "C-c C-SPC") 'ess-switch-to-end-of-ESS)

;; -----  C-j <-> enter


(define-key ess-mode-map (kbd "RET") 'electric-newline-and-maybe-indent)
(define-key ess-mode-map (kbd "C-j") 'newline-and-indent)

;; ------ knit the R document or .Rmd document
;; https://github.com/alancho/dotemacs/blob/master/sev012/ess.el

(define-key ess-mode-map (kbd "C-c s") 'ess-swv-render)
(define-key markdown-mode-map (kbd "C-c s") 'ess-swv-render)
(define-key ess-mode-map (kbd "C-c v") 'ess-swv-show-chrome)
(define-key markdown-mode-map (kbd "C-c v") 'ess-swv-show-chrome)

(defun ess-swv-render ()
  "Run rmarkdown::render on the current .R/.Rmd file."
  (interactive)
  (ess-swv-run-in-R "rmarkdown::render"))

(defun ess-swv-show-chrome ()
  "Open the file rendered file with google chrome."
  (interactive)
  (ess-swv-run-in-R "rmarkdown_open_chrome"))

(defun ess-swv-show-firefox ()
  "Open the file rendered file with google chrome."
  (interactive)
  (ess-swv-run-in-R "rmarkdown_open_firefox"))


; ----- insert %>% pipe in ess
(define-key ess-mode-map (kbd "C-<") 'ess-insert-pipe)
(define-key comint-mode-map (kbd "C-<") 'ess-insert-pipe)

(defun ess-insert-pipe ()
  "Insert %>%  at cursor point."
  (interactive)
  (insert " %>% "))

;; ------ insert ##' comment at the point
(define-key ess-mode-map (kbd "M-_") 'ess-insert-spin-text)

(defun ess-insert-spin-text ()
  "Insert %>%  at cursor point."
  (interactive)
  (insert "##' "))

; ----- insert R code chunk
(define-key markdown-mode-map (kbd "C-c C-s C-c") 'markdown-insert-R-code-chunk)

(defun markdown-insert-R-code-chunk ()
  "Insert a code chunk ```{r}  at cursor point. As with C-M-i in Rstudio."
  (interactive)
  (insert "```{r}\n\n```")
  (previous-line)
)

;; ---- ess after I went through the tutorial-----


;; when you are searching backwards with C-c M-r, move with up/down keys
 (eval-after-load "comint"
        '(progn
           (define-key comint-mode-map [C-up]
             'comint-previous-matching-input-from-input)
           (define-key comint-mode-map [C-down]
             'comint-next-matching-input-from-input)))


;; also recommended for ESS use (after output in shell, go to the bottom) --
(setq comint-scroll-to-bottom-on-output 'others)
(setq comint-scroll-show-maximum-output t)

(setq ess-history-file t) 
;; only one directory ess 4.3.1
(setq ess-history-directory "~/.R/")
;; (setq ess-history-directory nil)
;; if this is not assigned, then ess will save it to the path where R was called
;; read the ess info page for more information File: 4.2.1  Saving the command History

;;-----> copied from  http://www.emacswiki.org/emacs/ESS-smart-lessthan
(setq ess-S-assign "_")
(setq ess-my-smart-key "<")



(defun ess-insert-S-assign-mod ()
  (interactive)
  (let ((ess-S-assign " <- ") (assign-len (length ess-S-assign))) 
    (if (and
	 (>= (point) (+ assign-len (point-min)))
	 (save-excursion
	   (backward-char assign-len)
	   (looking-at ess-S-assign)))
	(progn
	  (delete-char (- assign-len))
	  (insert ess-my-smart-key))
      (delete-horizontal-space)
      (insert ess-S-assign))))

(defun ess-smart-lt ()
  (interactive)
  (if (or (looking-at ess-S-assign)
	  (ess-inside-string-or-comment-p (point)))
      (insert ess-my-smart-key)
    (ess-insert-S-assign-mod)))

;; (add-hook 'R-mode-hook (lambda () (local-set-key ess-my-smart-key 'ess-smart-lt)))
(add-hook 'ess-mode-hook (lambda () (local-set-key ess-my-smart-key 'ess-smart-lt)))
(add-hook 'inferior-ess-mode-hook (lambda () (local-set-key ess-my-smart-key 'ess-smart-lt)))

;; prvious command like in the usual shell
;; for this to work one has
(define-key comint-mode-map (kbd "C-p") 'comint-previous-input)
(define-key comint-mode-map (kbd "C-n") 'comint-next-input)


;;<----- end copied

;; Add default scripts

(setq yt/ess--RProfile-string "
#### change this file name to .Rprofile and place to ~/userName so when R starts, the following command will be processed automatically

## http://stackoverflow.com/questions/1189759/expert-r-users-whats-in-your-rprofile
options(repos=structure(c(CRAN=\"http://ftp5.gwdg.de/pub/misc/cran/\")))
options(browser = \"google-chrome\")

options(\"digits.secs\"=3)            # show sub-second time stamps

require(data.table)
options(datatable.prettyprint.char = 25)

render_pdf <- function(f){
    rmarkdown::render(f,output_format=\"pdf_document\")
}

install_bioc <- function(...){
  source(\"https://bioconductor.org/biocLite.R\")
  biocLite(...)
}

rmarkdown_open_chrome <- function(input, ...){
    ## substitute .R with .html
    html_input <- gsub(\"\\.R$\",\"\\.html\",input)
    browseURL(html_input, browser=\"google-chrome\")
}

## improved list of objects
.ls.objects <- function (pos = 1, pattern, order.by,
                 decreasing=FALSE, head=FALSE, n=5)
    {
        napply <- function(names, fn) sapply(names, function(x)
            fn(get(x, pos = pos)))
        names <- ls(pos = pos, pattern = pattern)
        obj.class <- napply(names, function(x) as.character(class(x))[1])
        obj.mode <- napply(names, mode)
        obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
        obj.prettysize <- napply(names, function(x) {
                                    capture.output(print(object.size(x), units = \"auto\")) })
        obj.size <- napply(names, object.size)
        obj.dim <- t(napply(names, function(x)
            as.numeric(dim(x))[1:2]))
        vec <- is.na(obj.dim)[, 1] & (obj.type != \"function\")
        obj.dim[vec, 1] <- napply(names, length)[vec]
        out <- data.frame(obj.type, obj.size, obj.prettysize, obj.dim)
        names(out) <- c(\"Type\", \"Size\", \"PrettySize\", \"Rows\", \"Columns\")
        if (!missing(order.by))
            out <- out[order(out[[order.by]], decreasing=decreasing), ]
        if (head)
            out <- head(out, n)
        out
    }
## shorthand
lsos <- function(..., n=10) {
    .ls.objects(..., order.by=\"Size\", decreasing=TRUE, head=TRUE, n=n)
}")

(add-hook 'ess-post-run-hook
          (lambda ()
            (goto-char (point-max))
            (insert yt/ess--RProfile-string)
            (inferior-ess-send-input) ;; execuate the R scripts
            ;; clean up
            (search-backward "Type 'q()' to quit R.")
            (next-line)
            (delete-region (point) (point-max))
            (inferior-ess-send-input)
	    (add-hook 'ess-post-run-hook 'ess-tracebug) ;http://stackoverflow.com/questions/8910695/r-debugging-code-from-emacs-using-ess-tracebug
            ))


;; orgstruct
;; (add-hook 'ess-mode-hook '(lambda ()
;;                               (turn-on-orgstruct)
;;                               (setq-local outline-regexp "##*\\*+\\|\\`")
;; 			      (setq-local orgstruct-heading-prefix-regexp "##*\\*+\\|\\`")
;; 			      (progn (orgstruct-mode) (org-global-cycle 3))
;; 			      ))
(add-hook 'ess-mode-hook '(lambda ()
                              (turn-on-orgstruct)
			      (flyspell-prog-mode)
                              (setq-local orgstruct-heading-prefix-regexp "#### ")))
;; insert 
(global-set-key (kbd "<f7> o") "## Local Variables:
## outline-regexp: \"##*\\\\*+\\\\|\\\\`\"
## orgstruct-heading-prefix-regexp: \"##*\\\\*+\\\\|\\\\`\"
## eval: (progn (orgstruct-mode) (org-global-cycle 3))
## End: ")

;; (add-hook 'ess-mode-hook
;;       '(lambda ()
;;          (auto-complete-mode nil)
;;          (outline-minor-mode 1)
;;          (setq outline-regexp "\\(^#\\{4,6\\}\\)\\|\\(^[a-zA-Z0-9_\.]+ ?<- ?function(.*{\\)")
;;          (setq outline-heading-alist
;;            '(("##' ##" . 1) ("##' ###" . 2) ("##' ####" . 3)
;;              ("^[a-zA-Z0-9_\.]+ ?<- ?function(.*{" .4)))))
;;--------------------------------------------------------------
;; poly mode - for Rmarkdown
;; (setq load-path
;;       (append '("~/.emacs.d/polymode/"  "~/.emacs.d/polymode/modes")
;;               load-path))

(require 'poly-R)
(require 'poly-markdown)
(require 'poly-org)
(require 'poly-noweb)
;; ;; had to install pandoc on linux

;; ;;; MARKDOWN
;; (add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.org" . poly-org-mode))

;; ;;; R modes
;; (add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
;; (add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

;; --------------------------------------------

;; custom variables
(custom-set-variables
  '(ess-R-font-lock-keywords
   (quote
    ((ess-R-fl-keyword:modifiers . t)
     (ess-R-fl-keyword:fun-defs . t)
     (ess-R-fl-keyword:keywords . t)
     (ess-R-fl-keyword:assign-ops . t)
     (ess-R-fl-keyword:constants . t)
     (ess-fl-keyword:fun-calls . t)
     (ess-fl-keyword:numbers . t)
     (ess-fl-keyword:operators . t)
     (ess-fl-keyword:delimiters . t)
     (ess-fl-keyword:=)
     (ess-R-fl-keyword:F&T))))
)
