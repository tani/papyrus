(defsystem #:papyrus
  :class :package-inferred-system
  :version "2.0.0"
  :author "TANIGUCHI Masaya"
  :license "MIT"
  :depends-on (#:papyrus/src/papyrus #:named-readtables)
  :description "A Literate Programming Tool"
  :in-order-to ((test-op (test-op #:papyrus/test))))

(defsystem #:papyrus/test
  :depends-on (#:fiveam #:papyrus/test/reader)
  :perform (test-op (o c)
             (symbol-call :fiveam :run! :papyrus)))

