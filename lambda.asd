(in-package :cl-user)
(defpackage :lambda-asd
  (:use :cl :asdf))
(in-package :lambda-asd)

;; Load markdown as lisp
(set-dispatch-character
 #\# #\Space
 (lambda (s c1 c2)
   (read-from-string
    (do ((line (read-line stream nil nil))
	 (buffer (format nil "~a~a" c1 c2))
	 (codeblock nil))
	(line buffer)
      (cond
	((zerop (search "```lisp" line)) (setf codeblock t))
	((zerop (search "```" line)) (setf codeblock nil))
	(codeblock
	 (setf buffer (concatenate 'string buffer #(#\Newline) line))))))))
(defclass lmd (cl-source-file)
  ((type :initform ".l.md")))

;; ASDF system
(defsystem :lambda ()
  :author "TANIGUCHI Masaya"
  :components ((:lmd "README.l.md")))
