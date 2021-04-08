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
        [(char-numeric? symbol) (values 'int #f)]
        ; blank space or tab
        [(char-blank? symbol) (values 'q0 #f)]
        ; negative numbers
        [(eq? symbol #\-) (values 'int #f)]
        ; variable
        [(char-alphabetic? symbol) (values 'variable #f)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis #f)]
        ; arithmetic operator and decimal point
        [else (values 'invalid #f)])]
      [(eq? state 'parenthesis) (cond ; Initial char
        ; 0...9
        [(char-numeric? symbol) (values 'int 'parenthesis)]
        ; blank space or tab
        [(char-blank? symbol) (values 'space 'parenthesis)]
        ; negative numbers
        [(eq? symbol #\-) (values 'int #f)]
        ; variable
        [(char-alphabetic? symbol) (values 'variable 'parenthesis)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis 'parenthesis)]
        ; arithmetic operator and decimal point
        [else (values 'invalid #f)])]
      [(eq? state 'int) (cond ; Int
        ; 0...9
        [(char-numeric? symbol) (values 'int #f)]
        ; blank space or tab
        [(char-blank? symbol) (values 'blank-after-var 'int)]
        ; arithmetic operators
        [(member symbol operator) (values 'operator 'int)]
        ; decimal point
        [(eq? symbol #\.) (values 'float #f)] 
        ; E
        [(eq? symbol #\E) (values 'invalid #f)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis 'int)]
        ; letters or something else
        [else (values 'invalid #f)] )]
      [(eq? state 'float) (cond ; Number after decimal point
        ; 0...9
        [(char-numeric? symbol) (values 'float #f)]
        ; blank space or tab
        [(char-blank? symbol) (values 'blank-after-var 'float)]
        ; arithmetic operators
        [(member symbol operator) (values 'operator 'float)]
        ; decimal point
        [(eq? symbol #\.) (values 'invalid 'float)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis 'float)]
        ; variable or something else
        [else (values 'invalid #f)] )]
      [(eq? state 'space) (cond ; Space
        ; blank space or tab
        [(char-blank? symbol) (values 'space #f)]
        ; arithmetic operators
        [(member symbol operator) (values 'operator #f)]
        ; decimal point
        [(eq? symbol #\.) (values 'invalid #f)]
        ; 0...9
        [(char-numeric? symbol) (values 'int #f)]
        ; variable
        [(char-alphabetic? symbol) (values 'variable #f)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis #f)]
        ; something else
        [else (values 'invalid #f)] )]
      [(eq? state 'operator) (cond ; Symbol
        ; blank space or tab
        [(char-blank? symbol) (values 'blank-after-symbol 'operator)]
        ; 0...9
        [(char-numeric? symbol) (values 'int 'operator)]
        ; arithmetic operator
        [(member symbol operator) (values 'invalid 'operator)]
        ; decimal point
        [(eq? symbol #\.) (values 'invalid 'operator)]
        ; variable
        [(char-alphabetic? symbol) (values 'variable 'operator)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis 'operator)]
        ; something else
        [else (values 'invalid #f)] )]
      [(eq? state 'blank-after-symbol) (cond ; blank space after symbol
        ; blank space or tab 
        [(char-blank? symbol) (values 'blank-after-symbol #f)]
        ; arithmetic operators
        [(member symbol operator) (values 'invalid #f)]
        ; decimal point
        [(eq? symbol #\.) (values 'invalid #f)]
        ; 0...9
        [(char-numeric? symbol) (values 'int #f)]
        ; variable
        [(char-alphabetic? symbol) (values 'variable #f)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis #f)]
        ; something else
        [else (values 'invalid #f)] )]
      [(eq? state 'blank-after-var) (cond ; blank space after a variable
        ; blank space or tab
        [(char-blank? symbol) (values 'blank-after-var #f)] 
        ; arithemtic operator
        [(member symbol operator) (values 'operator #f)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis #f)]
        ; something else
        [else (values 'invalid #f)] )]
      [(eq? state 'variable) (cond ; a variable (can have numbers, letters or _)
        ; 0...9
        [(char-numeric? symbol) (values 'variable #f)]
        ; letters
        [(char-alphabetic? symbol) (values 'variable #f)]
        ; underscore
        [(eq? symbol #\_) (values 'variable #f)]
        ; arithmetic operator
        [(member symbol operator) (values 'operator 'variable)]
        ; blank space or tab 
        [(char-blank? symbol) (values 'blank-after-var 'variable)]
        ; parentheses
        [(member symbol parentheses) (values 'parenthesis 'variable)]
        ; something else
        [else (values 'invalid #f)])]
      [(eq? state 'invalid) (values 'invalid #f)])))

(define (arithmetic-lexer str) 
  (validate-string str (list accept-simple-arithmetic-with-type 'q0 (list 'int 'float 'space 'variable 'parenthesis)))
)
; " 1 + 1"
; "a _"
; "         1         + 23f"
; " _ "
; "."
; "-9"
; "*9"
; "1."
; "().1"

; parenthesis

;opcional: E, //