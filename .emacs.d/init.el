;;; package --- Summary

;;; Commentary:
;;;  Don't panic.

;;; Code:
;;;  Don't panic.

;;; Startup
(setenv "LSP_USE_PLISTS" "true") ;;; https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
(setq
 gc-cons-threshold most-positive-fixnum
 read-process-output-max 1000000 ;;; must be smaller than /proc/sys/fs/pipe-max-size
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
  (set-frame-font "Hack Nerd Font 10")
  (setq frame-resize-pixelwise t)
  (tooltip-mode -1)
  (tool-bar-mode -1))

;;; Global minor modes and configuration
(xterm-mouse-mode 1)
(column-number-mode t)
(delete-selection-mode 1)
(global-font-lock-mode t)
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
 package-native-compile t
 require-final-newline t
 scroll-conservatively 1
 scroll-preserve-screen-position t
 scroll-step 1
 tab-width 8)
(keymap-set minibuffer-mode-map "TAB" 'minibuffer-complete)
(pixel-scroll-precision-mode)


;;; Programming stuff
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(use-package git-gutter
  :ensure t
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 1))

;;; Encoding
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(require 'ansi-color)

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
(global-set-key (kbd "<f4>") 'projectile-configure-project)
(global-set-key (kbd "<f5>") 'projectile-compile-project)
(global-set-key (kbd "<f6>") 'projectile-run-project)
(global-set-key (kbd "<f7>") 'projectile-test-project)
(global-set-key (kbd "<f8>") 'clang-format-buffer)

;;; Global configuration
(defalias 'yes-or-no-p 'y-or-n-p)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Custom functions
(defun new-scratchpad ()
  "Create a new scratchpad."
  (interactive)
  (switch-to-buffer (concat "scratch-" (number-to-string (abs (random))))))

;;; Programming


;;; Use packages
(require 'use-package)

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t))

(use-package nerd-icons
  :ensure t)
;;(nerd-icons-install-fonts t)

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-completion
  :ensure t
  :config
  (nerd-icons-completion-mode))

(use-package treesit-auto
  :ensure t
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  :config
  (setq c-ts-mode-indent-offset 4
	c-ts-mode-indent-style 'linux))

(defun my/treemacs ()
  (interactive)
  (treemacs)
  (lsp-treemacs-symbols))

(use-package treemacs
  :ensure t
  :config
  (setq treemacs-use-follow-mode 'tag)
  (setq treemacs-use-filewatch-mode t)
  (setq treemacs-git-commit-diff-mode t)
  (setq treemacs-use-git-mode 'deferred)
  (setq treemacs-display-current-project-exclusively t)
  (setq treemacs-project-follow-mode t)
  :bind
  ("<f9>" . my/treemacs))

(use-package treemacs-nerd-icons
  :ensure t
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package treemacs-magit
  :ensure t)

(use-package ag
  :ensure t)

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :config
  (setq projectile-project-search-path '("~/dev/")
        compilation-scroll-output 't
	projectile-project-configure-cmd "cmake -B build -S ."
	;;projectile-project-compilation-cmd "cmake --build build"
	projectile-project-compilation-cmd "make"
	projectile-project-run-cmd "cd build; ./main-gcc; cd .."
	projectile-project-test-cmd "gdb --cd build/ -im ./main-cc")
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

(use-package treemacs-projectile
  :ensure t)

(when window-system
  ;; slow in terminal
  (use-package yascroll
    :ensure t
    :config
    (global-yascroll-bar-mode t)))

(use-package yasnippet
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

(use-package flycheck-clang-tidy
  :ensure t
  :after flycheck
  :hook
  (flycheck-mode . flycheck-clang-tidy-setup))

(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-warn-no-matched-clients nil)
  :hook
  (prog-mode . lsp))

(use-package lsp-ui
  :ensure t)

(use-package lsp-treemacs
  :ensure t
  :config
  (lsp-treemacs-sync-mode t))

(use-package markdown-mode
  :ensure t
  :hook
  (markdown-mode . lsp)
  :config
  (require 'lsp-marksman))

(use-package clang-format
  :ensure t)

(use-package shackle
  :ensure t
  :hook
  (prog-mode . shackle-mode)
  :config
  (setq shackle-rules '((compilation-mode
			 :align below
			 :size 10))))

(use-package dap-mode
  :ensure t
  :custom
  (dap-auto-configure-mode)
  :config
  (require 'dap-cpptools)
  :bind
  ("<f10>" . dap-next))

(use-package centaur-tabs
  :ensure t
  :config
  (setq centaur-tabs-set-icons t
	centaur-tabs-set-modified-marker t
	centaur-tabs-set-close-button nil
	centaur-tabs-cycle-scope 'tabs
	centaur-tabs-show-new-tab-button nil)
  (centaur-tabs-change-fonts "Hack Nerd Font" 100)
  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))
(centaur-tabs-mode t)

(dap-register-debug-template
  "build/main-gcc"
  (list :type "cppdbg"
        :request "launch"
        :name "build/main-gcc"
        :MIMode "gdb"
        :program "${workspaceFolder}/build/main-gcc"
        :cwd "${workspaceFolder}/build"))

(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

;;; Emacs automatics
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(centaur-tabs company-capf treesit-auto clang-format nerd-icons-completion awesome-tab treemacs-magit perspective ag tree-sitter-langs tree-sitter git-gutter yascroll yascroll-el nerd-icons-dired treemacs-icons-dired treemacs-projectile lsp-ivy lsp-treemacs lsp-ui lsp flycheck doom-modeline magit company ivy projectile treemacs-nerd-icons treemacs nerd-icons auto-package-update)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)
(setq gc-cons-threshold 20000000)
;;; init.el ends here
