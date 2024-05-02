(in-package #:cl-user)
(defpackage #:papyrus
  (:use :cl :named-readtables)
  (:export #:papyrus :papyrus-markdown :papyrus-org))
(in-package #:papyrus)


(defun <? (&rest args)
  (letf ((nil-to-inf (lambda (x) (or x most-positive-fixnum))))
    (apply #'< (mapcar nil-to-inf args))))


(defun papyrus-org-reader (s a b)  
  (declare (ignore a b))
  (do ((line (read-line s nil nil) (read-line s nil nil))
       (buffer nil)
       (codeblock nil))
      ((not line) (read-from-string (format nil "(progn ~{~a~%~})" buffer)))
    (cond ((<? (search "#+BEGIN_SRC") 1 (search ":tangle" line) (search "yes" line) most-positive-fixnum)
	   (setq codeblock t))
	  ((<? (search "#+END_SRC" line) 1) (setq codeblock nil))
	  (codeblock (push line buffer)))))


(defun papyrus-markdown-reader (s a b)
  (declare (ignore a b))
  (do ((line (read-line s nil nil) (read-line s nil nil))
       (buffer nil)
       (codeblock nil))
      ((not line) (read-from-string (format nil "(progn ~{~a~%~})" buffer)))
    (cond ((<? (search "```lisp" line) 1) (setq codeblock t))
	  ((<? (search "```" line) 1) (setq codeblock nil))
	  (codeblock (push line buffer)))))


(defreadtable :papyrus
    (:merge :standard)
  (:dispatch-macro-char #\# #\Space #'papyrus-markdown-reader))


(defreadtable :papyrus-markdown
    (:merge :standard)
  (:dispatch-macro-char #\# #\Space #'papyrus-markdown-reader))


(defreadtable :papyrus-org
    (:merge :standard)
  (:dispatch-macro-char #\# #\Space #'papyrus-org-reader))
