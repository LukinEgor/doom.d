;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Egor Lukin"
      user-mail-address "lukin.net@gmail.com")

(setq doom-theme 'doom-gruvbox-light)

(setq doom-font (font-spec :family "monospace" :size 24 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 24))

(setq display-line-numbers-type t)

(after! org
  (setq org-directory "~/Projects/org/"))

(after! org
  (setq org-todo-keywords
        '((sequence "TODO" "IN-PROGRESS" "WAIT" "SKIP" "DELEGATED" "SCHEDULED" "|" "DONE" "CLOSED")))
  (setq org-agenda-files '("roam/gtd/gtd.org" "roam/gtd/backlog.org" "roam/gtd/routines.org" "roam/gtd/birthday.org" "roam/gtd/scheduled.org")))

(setq org-refile-targets
      '(("~/Projects/org/roam/gtd/gtd.org" :maxlevel . 2)
        ("~/Projects/org/roam/gtd/routines.org" :maxlevel . 2)
        ("~/Projects/org/roam/gtd/scheduled.org" :maxlevel . 2)
        ("~/Projects/org/roam/gtd/backlog.org" :maxlevel . 2)))

(setq org-download-dir "~/photos/org")

(after! org
  (setq org-log-done t)
  (setq org-log-into-drawer t))

(after! org
  (setq org-archive-location "~/Projects/org/roam/gtd/gtd_archive.org::"))

(setq projectile-project-search-path '("~/Projects/"))

(setq helm-mode-fuzzy-match t)

(setq ivy-re-builders-alist
      '((counsel-ag . regexp-quote)
        (t      . ivy--regex-fuzzy)))

(setq ein:output-area-inlined-images t)

;; Google Translate Integration
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cr" 'google-translate-at-point-reverse)
(global-set-key "\C-cT" 'google-translate-query-translate)

(setq google-translate-default-source-language '"en")
(setq google-translate-default-target-language '"ru")

(use-package google-translate
  ;; :ensure t
  :custom
  (google-translate-backend-method 'curl)
  :config
   (defun google-translate--search-tkk () "Search TKK." (list 430675 2721866130)))

(setq browse-url-browser-function 'eww-browse-url)
(setq eww-download-directory "~/cached-web-pages")

(after! elfeed
  (setq elfeed-feeds
        '("https://hnrss.org/best"
          "https://www.lesswrong.com/feed.xml?view=curated-rss"
          "https://slatestarcodex.com/feed/"
          "https://lifehacker.com/rss"
          "https://hackaday.com/blog/feed/"
          "https://feeds.arstechnica.com/arstechnica/index"
          "https://mindingourway.com/rss/"
          "https://www.reddit.com/r/Biohackers/.rss"
          "https://www.reddit.com/r/QuantifiedSelf/.rss"
          "https://www.reddit.com/r/kubernetes/.rss"
          "https://www.reddit.com/r/GUIX/.rss"
          "https://www.reddit.com/r/emacs/.rss"
          "https://www.reddit.com/r/orgmode/.rss"
          "https://www.reddit.com/r/selfhosted/.rss"
          "https://reminder.media/rss"
          "https://lesswrong.ru/rss.xml")))

(after! org-roam
  (setq org-roam-directory "~/Projects/org/roam")
  (setq org-roam-db-location  "~/Projects/org/roam/org-roam.db")

  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%A, %d %B %Y>\n"))))

  (setq org-roam-capture-templates
        '(("t" "Task note" plain
           "%?"
           :if-new (file+head "tasks/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)
          ("l" "Literate note" plain
           "%?"
           :if-new (file+head "literate/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)
          ("c" "Conceptual note" plain "%?"
           :if-new (file+head "conceptual/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)
          ("p" "Project note" plain
           "%?"
           :if-new (file+head "project/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)))

  (map! :leader
        :prefix "r"
        :desc "org-roam-node-insert" "i" #'org-roam-node-insert
        :desc "org-roam-node-find" "f" #'org-roam-node-find
        :desc "org-roam-dailies-goto-date" "s" #'org-roam-dailies-goto-date
        :desc "org-roam-dailies-goto-today" "d" #'org-roam-dailies-goto-today
        :desc "org-roam-buffer" "l" #'org-roam-buffer
        :desc "org-roam-show-graph" "g" #'org-roam-show-graph
        :desc "org-roam-capture" "c" #'org-roam-capture))

;; %Y-%m-%d.org
(after! org
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline "roam/gtd/gtd.org" "Inbox")
           (file "templates/todo.org"))
          ("f" "Fast todo" entry
           (file+headline "roam/gtd/gtd.org" "Inbox")
           (file "templates/fast_todo.org"))
          ("e" "English word" entry
           (file+headline "anki/english_words.org" "Backlog")
           (file "templates/english_words.org"))
          ("b" "Add bookmark" entry
           (file+headline "roam/notes/bookmarks.org" "Inbox")
           (file "templates/bookmarks.org"))
          ("c" "Todo from x clipboard" entry
           (file+headline "roam/gtd/gtd.org" "Inbox")
           (file "templates/external.org")))))

(setq deft-directory "~/Projects/org")
(setq deft-extensions '("txt" "tex" "org"))
(setq deft-recursive t)

(map! :leader
      (:prefix-map ("b" . "babel")
       :desc "org-babel-execute-src-block" "b" #'org-babel-execute-buffer))

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-persist t)

(defvar polybar--default-header "no active clocks!")

(defun polybar--format-line (task time)
  (concat task " ("(number-to-string time) " min)"))

(defun polybar-current-clock-line ()
  (if (org-clocking-p)
      (let ((header org-clock-heading)
            (time
             (floor
              (org-time-convert-to-integer (time-since org-clock-start-time))
              60)))
        (polybar--format-line header time))
    polybar--default-header))

(setq hledger-jfile "~/Projects/org/finances/ledger.journal")

;; Develop in ~/emacs.d/mysnippets, but also
;; try out snippets in ~/Downloads/interesting-snippets
(setq yas-snippet-dirs '("~/Projects/snippets"
                         "~/emacs.d/mysnippets"))

(after! reverso
  (setq reverso-default-source-lang "english")
  (setq reverso-default-target-lang "russian")

  (map! :leader
        :prefix "k"
        :desc "reverso-direct-search" "d" #'reverso-direct-search
        :desc "reverso-reverse-search" "r" #'reverso-reverse-search))

(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if filename
        (if (y-or-n-p (concat "Do you really want to delete file " filename " ?"))
            (progn
              (delete-file filename)
              (message "Deleted file %s." filename)
              (kill-buffer)))
      (message "Not a file visiting buffer!"))))

(setq docker-tramp-use-names t)

(setq org-use-fast-todo-selection t)

(setq telega-use-docker t)

(winner-mode +1)
