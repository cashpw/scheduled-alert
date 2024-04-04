;;; scheduled-alert.el --- Schedule alerts -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 Cash Prokop-Weaver
;;
;; Author: Cash Prokop-Weaver <cashbweaver@gmail.com>
;; Maintainer: Cash Prokop-Weaver <cashbweaver@gmail.com>
;; Created: April 04, 2024
;; Modified: April 04, 2024
;; Version: 0.0.1
;; Keywords: notify, notifications, calendar
;; Homepage: https://github.com/cashpw/scheduled-alert
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(defgroup scheduled-alert
  nil
  "Group for scheduled-alert.")

(defcustom scheduled-alert-timers '()
  "List of timers for scheduled alerts."
  :type '(repeat sexp)
  :group 'scheduled-alert)

(defun scheduled-alert-cancel-all ()
  "Cancel all scheduled alerts."
  (interactive)
  (mapcar
   (lambda (timer)
     (cancel-timer
      timer))
   scheduled-alert-timers)
  (setq
   scheduled-alert-timers '()))

(defun scheduled-alert-schedule (time message &optional alert-keys)
  "Schedule an alert with MESSAGE for TIME."
  (let ((seconds-until-alert-time
         (floor
          (time-to-seconds
           (time-subtract
            time
            (current-time))))))
    (unless (< seconds-until-alert-time 0)
      (add-to-list
       'scheduled-alert-timers
       (run-with-timer
        seconds-until-alert-time
        nil
        'alert
        message
        :severity (plist-get alert-keys :severity)
        :title (plist-get alert-keys :title)
        :icon (plist-get alert-keys :icon)
        :category (plist-get alert-keys :category)
        :buffer (plist-get alert-keys :buffer)
        :mode (plist-get alert-keys :mode)
        :data (plist-get alert-keys :data)
        :style (plist-get alert-keys :style)
        :persistent (plist-get alert-keys :persistent)
        :never-persist (plist-get alert-keys :never-persist)
        :id (plist-get alert-keys :id))
       t))))

(provide 'scheduled-alert)
;;; scheduled-alert.el ends here
