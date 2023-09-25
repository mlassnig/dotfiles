;;; package --- Summary

;;; Commentary:
;;;  Don't panic.

;;; Code:
;;;  Don't panic.

;;; Startup
(setq
 gc-cons-threshold most-positive-fixnum
 warning-minimum-level :error)

;;; Packaging
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;; Eye candy
(load-theme 'wombat)
(menu-bar-mode -1)
(when window-system
  (set-frame-font "DejaVuSansM Nerd Font Mono 10")
  (setq frame-resize-pixelwise t)
  (tooltip-mode -1)
  (tool-bar-mode -1))

;;; Global minor modes and configuration
(xterm-mouse-mode 1)
(column-number-mode t)
(delete-selection-mode 1)
(global-font-lock-mode t)
(global-tab-line-mode t)
(line-number-mode t)
(show-paren-mode t)
(transient-mark-mode t)
(toggle-scroll-bar -1)
(setq
 enable-recursive-minibuffers t
 font-lock-maximum-decoration t
 history-length 999
 gdb-many-windows t
 indent-tabs-mode nil
 inhibit-startup-echo-area-message t
 inhibit-startup-screen t
 initial-scratch-message nil
 require-final-newline t
 scroll-conservatively 1
 scroll-preserve-screen-position t
 scroll-step 1
 tab-width 8)
(keymap-set minibuffer-mode-map "TAB" 'minibuffer-complete)
(pixel-scroll-precision-mode)

;;; Encoding
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;;; Backup
(setq
 auto-save-file-name-transforms (\` ((".*" "~/.filebackups" t)))
 backup-by-copying t
 backup-directory-alist (\` ((".*" . "~/.filebackups")))
 delete-old-versions t
 kept-new-versions 99
 kept-old-versions 99
 make-backup-files t
 vc-make-backup-files t
 version-control t)

;;; Mouse
(setq
 mouse-drag-copy-region nil
 mouse-wheel-follow-mouse t
 mouse-wheel-progressive-speed nil
 mouse-wheel-scroll-amount '(3 ((shift) . 3))
 mouse-yank-at-point t)

;;; Keymap
(global-set-key (kbd "ESC <up>") 'windmove-up)
(global-set-key (kbd "ESC <down>") 'windmove-down)
(global-set-key (kbd "ESC <right>") 'windmove-right)
(global-set-key (kbd "ESC <left>") 'windmove-left)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-[ 1 ; 3 a") 'windmove-up)
(global-set-key (kbd "M-[ 1 ; 3 b") 'windmove-down)
(global-set-key (kbd "M-[ 1 ; 3 c") 'windmove-right)
(global-set-key (kbd "M-[ 1 ; 3 d") 'windmove-left)
(global-set-key (kbd "M-[ 1 ; 5 A") 'backward-paragraph)
(global-set-key (kbd "M-[ 1 ; 5 B") 'forward-paragraph)
(global-set-key (kbd "M-[ 1 ; 5 C") 'forward-word)
(global-set-key (kbd "M-[ 1 ; 5 D") 'backward-word)
(global-set-key (kbd "M-[ a") 'backward-paragraph)
(global-set-key (kbd "M-[ b") 'forward-paragraph)
(global-set-key (kbd "M-[ c") 'forward-word)
(global-set-key (kbd "M-[ d") 'backward-word)
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-x") 'kill-region)
(global-set-key (kbd "\C-x\C-m") 'execute-extended-command)
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-n") 'new-scratchpad)
(global-set-key (kbd "<f5>") 'projectile-compile-project)
(global-set-key (kbd "<f6>") 'projectile-run-project)
(global-set-key (kbd "<f7>") 'gdb)

;;; Global configuration
(defalias 'yes-or-no-p 'y-or-n-p)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Custom functions
(defun new-scratchpad ()
  "Create a new scratchpad."
  (interactive)
  (switch-to-buffer (concat "scratch-" (number-to-string (abs (random))))))

;;; Use packages
(require 'use-package)

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package nerd-icons
  :ensure t)
;;(nerd-icons-install-fonts t)

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package treemacs
  :ensure t)

(use-package treemacs-nerd-icons
  :ensure t
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map)))

(use-package treemacs-projectile
  :ensure t)

(use-package yascroll
  :ensure t
  :config
  (global-yascroll-bar-mode t))

(use-package ivy
  :ensure t)

(use-package company
  :ensure t)

(use-package magit
  :ensure t)

(use-package doom-modeline
  :ensure t
  :config
  (doom-modeline-mode 1))

(use-package flycheck
  :ensure t
  :hook
  (prog-mode . flycheck-mode))

(use-package lsp-mode
  :ensure t
  :hook
  (prog-mode . lsp))

(use-package lsp-ui
  :ensure t)

(use-package lsp-treemacs
  :ensure t
  :commands (lsp-treemacs-symbols lsp-treemacs-errors-list lsp-treemacs-references))

(use-package lsp-ivy
  :ensure t)

;;; Startup done
(setq gc-cons-threshold 800000)
(kill-buffer "*scratch*")

;;; Emacs automatics

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yascroll yascroll-el nerd-icons-dired treemacs-icons-dired treemacs-projectile lsp-ivy lsp-treemacs lsp-ui lsp flycheck doom-modeline magit company ivy projectile treemacs-nerd-icons treemacs nerd-icons auto-package-update)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )




(provide 'init)
;;; init.el ends here
