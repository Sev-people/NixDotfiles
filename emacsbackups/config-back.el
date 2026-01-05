(setq org-emphasis-regexp-components
      '("-—[:space:]('\"{"
	"-—[:space:].,:!?;'\")}\\["
	"[:space:]"
	"."
	1))

(require 'org)

(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)

(setq org-startup-folded t
      org-hide-emphasis-markers t
      org-return-follows-link t)

;; GTD keywords
(defconst my/gtd-dest-map
  '(("projects.org"  . "PROJ")
    ("waiting.org"   . "WAIT")
    ("next.org"      . "NEXT")
    ("calendar.org"  . "TODO")
    ("reference/reference.org" . nil)
    ("someday.org"   . "IDEA"))
  "GTD file structure & keyword correspondance.")

;; GTD tags And TODO Keywords
(setq org-tag-persistent-alist '((:startgroup . nil)
                      ("@work" . ?w) ("@knowledge" . ?k)
                      ("@misc" . ?m) ("@academic" . ?a)
                      (:endgroup . nil)
                      ))
(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "FILE(f)" "PROJ(p)" "IDEA(i)" "WAIT(w)" "|" "DONE(d)")))

;;; GTD root and default notes file
(setq my/gtd-root (expand-file-name "~/Documents/work/organization/"))
(setq org-default-notes-file (expand-file-name "inbox.org" my/gtd-root))

;; Files used in agenda
(setq org-agenda-files `(
	,(expand-file-name "calendar.org" my/gtd-root)
	,(expand-file-name "agenda.org" my/gtd-root)))

;; General Settings
(setq org-agenda-span 1
org-agenda-start-day "+0d"
org-agenda-skip-timestamp-if-done t
org-agenda-skip-deadline-if-done t
org-agenda-skip-scheduled-if-done t
org-agenda-skip-scheduled-if-deadline-is-shown t
org-agenda-skip-timestamp-if-deadline-is-shown t)

;; Agenda views format
(setq org-agenda-prefix-format '(
(agenda . "  %?-2i %t ")
 (todo . " %i %-12:c")
 (tags . " %i %-12:c")
 (search . " %i %-12:c")))

(setq org-agenda-hide-tags-regexp ".*")

;; Settings for agenda views
(setq org-deadline-warning-days 0)
(setq org-agenda-current-time-string "")
(setq org-agenda-time-grid '((daily) () "" ""))
(setq org-agenda-start-on-weekday nil)

;; Custom agenda view
(setq org-agenda-custom-commands
      '(("x" "Custom Agenda"
         ;; Routine today
         ((agenda ""
                  ((org-agenda-span 1)
                   (org-agenda-entry-types '(:timestamp))
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'todo 'any))
                   (org-agenda-overriding-header "Routine")))

          ;; TODOs scheduled today
          (agenda ""
                  ((org-agenda-span 1)
		   (org-agenda-show-current-time-in-grid nil)
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'nottodo 'any))
                   (org-agenda-overriding-header "Work Today")))

          ;; Deadlines in the next 7 days
          (agenda ""
                  ((org-agenda-span 7)
		   (org-agenda-files '("~/Documents/work/organization/calendar.org"))
		   (org-agenda-prefix-format '((agenda . "  %?-2i %t %s")))
		   (org-agenda-show-current-time-in-grid nil)
                   (org-agenda-entry-types '(:deadline :scheduled))
                   (org-agenda-overriding-header "Calendar")))))

	("j" "School Agenda"
	   ((agenda ""
                    ((org-agenda-files '("~/Documents/work/files/academics"))
                    	(org-agenda-span 90)
		    	(org-agenda-show-current-time-in-grid nil)
                    	(org-agenda-entry-types '(:deadline :scheduled :timestamp))
                    	(org-agenda-prefix-format '((agenda . " %i %-12:c %t")))))))))

;; Capture templates
(setq denote-org-capture-specifiers "%i\n%?")

(setq org-capture-templates
      `(("i" "Inbox" entry
         (file+headline ,(expand-file-name "inbox.org" my/gtd-root) "Inbox")
         "* FILE %^{Header|Entry} \n:PROPERTIES:\n:Captured: %u\n:End:\n%^{Description}%i" :immediate-finish t)))

