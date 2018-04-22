; some examples of functions written in scheme

; note interpreter zero cant handle: mapcar, etc...

(define (second x) (car (cdr x)))

(define (factorial x)
        (cond ((= x 0) 1)
               (#t (* x (factorial ( - x 1))))))

(define (equal x y)
        (cond ((number? x)
               (cond ((number? y) (= x y))
                      (#t nil)))
              ((atom x) (eq? x y))
              ((atom y) nil)
              ((equal (car x) (car y))
               (equal (cdr x) (cdr y)))))

(define (mapcar f l)
        (cond (( null? l) `())
              (#t (cons (f (car l))
                         (mapcar f (cdr l))))))
