; Lourdes Badillo, A01024232
; Valeria Pineda, A01023979
; Eduardo Villalpando, A01023646
; Prof. Gilberto Echeverría
; Implementación de métodos computacionales
; Actividad 2.2
; Ejericios 6, 13, 14, 15

#lang racket

;6 La función deep-reverse toma una lista como entrada. Devuelve una lista con los mismos elementos que su entrada pero en orden inverso. Si hay listas anidadas, estas también deben invertirse.
(define (deep-reverse lst)
    ; Loop trough the list
    (let loop
        ([lst lst] [res empty])
        (if (empty? lst)
            ; If the list is empty, return new list
            res
            ; If the list is not empty, do the following 
            (let
                ; Store the first value of the list 
                ([ element (first lst) ])
                (if(list? element)
                    ; If this element is a list, apply the following function
                    ; Add the remaining elements of the list 
                    (loop (rest lst) ( cons (deep-reverse element) res ) )
                    (loop (rest lst) ( cons element res ) )
                )
            )
        )
    )
)


; 13 La función args-swap toma como entrada una función de dos argumentos f y devuelve una nueva función que se comporta como f pero con el orden de sus dos argumentos intercambiados

(define ((args-swap function) a b)
    ; Return the function with the parameters swapped 
    (function b a)
)

; 14 La función there-exists-one? toma dos entradas: una función booleana de un argumento pred y una lista lst. Devuelve verdadero si hay exactamente un elemento en lst que satisface pred, en otro caso devuelve falso.
(define (there-exists-one? pred lst)
    (let loop
        ([lst lst] [count 0] [res #f])
        (if (empty? lst)
            res
            ; Check with function 
            (if (pred (car lst))
                ; Check if there's only one element that fulfills the condition 
                (if (= 1 count)
                    #f
                    (loop (cdr lst) (+ count 1) #t)
                )
                ; Keep searching in lst 
                (loop (cdr lst) count res)
            )
        )
    )
)

; 15 La función linear-search toma tres entradas: una lista lst, un valor x, y una función de igualdad eq-fun. Busca secuencialmente x en lst usando eq-fun para comparar x con los elementos contenidos en lst. La función eq-fun debe aceptar dos argumentos, a y b, y devolver verdadero si se debe considerar que a es igual a b, o falso en caso contrario. La función linear-search devuelve el índice donde se encuentra la primera ocurrencia de x en lst (el primer elemento de la lista se encuentra en el índice 0), o falso si no se encontró.
(define (linear-search lst x eq-fun)
    (let loop
        ([lst lst] [index 0])
        (if (empty? lst)
            ; If the list doesnt have the element
            #f
            (if (eq-fun x (car lst))
                ; Element found :D
                index
                ; Keep searching for the element... ;(
                (loop (cdr lst) (+ index 1))
            )
        )
    )
)