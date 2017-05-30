(in-package :cl-user)
(defpackage papyrus-asd
  (:use :cl :asdf))
(in-package :papyrus-asd)

(defsystem lambda
  :version "0.1"
  :author "TANIGUCHI Masaya"
  :license "MIT"
  :depends-on (:named-readtables)
  :components ((:file "papyrus"))
  :description "A Literate Programming Tool")
