(setq inhibit-startup-message t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(set-fringe-mode 10)

(menu-bar-mode   -1)

(setq visible-bell t)



(use-package autumn-light-theme
  :ensure t
  :config
  (load-theme 'autumn-light t))

;;(load-theme 'autumn-light t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-babel-load-languages '((C . t)))
 '(package-selected-packages
   '(lsp-mode rustic rust-mode flycheck-rust pdf-tools ereader nov edit-indirect org-download org-pomodoro org-bullets magit elmacro anki-editor go-mode langtool emms org ## use-package company-irony flycheck autumn-light-theme company-c-headers company slime))
 '(warning-suppress-log-types '((comp)))
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "wheat" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width condensed :foundry "FBI " :family "Input Mono Condensed")))))


(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;;(add-hook 'after-init-hook 'global-flycheck-mode)
;;(add-to-list 'company-backends 'company-c-headers)
(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;;(with-eval-after-load 'rust-mode
;;  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))


(use-package company-irony
  :ensure t
  :config
  (eval-after-load 'company
 '(add-to-list 'company-backends 'company-irony)))

;;(setq company-minimum-prefix-length 1)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package org
  :ensure t
  :config
  (setq org-agenda-files '("~/todo.org")))

;;(use-package langtool
;;  :ensure t
;;  :init (setq langtool-language-tool-jar
;;	      "~/ext-git/langtool/LanguageTool-5.8-stable/languagetool-commandline.jar"))

(use-package anki-editor
  :ensure t
  :config
  (setq anki-editor-create-decks t))

(use-package lsp-mode)

(use-package rustic)


;;(require 'org-download)

;; Drag-and-drop to `dired`
;;(add-hook 'dired-mode-hook 'org-download-enable)

;;(setq-default org-download-method 'directory
	      ;;              org-download-image-dir "~/Desktop/school/anki/Engineering/imgs/"
;;	      org-download-image-dir "./imgs/"
;;              org-download-heading-lvl nil
;;              org-download-delete-image-after-download t
;;              org-download-screenshot-method "flameshot gui --raw > %s"
;;              org-download-image-org-width 600
;;             org-download-annotate-function (lambda (link) "") ;; Don't annotate
;;              )

(defun pond-anki-boilerplate ()
  "Generate note of type 'Basic' with text input"
  (interactive)
  (insert "** "(read-string "Enter Note Name:"))

  (insert "\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:END:\n")

  (insert "*** Front\n"(read-string "Enter Front:"))

  (insert "\n")
  (insert "*** Back\n"(read-string "Enter Back:"))
  (insert "\n"))

(global-set-key (kbd "C-`") 'pond-anki-boilerplate)


(global-set-key (kbd "<print>") 'org-download-screenshot)


(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package edit-indirect
  :ensure t
)

(use-package magit)


;;(use-package pdf-tools
;;   :ensure t
;;   :pin manual
;;   :config
;;   (pdf-tools-install)
;;   (setq-default pdf-view-display-size 'fit-width)
;;   (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
;;   :custom
;;   (pdf-annot-activate-created-annotations t "automatically annotate highlights"))




(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "$SHELL --login -c 'echo $PATH'"
						    ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)
