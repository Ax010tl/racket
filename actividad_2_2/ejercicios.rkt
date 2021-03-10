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
    ; Función loop para iterar la lista
    (let loop
        ([lst lst] [res empty])
        (if (empty? lst)
            ; Si la lista está vacía, devolver la nueva lista
            res
            ; Si la lista no está vacía, realizar el siguiente procedimiento
            (let
                ; Almacenar el primer valor en la lista
                ([ element (first lst) ])
                (if(list? element)
                    ; Si el primer elemento es lista, aplicar esta función
                    ; Agregar el resto de la lista a res
                    (loop (rest lst) ( cons (deep-reverse element) res ) )
                    (loop (rest lst) ( cons element res ) )
                )
            )
        )
    )
)


; 13 La función args-swap toma como entrada una función de dos argumentos f y devuelve una nueva función que se comporta como f pero con el orden de sus dos argumentos intercambiados

(define ((args-swap function) a b)
  (function b a)
)

; 14 La función there-exists-one? toma dos entradas: una función booleana de un argumento pred y una lista lst. Devuelve verdadero si hay exactamente un elemento en lst que satisface pred, en otro caso devuelve falso.
(define (there-exists-one? pred lst)
    (let loop
        ([lst lst] [count 0] [res #f])
        (if (empty? lst)
            res
            ; checar con función
            (if (pred (car lst))
                ; checar que solo haya un elemento que ya haya cumplido
                (if (= 1 count)
                    #f
                    (loop (cdr lst) (+ count 1) #t)
                )
                ; seguir buscando en lst
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
            ; si la lista no tiene el elemento
            #f
            (if (eq-fun x (car lst))
                ; elemento encontrado :D
                index
                ; sigue buscando el elemento... ;(
                (loop (cdr lst) (+ index 1))
            )
        )
    )
)