#|
Valeria Pineda, A01023979
Eduardo Villalpando, A01023646
Lourdes Badillo, A01024232
12/05/2021
|#

#lang racket

(define (aiuda in-path)
  ; Store the content in lines (string list)
  (define lines (file->lines in-path))
  (let loop
    ([lines lines])
    (if (null? lines)
        ; if empty, do this
        (display " ")
        ; if not empty, do this        
        (let* (
            [dis-line (car lines)]          
            ; Find all keys with regex and replace them with html format
            [dis-line (regexp-replace* #px"(?:\"(?:.*?)\")(:)" dis-line "<span class='keys'> & </span>")]   
            ; Find all strings with regex and replace them with html format
            [dis-line (regexp-replace* #px"(?:\"(?:.*?)\")" dis-line "<span class='strings'>&</span>")]
            ; Find all numbers with regex and replace them with html format
            [dis-line (regexp-replace* #px"(?:-)?\\d+(?:.\\d*)?(?:[Ee])?(?:[+-])?(?:\\d*)?" dis-line "<span class='numbers'>&</span>")]
            ; Find all chars with regex and replace them with html format
            [dis-line (regexp-replace* #px"'[\\w\\W]'" dis-line "<span class='chars'>&</span>")]
            ; Find all booleans with regex and replace them with html format"
            [dis-line (regexp-replace* #px"\\b(?:true|false|null)\\b" dis-line "<span class='bools'>&</span>")]
            ; Find all special elements with regex and replace them with html format
            [dis-line (regexp-replace* #px"[,\\[\\]{}]" dis-line "<span class='special'>&</span>")]
        ) 
            (display dis-line)
            (loop (cdr lines)))
    )
  )
)

; TODO: unirlo todo en una lista y escribirla en un archivo
; TODO: hacer una página muy wapa
