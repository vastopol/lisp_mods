; interpreter version zero

: part 1
; top level driver loop for a recursion equations interpreter
; driver-loop takes a list of the primitive procedures as its first argument ***** FIXME: currently empty list *****

(define (driver)
        (driver-loop `() (print '|lisp is listening|)))

(define (driver-loop procedures hunoz) ; what is hunoz ?
        (driver-loop-1 procedures (read)))

(define (driver-loop-1 procedures form)
    (cond ((atom form)
           (driver-loop procedures (print (eval form `() procedures))))
          ((eq? (car form) `define)
           (driver-loop (bind (list (caadr form))
                              (list (list (cdadr form) (caddr form)))
                              procedures)
                        (print (caadr form))))
          (#t (driver-loop procedures (print (eval form `() procedures))))))

;-------------------------------------------------------------------------------

;part 2
; evaluator for a recursion equations interpreter

(define (eval exp env procedures)
        (cond ((atom exp)
               (cond ((eq? exp `nil) `nil)
                     ((eq? exp `#t) `#t)
                     ((number? exp) exp)
                     (#t (value exp env))))
              ((eq? (car exp) `quote)
               (cadr exp))
              ((eq? (car exp) `cond)
               (evcond (cdr exp) env procedures))
              (#t (apply (value (car exp) procedures)
                         (evlis (cdr exp) env procedures)
                         procedures))))

(define (apply fun args procedures)
        (cond ((primop fun) (primop-apply fun args))
              (#t (eval (cadr fun)
                        (bind (car fun) args `())
                        procedures))))

(define (evcond clauses env procedures)
        (cond ((null? clauses) (error))
              ((eval (caar clauses) env procedures)
               (eval (cadar clauses) env procedures))
              (#t (evcond (cdr clauses) env procedures))))

(define (evlis arglist env procedures)
        (cond ((null? arglist) `())
              (#t (cons (eval (car arglist) env procedures)
                        (evlis (cdr arglist) env procedures)))))

;-------------------------------------------------------------------------------


; part 3
; utility routines for maintaining environments
