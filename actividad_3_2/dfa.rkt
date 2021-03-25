#|
Implement a Deterministic Finite Automata
Valeria Pineda, A01023979
Eduardo Villalpando, A01023646
Lourdes Badillo, A01024232
24/03/2021
|#

#lang racket

(require racket/trace)

(define (validate-string input-string dfa)
  " Determine if the input string is accepted by the dfa
  Ex: (validate-string 'abababa' (list accept-start-ba 'q0 '(q2)))
  Ex: (validate-string '1+1' (list accept-simple-arithmetic-with-type 'q0 '('number 'decimal 'space)))
  Arguments:
  input-string - string
  dfa - list with these elements
            * transition function
            * start state
            * list of accept states
  Return: boolean "
  (trace-let loop
    ([lst (string->list input-string)]
     [state (cadr dfa)]     ; The second element in the list
     [token-list empty]
     [transition (car dfa)]) ; The first element in the list
    (if (empty? lst)
        ; Check if the final state is in the list of acceptables
        (if (member state (caddr dfa))
            ; Return the list of tokens and the last accept state
            (append token-list (list state))
            #f)
        (let-values
          ([(state token-type) (transition state (car lst))])
          ; Recursive call
          (loop
            (cdr lst)
            state
            ; Add valid tokens to the list
            (if token-type
              (append token-list (list token-type))
              token-list)
            ; Pass the same function again
            transition))
        )
    )
)



(define (accept-simple-arithmetic state symbol)
  " Accepts arithmetic expressions with positive integers"
  (let
    ([ops (list #\= #\+ #\- #\* #\/ #\^)])
    (cond
      [(eq? state 'q0) (cond
        [(char-numeric? symbol) (values 'int #f)]
        [(member symbol ops) (values 'invalid #f)])]
      [(eq? state 'int) (cond
        [(char-numeric? symbol) (values 'int #f)]
        [(member symbol ops) (values 'op 'int)])] ; An int had been found
      [(eq? state 'op) (cond
        [(char-numeric? symbol) (values 'int 'op)] ; Found an operator
        [(member symbol ops) (values 'invalid #f)])]
      [(eq? state 'invalid) (values 'invalid #f)])))

(define (accept-simple-arithmetic-with-type state symbol)
    " Transition function that accepts arithmetic
    expressions with decimal point. Acceptance states:
            * 'number
            * 'decimal
            * 'space "
    (let
      ([operator (list #\+ #\- #\* #\/ #\^)])
      (cond
          [(eq? state 'q0) (cond ; Initial char
              ; 0...9
              [(char-numeric? symbol) (values 'number #f)]
              ; blank space or tab
              [(char-blank? symbol) (values 'q0 #f)]
              ; arithmetic operators
              [(member symbol operator) (values 'invalid #f)]
              ; decimal point
              [(eq? symbol #\.) (values 'invalid #f) ])]
          [(eq? state 'number) (cond ; Number TODO:cambiar a int
              ; 0...9
              [(char-numeric? symbol) (values 'number #f)]
              ; blank space or tab
              [(char-blank? symbol) (values 'space 'int)]
              ; arithmetic operators
              [(member symbol operator) (values 'operator 'int)]
              ; decimal point
              [(eq? symbol #\.) (values 'decimal 'int) ])]
          [(eq? state 'decimal) (cond ; Number after decimal point
              ; 0...9
              [(char-numeric? symbol) (values 'decimal #f)]
              ; blank space or tab
              [(char-blank? symbol) (values 'space 'float)]
              ; arithmetic operators
              [(member symbol operator) (values 'operator 'float)]
              ; decimal point
              [(eq? symbol #\.) (values 'invalid 'float)])]
          [(eq? state 'space) (cond ; Space
              ; blank space or tab
              [(char-blank? symbol) (values 'space #f)]
              ; arithmetic operators
              [(member symbol operator) (values 'operator 'space)]
              ; decimal point
              [(eq? symbol #\.) (values 'invalid 'space)]
              ; 0...9
              [(char-numeric? symbol) (values 'number 'space)])]
          [(eq? state 'operator) (cond ; Symbol
              ; blank space or tab
              [(char-blank? symbol) (values 'blank-after-symbol 'operator)]
              ; 0...9
              [(char-numeric? symbol) (values 'number 'operator)]
              ; arithmetic operator
              [(member symbol operator) (values 'invalid 'operator)]
              ; decimal point
              [(eq? symbol #\.) (values 'invalid 'operator)])]
          [(eq? state 'blank-after-symbol) (cond ; blank space after symbol
              ; blank space or tab 
              [(char-blank? symbol) (values 'blank-after-symbol #f)]
              ; arithmetic operators
              [(member symbol operator) (values 'invalid 'space)]
              ; decimal point
              [(eq? symbol #\.) (values 'invalid 'space)]
              ; 0...9
              [(char-numeric? symbol) (values 'number 'space)])]
          [(eq? state 'invalid) (values 'invalid #f)]
        ))
)

(define (test str) 
  (validate-string str (list accept-simple-arithmetic-with-type 'q0 (list 'number 'decimal 'space)))
)