(in-package :cl-user)
(defpackage papyrus-asd
  (:use :cl :asdf))
(in-package :papyrus-asd)

(defsystem papyrus
  :version "1.0.0"
  :author "TANIGUCHI Masaya"
  :license "MIT"
  :depends-on (:named-readtables)
  :serial t
  :components ((:file "reader") (:file "papyrus"))
  :description "A Literate Programming Tool")
