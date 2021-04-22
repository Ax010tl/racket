#lang racket

(provide main)
; Reads file into list
(define (read-file path)
  ; Opens file in path 
  (call-with-input-file path
    (lambda (in)
      (let loop
        ; Loops trough each new line in the file 
        ([new-line (read-line in)]
        ; Empty list to store all lines in file
         [res empty])
        (if (eof-object? new-line)
          ; If end of file, return res
          res
          ; Else, run again and append new line to res
          (loop (read-line in) (append res (list new-line))))
      )
    )
  )
)

(define (write-file path lst)
  (call-with-output-file path #:exists 'truncate
    (lambda (out)
      (map (lambda (lst) (displayln lst out)) lst)
    )
  )
)

(define (main path-in path-out)
  ; Sort list in descending order (<)
  (write-file path-out 
    (sort (map string->number (read-file path-in)) <)
  )
)
