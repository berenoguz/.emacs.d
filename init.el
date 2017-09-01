;;; (toggle-frame-fullscreen)

(require 'package)

;;; Theme

(set-frame-font "Inconsolata 7" nil t)

(add-to-list 'custom-theme-load-path ".emacs.d/el-get/color-theme-zenburn")

(load-theme 'zenburn t)

(menu-bar-mode -1)

(tool-bar-mode -1)

(toggle-scroll-bar -1)

(fringe-mode '(0 . nil))

(global-linum-mode t)

(add-hook 'eshell-mode-hook (lambda () (linum-mode -1)))

(add-hook 'term-mode-hook (lambda () (linum-mode -1)))

;;; Buffers

(setq inhibit-startup-buffer-menu 1)

(setq inhibit-startup-screen 1)

;;; (eshell)

;;; (switch-to-buffer "*eshell*")

;;; (split-window nil nil 'right)

(dired "~/src/")

(switch-to-buffer "src")

;;; Packages

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
	     '("marmalade" . "http://marmalade-repo.org/packages/")
	     )

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

(el-get 'sync)

(el-get-update-all t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("131043f822be33d13af0475fa83c8e795b010b2c30fcc0d334403e208ace7c28" default)))
 '(package-selected-packages (quote (auctex))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'erase-buffer 'disabled nil)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

;; Okular

(setq TeX-view-program-list '(("Okular" "okular --unique %u")))

(add-hook 'LaTeX-mode-hook '(lambda ()
                  (add-to-list 'TeX-expand-list
                       '("%u" Okular-make-url))))

(defun Okular-make-url () (concat
               "file://"
               (expand-file-name (funcall file (TeX-output-extension) t)
                         (file-name-directory (TeX-master-file)))
               "#src:"
               (TeX-current-line)
               (expand-file-name (TeX-master-directory))
               "./"
               (TeX-current-file-name-master-relative)))

(setq TeX-view-program-selection '((output-pdf "Okular")))

;; Key bindings

(global-unset-key (kbd "<menu>"))
(global-set-key (kbd "<menu> e") (lambda () (interactive) (insert "^{}") (backward-char)))
(global-set-key (kbd "<menu> 2") (lambda () (interactive) (insert "^2")))
(global-set-key (kbd "<menu> 3") (lambda () (interactive) (insert "^3")))
(global-set-key (kbd "<menu> <menu>") 'execute-extended-command)
