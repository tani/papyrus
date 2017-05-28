(in-package :cl-user)
(defpackage lambda-asd
  (:use :cl :asdf))
(in-package :lambda-asd)

(defsystem lambda
  :version "0.1"
  :author "TANIGUCHI Masaya"
  :license "GPLv3"
  :depends-on (:named-readtables)
  :components ((:file "lambda")
	       (:file #p"package.l.md"))
  :description "A Literate Programming Framework")
