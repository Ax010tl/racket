#|
Implement a Deterministic Finite Automata
Valeria Pineda, A01023979
Eduardo Villalpando, A01023646
Lourdes Badillo, A01024232
24/03/2021
|#

#lang racket

(require racket/trace)

; run it quicker
; racket -it filename.rkt
(provide arithmetic-lexer)

(define (validate-string input-string dfa)
  " Determine if the input string is accepted by the dfa
  Ex: (validate-string 'abababa' (list accept-start-ba 'q0 '(q2)))
  Ex: (validate-string '1+1' (list accept-simple-arithmetic-with-type 'q0 '('int 'float 'space)))
  Arguments:
  input-string - string
  dfa - list with these elements
            * transition function
            * start state
            * list of accept states
  Return: boolean "
  (let loop
    ( [lst (string->list input-string)]
      [transition (car dfa)] ; The first element in the list
      [state (cadr dfa)]     ; The second element in the list
      ; [item (cadr dfa)]    ; - The third element in list ()
      [item-list empty]      ; - List of elements
      [token-list empty])    ; - List of types of tokens
    (if (empty? lst)
      ; Check if the final state is in the list of acceptables
      (if (member state (caddr dfa))
        ; Return the list of tokens and the last accept state
        (if (equal? state 'blank-after-var)
          token-list
          (append token-list (list (list (process item-list) state))))
        #f)
      (let-values
        ([(state token-type item) (transition state (car lst))])
        ; Recursive call
        (loop
          (cdr lst)
          ; Pass the same function again
          transition
          state
          ; Add valid items to the list
          (if (char-blank? item)
            empty
            (if token-type
              (list item)
              (append item-list (list item))))
          ; Add valid tokens to the list
          (if token-type
            (append token-list (list (list (process item-list) token-type)))
            token-list))))))

(define (accept-simple-arithmetic-with-type state symbol)
    " Transition function that accepts arithmetic
    expressions with decimal point. Acceptance states:
            * 'int
            * 'float
            * 'space 
            * 'variable
            * 'parenthesis"
  (let
    ([operator (list #\+ #\- #\* #\/ #\^ #\=)]
     [parentheses (list #\( #\) )]
    )
    (cond
      [(eq? state 'q0) (cond ; Initial char
        ; 0...9
        [(char-numeric? symbol) (values 'int #f symbol)]
        ; blank space or tab
        [(char-blank? symbol) (values 'q0 #f symbol)]
        ; negative numbers
        [(eq? symbol #\-) (values 'int #f symbol)]
        ; variable
        [(char-alphabetic? symbol) (values 'variable #f symbol)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis #f symbol)]
        ; arithmetic operator and decimal point
        [else (values 'invalid #f symbol)])]
      [(eq? state 'parenthesis) (cond ; Initial char
        ; 0...9
        [(char-numeric? symbol) (values 'int 'parenthesis symbol)]
        ; blank space or tab
        [(char-blank? symbol) (values 'space 'parenthesis symbol)]
        ; negative numbers
        [(eq? symbol #\-) (values 'int #f symbol)]
        ; variable
        [(char-alphabetic? symbol) (values 'variable 'parenthesis symbol)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis 'parenthesis symbol)]
        ; arithmetic operator and decimal point
        [else (values 'invalid #f symbol)])]
      [(eq? state 'int) (cond ; Int
        ; 0...9
        [(char-numeric? symbol) (values 'int #f symbol)]
        ; blank space or tab
        [(char-blank? symbol) (values 'blank-after-var 'int symbol)]
        ; arithmetic operators
        [(member symbol operator) (values 'operator 'int symbol)]
        ; decimal point
        [(eq? symbol #\.) (values 'float #f symbol)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis 'int symbol)]
        ; letters or something else
        [else (values 'invalid #f symbol)] )]
      [(eq? state 'float) (cond ; Number after decimal point
        ; 0...9
        [(char-numeric? symbol) (values 'float #f symbol)]
        ; blank space or tab
        [(char-blank? symbol) (values 'blank-after-var 'float symbol)]
        ; arithmetic operators
        [(member symbol operator) (values 'operator 'float symbol)]
        ; decimal point
        [(eq? symbol #\.) (values 'invalid 'float symbol)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis 'float symbol)]
        ; variable or something else
        [else (values 'invalid #f symbol)] )]
      [(eq? state 'space) (cond ; Space
        ; blank space or tab
        [(char-blank? symbol) (values 'space #f symbol)]
        ; arithmetic operators
        [(member symbol operator) (values 'operator #f symbol)]
        ; decimal point
        [(eq? symbol #\.) (values 'invalid #f symbol)]
        ; 0...9
        [(char-numeric? symbol) (values 'int #f symbol)]
        ; variable
        [(char-alphabetic? symbol) (values 'variable #f symbol)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis #f symbol)]
        ; something else
        [else (values 'invalid #f symbol)] )]
      [(eq? state 'operator) (cond ; Symbol
        ; blank space or tab
        [(char-blank? symbol) (values 'blank-after-symbol 'operator symbol)]
        ; 0...9
        [(char-numeric? symbol) (values 'int 'operator symbol)]
        ; arithmetic operator
        [(member symbol operator) (values 'invalid 'operator symbol)]
        ; decimal point
        [(eq? symbol #\.) (values 'invalid 'operator symbol)]
        ; variable
        [(char-alphabetic? symbol) (values 'variable 'operator symbol)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis 'operator symbol)]
        ; something else
        [else (values 'invalid #f symbol)] )]
      [(eq? state 'blank-after-symbol) (cond ; blank space after symbol
        ; blank space or tab 
        [(char-blank? symbol) (values 'blank-after-symbol #f symbol)]
        ; arithmetic operators
        [(member symbol operator) (values 'invalid #f symbol)]
        ; decimal point
        [(eq? symbol #\.) (values 'invalid #f symbol)]
        ; 0...9
        [(char-numeric? symbol) (values 'int #f symbol)]
        ; variable
        [(char-alphabetic? symbol) (values 'variable #f symbol)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis #f symbol)]
        ; something else
        [else (values 'invalid #f)] )]
      [(eq? state 'blank-after-var) (cond ; blank space after a variable
        ; blank space or tab
        [(char-blank? symbol) (values 'blank-after-var #f symbol)] 
        ; arithemtic operator
        [(member symbol operator) (values 'operator #f symbol)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis #f symbol)]
        ; something else
        [else (values 'invalid #f symbol)] )]
      [(eq? state 'variable) (cond ; a variable (can have numbers, letters or _)
        ; 0...9
        [(char-numeric? symbol) (values 'variable #f symbol)]
        ; letters
        [(char-alphabetic? symbol) (values 'variable #f symbol)]
        ; underscore
        [(eq? symbol #\_) (values 'variable #f symbol)]
        ; arithmetic operator
        [(member symbol operator) (values 'operator 'variable symbol)]
        ; blank space or tab 
        [(char-blank? symbol) (values 'blank-after-var 'variable symbol)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis 'variable symbol)]
        ; something else
        [else (values 'invalid #f symbol)])]
      [(eq? state 'invalid) (values 'invalid #f symbol)])))

(define (arithmetic-lexer str) 
  (validate-string str (list accept-simple-arithmetic-with-type 'q0 (list 'int 'float 'space 'variable 'parenthesis 'blank-after-var))))

; Function obtained from https://stackoverflow.com/questions/38089276/how-to-convert-a-list-of-chars-and-ints-to-a-string
(define (process lst)
  (apply string-append        ; append all the strings
    (map (lambda (e)          ; create a list of strings
      (if (char? e)           ; if it's a char
        (string e)            ; convert it to string
        (number->string e)))  ; same if it's a number
      lst)))
