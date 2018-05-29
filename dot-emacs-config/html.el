;; configuration for web development:
;; html, css 

(install-package 'web-mode
		 'auto-complete
		 'emmet-mode
		 'php-auto-yasnippets
		 'ac-emmet
		 'ac-html
		 'company
		 'company-web
		 'js3-mode
		 'tern
		 'tern-auto-complete
		 'nodejs-repl
		 'tide
		 'restclient
		 'restclient-helm
		 'mmm-mode
		 'mmm-jinja2
		 'jinja2-mode
		 )


(require 'mmm-jinja2)
(require 'web-mode)
(require 'auto-complete)
(require 'emmet-mode)
(require 'php-auto-yasnippets)
(require 'ac-emmet)

;; conveniently quiery with REST api
;; http://emacsrocks.com/e15.html
(require 'restclient)
(require 'restclient-helm)

;; company mode
;; http://blog.binchen.org/posts/code-completion-for-htmljscss-in-emacs.html
(require 'company)
(require 'company-web-html)
(require 'company-web-jade)

;; Open files with
(define-key web-mode-map (kbd "C-c v") 'browse-url-of-buffer)

;; associate files with web-mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;; django-mode
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;; open plain html's with web mode
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; also edit css and xml
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml\\'" . web-mode))

;; Engines
(setq web-mode-engines-alist
      '(
        ("php" . "\\.phtml\\'")
        ("blade" . "\\.blade\\'")
        ("django" . "\\.[sd]tpl\\'")
        ("django" . "\\.[sd]tml\\'")
        ))




;; disable arguments|concatenation|calls lineup with
(add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))


;; context-aware auto-completion
(setq web-mode-ac-sources-alist
      '(("php" . (ac-source-yasnippet ac-source-php-auto-yasnippets))
	("html" . (ac-source-emmet-html-aliases ac-source-emmet-html-snippets))
	("css" . (ac-source-css-property ac-source-emmet-css-snippets))))

(add-hook 'web-mode-hook (lambda ()
			   (set (make-local-variable 'company-backends) '(company-web-html))
			   (company-mode t)))

(add-hook 'web-mode-before-auto-complete-hooks
          '(lambda ()
             (let ((web-mode-cur-language
                    (web-mode-language-at-pos)))
               (if (string= web-mode-cur-language "php")
                   (yas-activate-extra-mode 'php-mode)
                 (yas-deactivate-extra-mode 'php-mode))
               (if (string= web-mode-cur-language "css")
                   (setq emmet-use-css-transform t)
                 (setq emmet-use-css-transform nil))
               )))


(setq web-mode-ac-sources-alist
      '(("css" . (ac-source-css-property))
	("html" . (ac-source-words-in-buffer ac-source-abbrev))))

;; Settings
(setq-default web-mode-enable-auto-pairing t
              web-mode-enable-auto-opening t
              web-mode-enable-auto-indentation t
              web-mode-enable-block-face t
              web-mode-enable-part-face t
              web-mode-enable-comment-keywords t
              web-mode-enable-css-colorization t
              web-mode-enable-current-element-highlight t
              web-mode-enable-heredoc-fontification t
	      ;; 
              web-mode-enable-engine-detection t
              web-mode-markup-indent-offset 2
              web-mode-css-indent-offset 2
              web-mode-code-indent-offset 2
              web-mode-style-padding 2
              web-mode-script-padding 2
              web-mode-block-padding 0
              web-mode-comment-style 2
	      web-mode-tag-autocomplete-style 2
	      )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Javascript - js3 mode
(autoload 'js3-mode "js3" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))

;; ------------------------------------
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; ------------------------------------

;; load tern
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

(add-hook 'js3-mode-hook
	  (lambda ()
	    (setq js3-auto-indent-p t
		  js3-curly-indent-offset 0
		  js3-enter-indents-newline t
		  js3-expr-indent-offset 2
		  js3-indent-on-enter-key t
		  js3-lazy-commas t
		  js3-lazy-dots t
		  js3-lazy-operators t
		  js3-paren-indent-offset 2
		  js3-square-indent-offset 4)
	    (linum-mode 1)))

;; https://github.com/Fuco1/smartparens/issues/239
;; (defadvice js3-enter-key (after fix-sp-state activate)
;;   (setq sp-last-operation 'sp-self-insert))

;; (sp-local-pair 'js3-mode
;;                "{"
;;                nil
;;                :post-handlers
;;                '((ome-create-newline-and-enter-sexp js3-enter-key))))
(add-to-list 'ac-modes 'js3-mode)
