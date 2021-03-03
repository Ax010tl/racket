#lang racket
; Ejercicio 10 :D
; Regresar lista con números positivos
(define (positives lista)
    (let loop
        ([lista lista] [res empty])
        ; Checar si la lista está vacía
        (if (empty? lista)
            res
            ; Si el valor es positivo...
            (if (positive? (car lista))
                (loop (cdr lista) (append res (list(car lista))))
                (loop (cdr lista) res)
            )
        )
    )
)

; Ejercicio 11
; Sumar elementos de lista
(define (add-list lista)
    (let loop
        ([lista lista] [res 0])
        (if (empty? lista)
            ; Sumar 0
            res
            ; Sumar primero de lista
            (loop (cdr lista) (+ res (car lista)))
        )
    )
)

; Ejercicio 12
; Invertir pares
(define (invert-pairs lista)
    (let loop
        ([lista lista] [res empty])
        (if (empty? lista)
            res
            (let 
                ([first (car (car lista))] [second (cadr (car lista))])
                (loop (cdr lista) 
                    (append res (list (list second first)) )
                )
            )
        )
    )
)

