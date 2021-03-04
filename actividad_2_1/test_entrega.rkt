; Valeria Pineda, A01023979
; Eduardo Villalpando, A01023646
; Lourdes Badillo, A01024232
; Prof. Gilberto Echeverría
; Implementación de métodos computacionales
; Actividad 2.1
; https://experiencia21.tec.mx/courses/135996/files/36081877/download?wrap=1
#lang racket

; Import library for unit testing
(require rackunit)
; Import necesary to view the test results
(require rackunit/text-ui)

;Ejercicio 12
; Invertir pares
(define (invert-pairs lista)
    (let loop
        ; Inicializa una copia de la lista original e inicializa la lista resultado vacía
        ([lista lista] [res empty])
        (if (empty? lista)
            ; Regresa el resultado cuando la lista original está vacía
            res
            (let 
                ; Agarra primer y segundo elemento de la lista
                ([first (car (car lista))] [second (cadr (car lista))])
                ; Llamar al loop para hacer lo mismo con el resto de la lista
                (loop (cdr lista) 
                    ; Añadir segundo y primero (com una lista) a la lista resultado
                    (append res (list (list second first)) )
                )
            )
        )
    )
)

;Ejercicio 13
; La función de list-of-symbols? toma una lista lst como entrada. Devuelve verdadero si todos los elementos (posiblemente cero) contenidos en lst son símbolos, o falso en caso contrario.
(define (list-of-symbols? lst)
    (let loop
        ; Inicializar nueva lista y variable booleana que va a checar si el valor es un símbolo
        ([lst lst] [check #t])
        (if (empty? lst)
            ; Si la lista está vacía regresa check
            check
            ; Checa si el primer elemento de la lista es un símbolo
            (if (symbol? (car lst))
                ; Cuando sí es un símbolo procede a checar el resto de los elementos de la lista
                (loop (cdr lst) #t)
                ; Cuando no es un símbolo regresa false y deja de checar los elementos de la lista que siguen
                #f
            )
        )
    )
)

;Ejercicio 14
; Swapper toma tres entradas: dos valores a y b, y una lista lst. Devuelve una nueva lista en la que cada ocurrencia de a en lst se intercambia por b, y viceversa. Cualquier otro elemento de lst permanece igual. Se puede suponer que lst no contiene listas anidadas.
(define (swapper a b lst)
    (let loop
        ([lst lst] [res empty])
        ; Checar si la lista está vacía
        (if (empty? lst)
            res
            ; Cambiar valores si se cumple la condición, o regresar el elemento
            (cond
                [(eq? a (car lst)) (loop (cdr lst) (append res (list b)))] ; a->b
                [(eq? b (car lst)) (loop (cdr lst) (append res (list a)))] ; b->a
                [else (loop (cdr lst) (append res (list (car lst))))] 
            )
        )
    )
)

;Ejercicio 18
; replic toma dos entradas: una lista lst y un número entero n, donde n ≥ 0. Devuelve una nueva lista que replica n veces cada elemento contenido en lst.

(define (replic n lst)
    (let loop
        ; Inicializa la nueva lista
        ([lst lst] [res empty])
        (if (empty? lst)
            ; Si la lista está vacía, regresar
            res
            ; Si la lista no está vacía, seguir iterando
            (loop (cdr lst)
                (let 
                    ; Almacenar el valor actual de la lista en element
                    ([element (car lst)])
                    ; Agregar contenido a res
                    (append res (
                        for/list ([i n]) element ; Regresar element n veces
                    ))
                )
            )
        )
    )
)

; HW
(define test-invert-pairs
    (test-suite
        " Test function: invert-pairs"
        (check-equal? (invert-pairs '()) '() "Empty list")
        (check-equal? (invert-pairs '((a 1) (a 2) (b 1) (b 2))) '((1 a) (2 a) (1 b) (2 b)) "4 pairs")
        (check-equal? (invert-pairs '((January 1) (February 2) (March 3))) '((1 January) (2 February) (3 March)) "3 pairs")
    ))

; HW
(define test-list-of-symbols?
    (test-suite
        " Test function: list-of-symbols?"
        (check-equal? (list-of-symbols? '()) #t "Empty list")
        (check-equal? (list-of-symbols? '(a b c d e)) #t "all symbols")
        (check-equal? (list-of-symbols? '(a b c d 42 e)) #f "a non symbol")
    ))

; HW
(define test-swapper
    (test-suite
        " Test function: swapper"
        (check-equal? (swapper 1 2 '()) '() "Empty list")
        (check-equal? (swapper 1 2 '(4 4 5 2 4 8 2 5 6 4 5 1 9 5 9 9 1 2 2 4)) '(4 4 5 1 4 8 1 5 6 4 5 2 9 5 9 9 2 1 1 4) "multiple swaps")
        (check-equal? (swapper 1 2 '(4 3 4 9 9 3 3 3 9 9 7 9 3 7 8 7 8 4 5 6)) '(4 3 4 9 9 3 3 3 9 9 7 9 3 7 8 7 8 4 5 6) "no swaps")
        (check-equal? (swapper 'purr 'kitty '(soft kitty warm kitty little ball of fur happy kitty sleepy kitty purr purr purr)) '(soft purr warm purr little ball of fur happy purr sleepy purr kitty kitty kitty) "big bang theory")
    ))
(define test-replic
    (test-suite
        " Test function: replic"
        (check-equal? (replic 7 '()) '() "Empty list")
        (check-equal? (replic 0 '(a b c)) '() "0 repetitions")
        (check-equal? (replic 3 '(a)) '(a a a) "3 repetitions")
        (check-equal? (replic 4 '(1 2 3 4)) '(1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4) "4 repetitions")
    ))

(displayln "Testing: invert-pairs")
(run-tests test-invert-pairs)
(displayln "Testing: list-of-symbols")
(run-tests test-list-of-symbols?)
(displayln "Testing: swapper")
(run-tests test-swapper)
(displayln "Testing: replic")
(run-tests test-replic)