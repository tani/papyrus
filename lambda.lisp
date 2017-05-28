(in-package #:cl-user)
(defpackage #:lambda.readtable
  (:use :cl :named-readtables)
  (:export #:lambda))
(in-package #:lambda.readtable)

(defun lambda-reader (s a b)
  (declare (ignore a b))
  (do ((line (read-line s nil nil) (read-line s nil nil))
       (buffer "")
       (codeblock nil))
      ((not line) (read-from-string (format nil "(progn ~a)" buffer)))
    (cond ((equalp 0 (search "```lisp" line)) (setf codeblock t))
      ((equalp 0 (search "```" line)) (setf codeblock nil))
      (codeblock (setf buffer (format nil "~a~%~a" buffer line))))))

(defreadtable :lambda
  (:merge :standard)
  (:dispatch-macro-char #\# #\Space #'lambda-reader))
