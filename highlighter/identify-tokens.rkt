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
    ([lines lines] [res empty])
    (if (null? lines)
        ; if empty, return res
        ; (display " ")
        res
        ; if not empty, do this        
        (let* (
            [dis-line (car lines)]
            ; Find all numbers with regex and replace them with html format
            [dis-line (regexp-replace* #px"[^\"\\w:](\\-)?\\d+(?:\\.\\d)?((?:[Ee][+\\-])(?:\\d*))?[^\"\\w:\\/]" dis-line "<span class='numbers'>&</span>")]
            ; Find all strings with regex and replace them with html format
            [dis-line (regexp-replace* #px"(?:\"(?:.*?)\")" dis-line "<span class='strings'>&</span>")]
            ; Find all keys with regex and replace them with html format
            ;[dis-line (regexp-replace* #px"^(?:\"(?:.*?)\")" dis-line "<span class='keys'>&</span> ")]
            [dis-line (regexp-replace* #px"(?:\"(?:.*?)\":)" dis-line "<span class='keys'>&</span> ")]   
            ; Find all chars with regex and replace them with html format
            [dis-line (regexp-replace* #px"'[\\w\\W]'" dis-line "<span class='chars'>&</span>")]
            ; Find all booleans with regex and replace them with html format"
            [dis-line (regexp-replace* #px"\\b(?:true|false|null)\\b" dis-line "<span class='bools'>&</span>")]
            ; Find all special elements with regex and replace them with html format
            [dis-line (regexp-replace* #px"[,\\[\\]{}:]" dis-line "<span class='special'>&</span>")]
        ) 
            (display dis-line)
            (loop (cdr lines) (append res (list dis-line))) )
    )
  )
)

; TODO: unirlo todo en una lista y escribirla en un archivo

(define (write-file in-path out-path)
  (call-with-output-file out-path #:exists 'truncate
    (lambda (out)
      (display "<!DOCTYPE html>
        <html lang=\"en\">
        <head>
            <meta charset=\"UTF-8\">
            <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
            <title>JSON Highlighter</title>
            <link rel=\"stylesheet\" href=\"styles.css\">
        </head>
        <body> <h1>JSON Highlighter</h1>" out)))
  (display-lines-to-file (aiuda in-path) out-path #:exists 'append)
)



; TODO: hacer una página muy wapa <3 xd