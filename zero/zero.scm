; interpreter version zero

; part 1
; top level driver loop for a recursion equations interpreter
; driver-loop takes a list of the primitive procedures as its first argument ***** FIXME currently empty list *****

(define (driver)
        (driver-loop `() (print '|lisp is listening|)))

(define (driver-loop procedures whoknows) ; what is whoknows ?
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

(define (bind vars args env)
        (cond ((= (length vars) (length args))
               cons (cons vars args) env))
              (#t (error)))

(define (value name env)
        (value1 name (lookup name env)))

(define (value1 name slot)
        (cond ((eq? slot `&unbound) (error))
              (#t (car slot))))

(define (lookup name env)
        (cond ((null? env) `&unbound)
              (#t (lookup1 name (caar env) (cdr env) env))))

(define (lookup1 name vars vals env)
        (cond ((null? vars) (lookup name (cdr env)))
              ((eq? name (car vars)) vals)
              (#t (lookup1 name (cdr vars) (cdr vals) env))))
