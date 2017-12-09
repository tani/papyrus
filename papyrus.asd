(in-package :cl-user)
(defpackage papyrus-asd
  (:use :cl :asdf))
(in-package :papyrus-asd)

(defsystem papyrus
  :version "0.1"
  :author "asciian"
  :license "MIT"
  :depends-on (:named-readtables)
  :components ((:file "papyrus"))
  :description "A Literate Programming Tool")
