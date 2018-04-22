; interpreter version zero

; top level driver loop for a recursion equations interpreter
; driver-loop takes a list of the primitive procedures as its first argument ***** FIXME: currently empty list *****

(define (driver)
        (driver-loop `() (print '|lisp is listening|)))

(define (driver-loop procedures hunoz) ; what is hunoz ?
        (driver-loop-1 procedures (read)))

(define (driver-loop-1 procedures form)
    (cond ((atom form)
           (driver-loop procedures (print (eval form `() procedures))))
          ((eq (car form) `define)
           (driver-loop (bind (list (caadr form))
                              (list (list (cdadr form) (caddr form)))
                              procedures)
                        (print (caadr form))))
          (#t (driver-loop procedures (print (eval form `() procedures))))))
