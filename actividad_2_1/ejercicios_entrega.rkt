; Valeria Pineda, A01023979
; Eduardo Villalpando, A01023646
; Lourdes Badillo, A01024232
; Prof. Gilberto Echeverría
; Implementación de métodos computacionales
; Actividad 2.1
; https://experiencia21.tec.mx/courses/135996/files/36081877/download?wrap=1
#lang racket

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
        ([lst lst] [check #t])
        (if (empty? lst)
            check
            (if (not (symbol? (car lst)))
                #f
                (loop (cdr lst) #t)
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
