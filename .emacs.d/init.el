(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-default-style "stroustrup")
 '(column-number-mode t)
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
	("c7a9a68bd07e38620a5508fef62ec079d274475c8f92d75ed0c33c45fbe306bc" "a800120841da457aa2f86b98fb9fd8df8ba682cebde033d7dbf8077c1b7d677a" default)))
 '(custom-theme-directory "~/.emacs.d/themes")
 '(doc-view-resolution 200)
 '(electric-pair-mode t)
 '(explicit-shell-file-name nil)
 '(jdee-compiler (quote ("javac")))
 '(jdee-jdk (quote ("1.8")))
 '(jdee-jdk-registry
   (quote
	(("1.8" . "/usr/lib/jvm/java-8-openjdk")
	 ("1.8" . "/usr/lib64/jvm/java-8-openjdk"))))
 '(package-selected-packages
   (quote
	(haskell-tab-indent haskell-mode web-mode jdee flycheck irony auto-complete-auctex auto-complete auctex monokai-theme latex-preview-pane helm evil)))
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata for Powerline" :foundry "PfEd" :slant normal :weight normal :height 113 :width normal)))))


(setq evil-want-C-u-scroll t)
(require 'evil)
(require 'auto-complete)

 ;; set auto-complete to work on all modes.
(defun auto-complete-mode-maybe ()
  "No maybe for you. Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))

(server-start)
(evil-mode 1)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(latex-preview-pane-enable)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-auto-complete-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)
(global-linum-mode 1)
(setq tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-indent-mode))

(require 'cc-mode)
(setq-default c-basic-offset 4
	      tab-width 4
	      indent-tabs-mode t)
(add-to-list 'c-mode-common-hook
(lambda () (setq c-syntactic-indentation nil)))
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))

   ;;; C-c as general purpose escape key sequence.
   ;;;
(defun my-esc (prompt)
  "Functionality for escaping generally.  Includes exiting Evil insert state and C-g binding. "
  (cond
   ;; If we're in one of the Evil states that defines [escape] key, return [escape] so as
   ;; Key Lookup will use it.
   ((or (evil-insert-state-p) (evil-normal-state-p) (evil-replace-state-p) (evil-visual-state-p)) [escape])
   ;; This is the best way I could infer for now to have C-c work during evil-read-key.
   ;; Note: As long as I return [escape] in normal-state, I don't need this.
   ;;((eq overriding-terminal-local-map evil-read-key-map) (keyboard-quit) (kbd ""))
   (t (kbd "C-g"))))
(define-key key-translation-map (kbd "C-q") 'my-esc)
;; Works around the fact that Evil uses read-event directly when in operator state, which
;; doesn't use the key-translation-map.
(define-key evil-operator-state-map (kbd "C-q") 'keyboard-quit)
;; Not sure what behavior this changes, but might as well set it, seeing the Elisp manual's
;; documentation of it.
(set-quit-char "C-q")
