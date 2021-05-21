#|
Valeria Pineda, A01023979
Eduardo Villalpando, A01023646
Lourdes Badillo, A01024232
12/05/2021
|#

#lang racket

(define (replace-match in-path)
  ; Store the content in lines (string list)
  (define lines (file->lines in-path))
  (let loop
    ([lines lines] [res empty])
    (if (null? lines)
        ; if empty, return res
        ; (display " ")
        res
        ; if not empty, do this        
        (let* 
          ([dis-line (car lines)]
           ; Find all keys with regex and replace them with html format
           [dis-line (regexp-replace* #px"(?<=)\"(.*?)\" *(?=:)" dis-line "<span class='keys'>%plhldr\\1%plhldr</span>\\3")]
           ; Find all chars with regex and replace them with html format
           [dis-line (regexp-replace* #px"'[\\w\\W]'" dis-line "<span class='chars'>&</span>")]
           ; Find all booleans with regex and replace them with html format
           [dis-line (regexp-replace* #px"\\b(?:true|false|null)\\b" dis-line "<span class='bools'>&</span>")]
           ; Find all special elements with regex and replace them with html format
           [dis-line (regexp-replace* #px"((?<![\\w\\d])[:])|[,\\[\\]{}]" dis-line "<span class='special'>&</span>")]
           ; Find all strings with regex and replace them with html format
           [dis-line (regexp-replace* #px"\"(.*?)\"" dis-line "<span class='strings'>&</span>")]
           ; Find all numbers with regex and replace them with html format
           [dis-line (regexp-replace* #px"((?<= )-?(?:0|[1-9]\\d*)(?:\\.\\d+)?(?:[eE][+\\-]?\\d+)?)(?=([^\"]*\"[^\"]*\")*[^\"]*$)" dis-line "<span class='numbers'>&</span>")]
           ; add quotes to keys
           [dis-line (regexp-replace* #px"%(?<=>)%plhldr|%plhldr(?=<)" dis-line "\"")]
           )
          
          ; go to the next line of the document
          (loop (cdr lines) (append res (list dis-line))) ))))


(define (write-file in-path out-path)
  ; Add HTML to the top
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
        <body> 
        <h1>JSON Highlighter</h1>" 
        out)))
  
  ; Add highlighted syntax
  (display-lines-to-file (replace-match in-path) out-path #:exists 'append)

  ; Add HTML to bottom
  (call-with-output-file out-path #:exists 'append
    (lambda (out)
      (display "<footer>Made with 🏓 and ❤️ by Lourdes, Valeria and Eduardo</footer>
        </body>
        </html>"
        out))))


; Measure execution time for the whole algorithm
(define (timer)
  (define begin (current-inexact-milliseconds))
  (write-file "example.json" "result.html")
  (- (current-inexact-milliseconds) begin))

; Measure execution time for the replace-match function
(define (timer2)
  (define begin (current-inexact-milliseconds))
  (replace-match "example.json")
  (- (current-inexact-milliseconds) begin))