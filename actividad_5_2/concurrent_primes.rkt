#|
Valeria Pineda, A01023979
Eduardo Villalpando, A01023646
Lourdes Badillo, A01024232
27/05/2021
|#

#lang racket

; Define if a number is prime
(define (prime? n)
  (cond
    ; 0 isn't prime
    [(< n 2) #f]
    ; 2 is tho ;)
    [(equal? n 2) #t]
    [else
      ; loop...
      (let loop
        ([n n] [i 2] [limit (sqrt n)])
        ; if n%i == 0 ==> return false
        (if (zero? (remainder n i))
          #f
          (if (< i limit)
            (loop n (add1 i) limit)
            #t)))]))

; Sums elements in list
(define (sum-list lst)
  (let loop
        ([lista lst] [res 0])
        (if (empty? lista)
            ; Add 0
            res
            ; Add first in list
            (loop (cdr lista) (+ res (car lista))))))

; Add up prime numbers from i to limit sequentially
(define (sequential i limit)
  (let loop
    ([i i] [primes empty])
    (if (> i limit)
      (sum-list primes)
      (if (prime? i)
        (loop (add1 i) (append primes (list i)))
        (loop (add1 i) primes)))))

; Add up prime numbers from i to limit using futures
(define (make-threads min-num limit)
  (future (lambda ()
    (sequential min-num limit))))

; Find ranges of numbers to call in threads
(define (parallel limit threads)
  ; Get ranges of maximum values
  (define range-max (let loop
    ([i (floor (/ limit threads))] [ranges empty] [count 1])
    (if (< count threads)
      (loop (+ i (floor (/ limit threads))) (append ranges (list i)) (add1 count))
      (append ranges (list limit)))))
  ; Get ranges of minimum values
  (define range-min (let loop
    ([i 1] [ranges empty] [max range-max] [count 0])
    (if (< count threads)
      (loop (+ (car max) 1) (append ranges (list i)) (cdr max) (add1 count))
      ranges)))
  ; Create each thread
  (define futures (map make-threads range-min range-max))
  ; Get threads going and sum each thread
  (sum-list (map touch futures)))

; Measure execution time 
(define (timerSeq func arg1 arg2)
  (define begin (current-inexact-milliseconds))
  (sequential arg1 arg2)
  (- (current-inexact-milliseconds) begin))

(define (timerPar func arg1 arg2)
  (define begin (current-inexact-milliseconds))
  (func arg1 arg2)
  (- (current-inexact-milliseconds) begin))
