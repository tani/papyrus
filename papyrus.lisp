(in-package #:cl-user)
(defpackage #:papyrus
  (:use :cl :papyrus-reader :named-readtables)
  (:export #:papyrus :papyrus-markdown :papyrus-org))
(in-package #:papyrus)


(defreadtable :papyrus
    (:merge :standard)
  (:dispatch-macro-char #\# #\Space #'papyrus-markdown-reader))


(defreadtable :papyrus-markdown
    (:merge :standard)
  (:dispatch-macro-char #\# #\Space #'papyrus-markdown-reader))


(defreadtable :papyrus-org
    (:merge :standard)
  (:dispatch-macro-char #\# #\Space #'papyrus-org-reader))
