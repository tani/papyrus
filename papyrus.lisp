(in-package #:cl-user)
(defpackage #:papyrus
  (:use :cl :named-readtables)
  (:export #:papyrus))
(in-package #:papyrus)

(defun papyrus-reader (s a b)
  (declare (ignore a b))
  (do ((line (read-line s nil nil) (read-line s nil nil))
       (buffer "")
       (codeblock nil))
      ((not line) (read-from-string (format nil "(progn ~a)" buffer)))
    (cond ((equalp 0 (search "```lisp" line)) (setf codeblock t))
      ((equalp 0 (search "```" line)) (setf codeblock nil))
      (codeblock (setf buffer (format nil "~a~%~a" buffer line))))))

(defreadtable :papyrus
  (:merge :standard)
  (:dispatch-macro-char #\# #\Space #'papyrus-reader))