;; Set deadline for GTD entries
(defun gtd-set-deadline ()
  "Set a deadline for a GTD project/task."
  (interactive)
  (org-up-heading-all 0)
  (let ((date (read-string "Deadline (empty to skip): ")))
    (unless (string-empty-p date)
      (org-deadline nil date)
      (let* ((calendarfile (expand-file-name "calendar.org" my/gtd-root))
	     (calendarheader "Calendar")
	     (pos (with-current-buffer (find-file-noselect calendarfile t)
		    (widen)
		    (or (org-find-exact-headline-in-buffer calendarheader)
			(user-error "No headline in %s" calendarfile)))))
	(org-refile 3 nil (list calendarheader calendarfile nil pos))
	(with-current-buffer (find-buffer-visiting calendarfile)
	  (save-buffer))))))
;; Refile GTD entries
(defun gtd-refile-with-keyword ()
  "Refile current heading to a GTD target file and update its TODO keyword."
  (interactive)
  (org-up-heading-all 0)
  (let* ((choice (completing-read "Move to: " (mapcar #'car my/gtd-dest-map))) ;; Prompt to choose GTD file
         (keyword (cdr (assoc choice my/gtd-dest-map))) ;; TODO keyword associated to chosen GTD file
	 (header (capitalize (string-remove-suffix ".org" choice))) ;; Maps filename.org to Filename
         (file (expand-file-name choice my/gtd-root)) ;; Chosen GTD file path
	 (nextaction ""))
    ;; Change TODO keyword
    (when keyword
      (org-todo keyword))
    (setq current-prefix-arg nil)
    ;; Project template
    (when (member choice '("projects.org"))
      (org-priority nil)
      (org-set-tags-command)
      (gtd-set-deadline))
    ;; Prompt for the next action
    (when (member choice '("next.org"))
      (while (string-blank-p nextaction) (setq nextaction (read-string "Next Action (cannot be empty): ")))
      (org-set-property "NextAction" nextaction)
      (org-priority nil)
      (org-set-tags-command))
    ;; Prompt for date
    (when (member choice '("calendar.org")) (org-schedule nil))
    ;; Refile header
    (let* ((pos (with-current-buffer (find-file-noselect file t)
		  (widen)
		  (or (org-find-exact-headline-in-buffer header)
                      (user-error "No headline in %s" file)))))
      (org-refile nil nil (list header file nil pos)))
    ;; Save current buffer
    (save-buffer)
    ;; Save buffer header is being moved to
    (setq target-buf (find-buffer-visiting file))
    (with-current-buffer target-buf
      (save-buffer))))

;; Project management
(require 'org-mouse)

(setq org-after-note-stored-hook
      (list
       (lambda ()
	 (org-up-heading-all 0)
	 (org-store-link t)
	 ;; Set NextAction
	 (let ((nextaction "") (priority (string-to-char (org-mouse-get-priority))) (tags (org-get-tags)) (link (substring-no-properties (org-store-link t))))
	   (while (string-blank-p nextaction) (setq nextaction (read-string "Next Action: ")))
	   (org-set-property "NextAction" nextaction)
	   ;; Add next.org entry
	   (let ((org-capture-templates
		  `(("x" "Project action" entry
		     (file+headline ,(expand-file-name "next.org" my/gtd-root) "Next")
		     "* NEXT %(identity nextaction) for: %(identity link)\n:PROPERTIES:\n:Captured: %u\n:End:\n%i" :immediate-finish t :before-finalize (lambda () (org-priority priority) (org-set-tags tags))))))
	     (org-capture nil "x"))))
       (save-buffer)))

(defun gtd-manage-project ()
  "Manage current GTD project."
  (interactive)
  (org-up-heading-all 0)
  ;; Add purpose and vision
  (unless (org-entry-get (point) "Purpose")
    (let ((purpose ""))
      (while (string-blank-p purpose) (setq purpose (read-string "Purpose: ")))
      (org-set-property "Purpose" purpose)))
  (unless (org-entry-get (point) "SuccessCriteria")
    (let ((criteria ""))
      (while (string-blank-p criteria) (setq criteria (read-string "Success Criteria: ")))
      (org-set-property "SuccessCriteria" criteria)))
  ;; Brainstorm
  (org-add-note))

;; Misc. settings
(add-hook 'org-todo-repeat-hook #'org-reset-checkbox-state-subtree) ;; To unmark checkboxes
(setq org-log-into-drawer t) ;; For timestamp logs
;; Remove timestamp logging when tasks are completed
(setq org-log-done nil)
(setq org-log-repeat nil)

;; GTD keybindings
(defun gtd-agenda ()
  "Open custom agenda view."
  (interactive)
  (org-agenda nil "x"))

(defun gtd-dir ()
  "Open GTD directory."
  (interactive)
  (find-file "~/Documents/work/organization"))

(defvar-keymap gtd-prefix-map
  :doc "GTD prefix key map."
  "c" #'org-capture
  "a" #'gtd-agenda
  "d" #'gtd-dir
  "p" #'gtd-manage-project
  "s" #'(lambda () (interactive) (org-agenda nil "j"))
  "m" 'gtd-refile-with-keyword)

(keymap-set global-map "C-c d" gtd-prefix-map)

(use-package toc-org
    :ensure t
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(require 'org-tempo)

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

;; Unbind motion-state keys that would interfere with custom keybindings (e.g., leader keys)
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)  ;; Unbind spacebar
  (define-key evil-motion-state-map (kbd "RET") nil)  ;; Unbind Return
  (define-key evil-motion-state-map (kbd "TAB") nil)) ;; Unbind Tab

;; EVIL COLLECTION — Vi keybindings across the Emacs ecosystem (Magit, Dired, Eshell, etc.)
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; FINE-TUNING EVIL BEHAVIOR (These are global variables, best set early)
(setq
 ;; Use Evil's own search module (not Emacs isearch) — enables `/` to behave as in Vim
 evil-search-module 'evil-search
 ;; Use Vim-style regular expressions for `evil-ex-search`
 evil-ex-search-vim-style-regexp t
 ;; More granular undo points (e.g., inserting `foo` triggers 3 undos: `f`, `o`, `o`)
 evil-want-fine-undo t
 ;; Ensure Evil integrates fully with Emacs core behavior
 evil-want-integration t)

;; Set super key to meta
(setq x-super-keysym 'meta)

;; Evil mode escape sequence
(use-package evil-escape
  :ensure t
  :after evil
  :config
  (evil-escape-mode 1)
  (setq evil-escape-key-sequence "jk"))

(use-package direnv
  :ensure t
  :config
  (direnv-mode))

;; Magit dependency
(use-package transient
  :ensure t)

(use-package magit
  :defer t
  :commands (magit-status magit-blame))

(use-package python
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python3" . python-mode))

(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'")

(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(with-eval-after-load 'js
  (setq js-indent-level 2))

(use-package typescript-mode
  :ensure t
  :mode ("\\.ts\\'" "\\.tsx\\'")
  :config
  (setq typescript-indent-level 2))

(use-package json-mode
  :ensure t
  :mode "\\.json\\'")

(use-package yaml-mode
  :ensure t
  :mode "\\.ya?ml\\'")

(use-package toml-mode
  :ensure t
  :mode "\\.toml\\'")

(with-eval-after-load 'sh-script
  (setq sh-basic-offset 2
        sh-indentation 2))

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(with-eval-after-load 'cc-mode
  (setq c-basic-offset 4
        tab-width 4
        indent-tabs-mode nil))

(use-package consult
  :ensure t
  :bind
  (("C-s" . consult-line)
   ("C-c g" . consult-ripgrep)
   ("C-x b" . consult-buffer)))

(use-package project
  :ensure nil
  :custom
  (project-switch-commands
   '((project-find-file "Find file")
     (consult-ripgrep "Search")
     (magit-status "Magit")
     (project-eshell "Eshell")))
  :config
  (setq project-vc-merge-submodules nil))

;; Eglot dependency
(use-package flymake :ensure t)

(use-package eglot
  :ensure t
  :hook ((python-mode      . eglot-ensure)
         (rust-mode        . eglot-ensure)
         (js-mode          . eglot-ensure)
         (typescript-mode  . eglot-ensure)
         (json-mode        . eglot-ensure)
         (yaml-mode        . eglot-ensure)
         (toml-mode        . eglot-ensure)
         (sh-mode          . eglot-ensure)
         (nix-mode         . eglot-ensure)
         (c-mode           . eglot-ensure)
         (c++-mode         . eglot-ensure))
  :custom
  (eglot-autoshutdown t)
  (eglot-send-changes-idle-time 0.2)
  :config
  (setq-default eglot-server-programs
        '((python-mode     . ("pyright-langserver" "--stdio"))
          (rust-mode       . ("rust-analyzer"))
          (js-mode         . ("typescript-language-server" "--stdio"))
          (typescript-mode . ("typescript-language-server" "--stdio"))
          (web-mode        . ("typescript-language-server" "--stdio"))
          (json-mode       . ("vscode-json-languageserver" "--stdio"))
          (yaml-mode       . ("yaml-language-server" "--stdio"))
          (toml-mode       . ("taplo" "lsp" "stdio"))
          (sh-mode         . ("bash-language-server" "start"))
          (c-mode          . ("clangd"))
          (c++-mode        . ("clangd"))
          (nix-mode        . ("nil")))))

(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-auto-delay 0.2)
  (corfu-preview-current nil)
  :init
  (global-corfu-mode))

(use-package denote
  :ensure t
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . denote-dired)
   ("C-c n g" . denote-grep))
  :config
  (setq denote-directory (expand-file-name "~/Documents/work/notes")
	denote-known-keywords nil
	denote-infer-keywords t)
  (add-to-list 'denote-prompts 'template)
  
  ;; Automatically rename Denote buffers when opening them
  (denote-rename-buffer-mode 1))

  ;; Templates
  (setq denote-templates
	'(
	  (none . "") 
	  (philosophy . "* Metadata\n:PROPERTIES:\n:Author:\n:Title:\n:End:\n* Overview\n* Key Ideas\n| Term | Definition |\n* Quotes\n* Chapter Notes\n** Chapter 1:")
	  (literature . "* Metadata\n:PROPERTIES:\n:Author:\n:Title:\n:End:\n* Overview\n* Quotes\n* Chapter Notes\n** Chapter 1:")
	  (physics . "#+SETUPFILE: ~/.dotfiles/emacs/latex/export.org\n#+LATEX_HEADER: \\usepackage{mathtools, cancel, physics, siunitx, mhchem, tikz, bm}\n\n*Metadata\n:PROPERTIES:\n:Author:\n:Title:\n:End:\n* Notes")
	  (mathematics . "#+SETUPFILE: ~/.dotfiles/emacs/latex/export.org\n#+LATEX_HEADER: \\usepackage{mathtools, cancel, tikz, bm}\n\n*Metadata\n:PROPERTIES:\n:Author:\n:Title:\n:End:\n* Notes")
	  (programming . "#+SETUPFILE: ~/.dotfiles/emacs/latex/export.org\n#+LATEX_HEADER: \\usepackage{mathtools, cancel, tikz, bm, listings, courier, tcolorbox}\n\n* Metadata\n:PROPERTIES:\n:Author:\n:Title:\n:End:\n* Notes")
	  ))

(use-package vertico
  :init (vertico-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :ensure t
  :init (marginalia-mode))

(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 150 :width 'normal :weight 'extra-light)

;; Makes commented text and keywords italics.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; Adjust line spacing.
(setq-default line-spacing 0.12)

;; Disable menubar, toolbars, and scrollbars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Set frame border
(set-window-margins (selected-window) 1 1)

;; Truncate lines
(global-visual-line-mode 1)

;; Relative line numbers
(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)

(setq initial-scratch-message "")
(setq inhibit-startup-screen t)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(use-package which-key
  :ensure t
  :init
  (which-key-mode 1)
  :config
  (setq which-key-inside-window-location 'bottom
	which-key-sort-order #'which-key-key-order-alpha
	which-key-sort-uppercase-first nil
	which-key-add-column-padding 1
	which-key-max-display-columns nil
	which-key-min-display-lines 6
        which-key-side-window-slot -10
	which-key-side-window-max-height 0.25
	which-key-idle-delay 0.8
	which-key-max-description-length 25
	which-key-allow-imprecise-window-fit nil
	which-key-separator " → " ))

(setq org-latex-to-pdf-process (list "latexmk %f"))

(with-eval-after-load 'ox-latex
(add-to-list 'org-latex-classes
             '("org-plain-latex"
	      "\\documentclass{article}
                 [NO-DEFAULT-PACKAGES]
                 [PACKAGES]
                 [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(use-package cdlatex
  :hook ((LaTeX-mode . org-cdlatex-mode)))

(use-package auctex
  :defer t
  :ensure t)
(global-auto-revert-mode 1)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

(use-package pdf-tools
         :demand t
         :init
         (pdf-tools-install))

(add-hook 'pdf-view-mode-hook
	  (lambda () 
	    (display-line-numbers-mode -1) ;; Remove line numbers
	    (blink-cursor-mode -1) ;; Remove cursor blinking
	    (pdf-view-midnight-minor-mode 1))) ;; Dark mode

(setq-default
 mode-line-format
 '("%e"
   mode-line-front-space
   ;; Buffer name
   (:eval (propertize "%b" 'face 'mode-line-buffer-id))
   " "
   ;; Read-only or modified flags
   (:eval (cond (buffer-read-only "RO")
                ((buffer-modified-p) "✱")
                (t " ")))
   " "
   ;; Line and column
   "L%l:C%c "
   ;; Percent of buffer
   "[%p] "
   ;; Major mode
   (propertize "%m" 'face 'font-lock-type-face)
   ;; Narrow indicator
   (:eval (when (buffer-narrowed-p) " [Narrow]"))
   ;; Org clock
   (:eval (when (bound-and-true-p org-mode-line-string)
            (concat " " org-mode-line-string)))
   mode-line-end-spaces))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode))

;; Indentation and pairing
(electric-indent-mode -1)
(setq org-edit-src-content-indentation 0)
(electric-pair-mode 1)
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(setq org-startup-indented t)

;; Bell deactivation
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; Backups
(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(elpaca 'eat)
(global-set-key (kbd "C-c t") 'eat)

(use-package flyspell
  :defer t
  :ensure nil
  :config
  ;; Skip irrelevant regions
  (add-to-list 'ispell-skip-region-alist '("~" "~"))
  (add-to-list 'ispell-skip-region-alist '("=" "="))
  (add-to-list 'ispell-skip-region-alist '("^#\\+BEGIN_SRC" . "^#\\+END_SRC"))
  (add-to-list 'ispell-skip-region-alist '("^#\\+BEGIN_EXPORT" . "^#\\+END_EXPORT"))
  (add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))

  ;; Enable only in selected modes
  (dolist (mode '(
                  mu4e-compose-mode-hook))
    (add-hook mode (lambda () (flyspell-mode 1))))

  ;; Silence startup messages
  (setq flyspell-issue-welcome-flag nil
        flyspell-issue-message-flag nil))

(require-theme 'modus-themes)
(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs t
      ;;modus-themes-syntax '(alt-syntax)
      modus-themes-hl-line '(intense)
      modus-themes-paren-match '(intense))
(setq modus-vivendi-palette-overrides
      '((bg-main "#0C121D") ;; Background color
          (bg-active "#1E2B40") ;; Mode line
          (bg-mode-line-active "#293952") ;; Mode line
          (bg-mode-line-inactive "#1E2B40") ;; Mode line
          (bg-dim "#0C121D") ;; Same as bg-main
        ))
(setq modus-themes-common-palette-overrides
      `(
	  (bg-line-number-inactive unspecified)
	  (bg-line-number-active unspecified)
	  (border-mode-line-active bg-mode-line-active) ;; Mode line border
          (border-mode-line-inactive bg-mode-line-inactive) ;; Mode line border
	  (bg-prose-block-contents "#090E16") ;; Code block contents
          (bg-prose-block-delimiter "#090E16") ;; Code start/end
          (date-common "#b4f9f8") ;; Timestamps
       ))
(custom-set-faces
 '(org-level-1 ((t (:foreground "#A3C5F1"))))
 '(org-level-2 ((t (:foreground "#6582AA"))))
 '(org-level-3 ((t (:foreground "#b898f4")))))
(load-theme 'modus-vivendi)
