(provide 'my-color-theme)

;; solarized and monokai are accessible via 
;; color-theme-solarized and color-theme-monokai
;; nice grey theme
(if (display-graphic-p)
  (require 'zenburn-theme)
  (load-theme 'tsdh-dark))
;; nice brown-red theme
;; (require 'birds-of-paradise-plus-theme)
;; almost nice tango theme
;; (require 'color-theme-tango)
;; color-theme-sanityinc-tomorrow-eighties is also quite nice
