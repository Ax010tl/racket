#lang racket

(define (average a b c)
	(/ (+ a b c) 3))

(define (triangle-area-sides a b c)
  "Compute the area of a trianlge, given the length of its sides"
  (define s (/ (+ a b c) 2))
  ( sqrt(* s (- s a) (- s b) (- s c)) ) 
)

(define (sign n)
  "Determine if the number is positive, negative of zero"
  (if (zero? n)
  	0
	(if (positive? n)
		1
		-1
	)
  )
)
