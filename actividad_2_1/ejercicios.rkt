; Lourdes Badillo, A01024232
; Valeria Pineda, A01023979
; Eduardo Villalpando, A01023646
; Prof. Gilberto Echeverría
; Implementación de métodos computacionales
; Actividad 2.1

#lang racket
 
; Ejercicio Fahrenheit F de Farenheit y de F
(define (fahrenheit_to_celsius f) 
    (* (- f 32) (/ 5 9))
)

; Ejercicio Sign 
(define (sign n)
    (if (zero? n)
        0
        (if (positive? n) 1 -1)
    )
)

; Ejercicio BMI 
(define (BMI weight height)
    (define bmi(/ weight (* height height)))
    (cond
        ([< bmi 20] "underweight")
        ([< bmi 25] "normal")
        ([< bmi 30] "obese 1")
        ([< bmi 40] "obese 2")
        (else "obese 3")
    )
)

; Ejercicio roots (REVISAR)
(define (roots a b c)
    (define (discriminante a b c)
        (sqrt (- (* b b) (* 4 a c) ))
    )
    (define (numerador a b c)
        (+ (* b -1) (discriminante a b c))
    )
    (/ (numerador a b c) (* 2 a))
)

; Ejercicio Factorial 
(define (factorial n)
    (if(<= n 1) 1
        (* (factorial(- n 1)) n)
    )
)

; Ejercicio Fibonacci :'(
(define (fibonacci n)
    (if(<= n 1) n
        (+ (fibonacci(- n 1)) (fibonacci(- n 2)))
    )
)

; Ejercicio Potencia
(define (pow base pot)
    (if(<= pot 0) 1
        (* base (pow base (- pot 1) ))
    )
)