(defpackage #:papyrus/src/papyrus
  (:nicknames #:papyrus)
  (:use #:cl #:papyrus/src/reader #:named-readtables)
  (:export #:papyrus #:papyrus-markdown #:papyrus-org))
(in-package #:papyrus/src/papyrus)

(defreadtable #:papyrus
    (:merge :standard)
  (:dispatch-macro-char #\# #\Space #'markdown-reader))

(defreadtable #:papyrus-markdown
    (:merge :standard)
  (:dispatch-macro-char #\# #\Space #'markdown-reader))

(defreadtable #:papyrus-org
    (:merge :standard)
  (:dispatch-macro-char #\# #\Space #'org-reader))

(defreadtable #:papyrus-pod
    (:merge :standard)
  (:macro-char #\= #'pod-reader))
