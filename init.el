;;; no create backup file

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq make-backup-files nil)
(setq auto-save-default nil)

;;; 行番号の表示
(require 'linum)
(global-linum-mode)

;;; スクロールバーの表示
;(set-scroll-bar-mode 'right')

;;; モードラインに情報を表示
(display-time)
(line-number-mode 1)
(column-number-mode 1)

;;; keybinding
(global-set-key "\C-h" 'delete-backward-char)

;; C-z を入力すると、現在行が window の一番上に来るようにする
(defun line-to-top-of-window ()
  (interactive)
  (recenter 0))
(global-set-key (kbd "C-z") 'line-to-top-of-window)


;;; 拡張子がorgのファイルを開いた時，自動的にorg-modeにする
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;;org-modeで行末で折り返しをする
(setq org-startup-truncated nil)
(defun change-truncation()
  (interactive)
  (cond ((eq truncate-lines nil)
         (setq truncate-lines t))
        (t
         (setq truncate-lines nil))))

;;; org-mode settings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;; org-mode settings
(setq org-capture-templates
      '(("t" "New TODO" entry
         (file+headline "~/Dropbox/org/todo.org" "予定")
         "* TODO %?\n\n")
        ("m" "Memo" entry
         (file+headline "~/Dropbox/org/memo.org" "メモ")
         "* %U%?\n%i\n%a")))
;; org-agendaでaを押したら予定表とTODOリストを表示
(setq org-agenda-custom-commands
      '(("a" "Agenda and TODO"
         ((agenda "")
          (alltodo "")))))
(setq org-agenda-files '("~/Dropbox/org/todo.org"))
;; TODOリストに日付つきTODOを表示しない
(setq org-agenda-todo-ignore-with-date t)
;; 今日から予定を表示させる
(setq org-agenda-start-on-weekday nil)
;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
;; DONEの時刻を記録
(setq org-log-done 'time)

;;; melpa archive used ddskk
(require 'package)
(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
       '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
       '("org" . "http://orgmode.org/elpa/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes nil)
 '(org-agenda-files
   (quote
    ("~/Dropbox/org/lecture/sep2/lecture.org" "~/Dropbox/org/todo.org")))
 '(package-selected-packages (quote (htmlize mew ddskk))))

 '(default-input-method "japanese-skk")
 '(skk-background-mode nil)
 '(skk-egg-like-newline t)
 '(skk-indicator-use-cursor-color nil)
 '(skk-show-annotation t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(global-set-key "\C-xj" 'skk-mode)

;; mew の設定
(setq load-path (cons "/usr/local/share/emacs/site-lisp/mew/" load-path))
(autoload 'mew "mew" nil t)

(setq mew-prog-ssl "/usr/local/bin/stunnel")
;(setq mew-prog-ssl "/usr/local/bin/stunnel3")

;; 受信設定(imap)
(setq mew-proto "%")
;(setq mew-imap-server "imap.gmail.com")
(setq mew-imap-server "imap.icscoe.jp")
(setq mew-imap-ssl-port "993")
(setq mew-imap-user "c170004")
(setq mew-imap-auth t)
(setq mew-imap-ssl t)

;; 送信設定
(setq mew-smtp-server "smtp.icscoe.jp")
(setq mew-smtp-ssl-port "465")
(setq mew-smtp-user "c170004")
(setq mew-smtp-auth t)
(setq mew-smtp-ssl t)

; From の設定
(setq mew-from "Yuta Ikegami <y-ikegam@icscoe.jp>")
; 送信メールを %Sent へ
(setq mew-fcc "%Sent")
;(setq mew-imap-trash-folder "%[Gmail]/ゴミ箱")
;; パスワードを一時的にメモリに記録
(setq mew-use-cached-passwd t)
(setq mew-passwd-lifetime 60)
;; 署名をメールの末尾につける
(setq mew-signature-insert-last t)
; asked subject empty
(setq mew-ask-subject t)
; 新着メールの通知の設定
(setq mew-use-biff t)
(setq mew-use-biff-bell t)
(setq mew-biff-interval 3)
(eval-after-load "speech-synth"
  '(progn
     (defun mew-biff-bark (n)
       (if (= n 0)
           (setq mew-biff-string nil)
         (if (and mew-use-biff-bell (eq mew-biff-string nil))
             (speech-synth-execute-synthesis
              (format "メールが%d件到着しました．" n)))
         (setq mew-biff-string (format "Mail(%d)" n))))))
; Summary Mode のカスタマイズ
(setq mew-summary-form
  '(type (5 date) " " (-4 size) " " (14 from) " " t (30 subj) "|" (0 body)))
;; 未読メールのマーク
(setq mew-use-unread-mark t)

; 画面分割時に矢印キーで移動できるように
(windmove-default-keybindings)
(global-set-key (quote [kp-8]) (quote windmove-up))
(global-set-key (quote [kp-2]) (quote windmove-down))
(global-set-key (quote [kp-6]) (quote windmove-right))
(global-set-key (quote [kp-4]) (quote windmove-left))

; org-mode 時の html エクスポートする際のフッタの validate を削除
(setq org-html-validation-link nil)

; org-mode 時のソースコードの色付け設定
(setq org-src-fontify-natively t)
; org-mode 時の html エクスポートする際にコードに色をつける処理
(autoload 'htmlize-buffer "htmlize"
  "Convert BUFFER to HTML, preserving colors and decorations." t)
(autoload 'htmlize-region "htmlize"
  "Convert the region to HTML, preserving colors and decorations." t)
(autoload 'htmlize-file "htmlize"
  "Load FILE, fontify it, convert it to HTML, and save the result." t)

(when (require 'org-install nil t)
  ;; HTML出力したときコードハイライトcssを分離する
  ;; デフォルト(inline-css)だとcssがインラインに埋め込まれる
  (setq org-export-htmlize-output-type 'css))

; auto-install.el settings
;(add-to-list 'load-path "~/.emacs.d/auto-install")
(require 'auto-install)
;(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

; 試行錯誤用ファイルを開くための設定
;(require 'open-junk-file)
(setq open-junk-file-format "~/junk/%Y/%m/%d-%H%M%S.")
; C-x C-z で試行錯誤用ファイルを開く
(global-set-key (kbd "C-x C-z") 'open-junk-file)
;; 式の評価結果を注釈するための設定
;(require 'lispxmp)
; emacs-lisp-mode で C-c C-d を押すと注釈される
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)
;; 括弧の内容を保持して編集する設定
;(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(require 'auto-async-byte-compile)
; 自動バイトコンパイルを無効にするファイル名の正規表現
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2) ; すぐに表示したい
(setq eldoc-minor-mode-string "") ; モードラインにElDoc と表示しない
; 釣りあいのとれる括弧をハイライトする
(show-paren-mode 1)
; 改行と同時にインデントする
(global-set-key "\C-m" 'newline-and-indent)
; find-function をキー割り当てする
(find-function-setup-keys)

 ;; ¥の代わりにバックスラッシュを入力する
(define-key global-map [?¥] [?\\]) 
