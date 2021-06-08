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
  Return: list of lists "
  (let loop
    ( [lst (string->list input-string)]
      [transition (car dfa)] ; The first element in the list
      [state (cadr dfa)]     ; The second element in the list
      [item-list empty]      ; - List of elements
      [token-list empty])    ; - List of types of tokens
    (if (empty? lst)
      ; Check if the final state is in the list of acceptables
      (if (member state (caddr dfa))
        ; Return the list of tokens and the last accept state
        (if (equal? state 'blank-after-var)
          token-list
          (append token-list (list (list (list->string item-list) state))))
        #f)
      (let-values
        ([(state token-type item) (transition state (car lst))])
        ; Recursive call
        (loop
          (cdr lst)
          ; Pass the same function again
          transition
          state
          
        (if token-type
            (list item)
            (append item-list (list item)))
          ; Add valid tokens to the list
          (if token-type
            (append token-list (list (list (list->string item-list) token-type)))
            token-list))))))

(define (accept-simple-arithmetic-with-type state symbol)
    " Transition function that accepts arithmetic
    expressions with decimal point. Acceptance states:
            * 'int
            * 'float
            * 'variable
            * 'parenthesis
            * 'blank-after-var"
  (let
    ([decorators (list #\{ #\} #\[ #\] #\,)]
     [booleans (list #\t #\r #\u #\e #\f #\a #\l #\s #\n)])
    (cond
      [(eq? state 'q0) (cond ; Initial char
        ; keys or strings
        [(eq? symbol #\") (values 'string-like #f symbol)]
        ; booleans
        [(member symbol booleans) (values 'bools #f symbol)]
        ; negative numbers
        [(eq? symbol #\-) (values 'numbers #f symbol)]
        ; 0...9
        [(char-numeric? symbol) (values 'numbers #f symbol)]
        ; decorators
        [(member symbol decorators) (values 'decorators #f symbol)]
        ; blank spaces
        [(char-blank? symbol) (values 'q0 #f symbol)]
        ; anything else
        [else (values 'invalid #f symbol)])]
      [(eq? state 'decorators) (cond ; Decorators
        ; 0...9
        [(char-numeric? symbol) (values 'numbers 'decorators symbol)]
        ; blank space or tab
        [(char-blank? symbol) (values 'decorators #f symbol)]
        ; negative numbers
        [(eq? symbol #\-) (values 'numbers 'decorators symbol)]
        ; booleans
        [(member symbol booleans) (values 'bools 'decorators symbol)]
        ; decorators
        [(member symbol decorators) (values 'decorators 'decorators symbol)]
        ; keys or strings
        [(eq? symbol #\") (values 'string-like 'decorators symbol)]
        ; anything else
        [else (values 'invalid #f symbol)])]
      [(eq? state 'numbers) (cond ; Int
        ; 0...9
        [(char-numeric? symbol) (values 'numbers #f symbol)]
        ; blank space or tab
        [(char-blank? symbol) (values 'numbers #f symbol)]
        ; decimal point
        [(eq? symbol #\.) (values 'float #f symbol)]
        ; decorators
        [(member symbol decorators) (values 'decorators 'numbers symbol)]
        ; exponent
        [(eq? symbol #\e) (values 'exponent #f symbol)]
        [(eq? symbol #\E) (values 'exponent #f symbol)]
        ; anything else
        [else (values 'invalid #f symbol)] )]
      [(eq? state 'float) (cond ; Number after decimal point
        ; 0...9
        [(char-numeric? symbol) (values 'float #f symbol)]
        ; blank space or tab
        [(char-blank? symbol) (values 'float #f symbol)]
        ; decorators
        [(member symbol decorators) (values 'decorators 'numbers symbol)]
        ; exponent
        [(eq? symbol #\e) (values 'exponent #f symbol)]
        [(eq? symbol #\E) (values 'exponent #f symbol)]
        ; anything else
        [else (values 'invalid #f symbol)] )]
      [(eq? state 'exponent) (cond ; What comes after the e/E
        ; 0...9
        [(char-numeric? symbol) (values 'exponent-number #f symbol)]
        ; signs
        [(eq? symbol #\+) (values 'exponent-number #f symbol)]
        [(eq? symbol #\-) (values 'exponent-number #f symbol)]
        ; anything else
        [else (values 'invalid #f symbol)])]
      [(eq? state 'exponent-number) (cond ; Numbers in exponent
        ; 0...9
        [(char-numeric? symbol) (values 'exponent-number #f symbol)]
        ; blank space or tab
        [(char-blank? symbol) (values 'exponent-number #f symbol)]
        ; decorators
        [(member symbol decorators) (values 'decorators 'numbers symbol)]
        ; anything else
        [else (values 'invalid #f symbol)] )]
      [(eq? state 'string-like) (cond ; Could be a key or a string
        ; if it's the end of string like, goes to check if string or key
        [(eq? symbol #\") (values 'strings #f symbol)]
        ; keys/strings can contain any characters
        [else (values 'string-like #f symbol)])]
      [(eq? state 'strings) (cond ; Checks if string or key
        ; if there's a space it carries on with the check
        [(char-blank? symbol) (values 'check #f symbol)]
        ; it's a key!
        [(eq? symbol #\:) (values 'decorators 'keys symbol)]
        ; it's a string!
        [(member symbol decorators) (values 'q0 'strings symbol)]
        ; anything else
        [else (values 'invalid #f symbol)] 
        )]
      [(eq? state 'bools) (cond ; Booleans
        ; checks if it has booolean-valid letters
        [(member symbol booleans) (values 'bools #f symbol)]
        ; anything else
        [else (values 'invalid #f symbol)] )]
      [(eq? state 'invalid) (values 'invalid #f symbol)])))

(define (arithmetic-lexer str) 
  (validate-string str (list accept-simple-arithmetic-with-type 'q0 (list 'numbers 'exponent-number 'keys 'strings 'decorators 'bools 'space 'q0))))

(define (file-reader in-path out-path)
  (let loop
    ([listota (car (map arithmetic-lexer (file->lines in-path)))] [printable empty])
    (if (empty? listota)
      printable
      (loop 
        (cdr listota) 
        (append printable (list (string-append 
            "<span class='" (symbol->string (cadr (car listota))) "'>" (car (car listota)) "</span>"))))))
;   (display-lines-to-file (map arithmetic-lexer (file->lines in-path)) out-path #:exists 'truncate)
)