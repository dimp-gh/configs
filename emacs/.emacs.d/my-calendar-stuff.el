(provide 'my-calendar-stuff)

(require 'calfw-ical)

;; First day of the week
(setq calendar-week-start-day 1) ; 0:Sunday, 1:Monday

(defun open-google-calendar ()
  "Open my Google calendar"
  (interactive)
  (cfw:open-ical-calendar
   "https://www.google.com/calendar/XXX/basic.ics")) ;; paste your ical link here
