#lang racket

(define null-board '((0 0 0 0) (0 0 0 0) (0 0 0 0) (0 0 0 0)))
(define sample-board '((2 2 4 8) (2 2 4 4) (4 8 16 32) (8 16 32 64)))
(define full-board '((4 8 2 4) (2 2 4 16) (32 128 64 32) (256 16 8 2)))

(define (append a b)
  (if (null? a) b (cons (car a) (append (cdr a) b))))

(define (reverse ls)
  (if (null? ls) '() (append (reverse (cdr ls)) (list (car ls)))))

(define (len ls)
  (if (null? ls) 0 (+ 1 (len (cdr ls)))))

(define (index num ls)
  (if (zero? num) (car ls) (index (- num 1) (cdr ls))))

(define (flatten board)
  (if (null? board) '() (append (car board) (flatten (cdr board)))))

(define (unflatten board (acc '()))
  (cond ((null? board) (list acc))
        ((= 4 (len acc)) (cons (reverse acc) (unflatten board)))
        (else (unflatten (cdr board) (cons (car board) acc)))))

(define (game-over score)
  (begin (display "game over\n")
         (display "score: ")
         (display score)))

(define (print board score)
  (begin (letrec ((print-board
                   (lambda (board)
                    (if (null? board)
                        '()
                        (begin (display (car board))
                               (newline)
                               (print-board (cdr board))))))) ; length of numbers not taken into account
           (print-board board))
         (display "score: ")
         (display score)
         (newline)))                

(define (new-num board)

  (define (find-zeros board (i 0))
    (cond ((null? board) '())
          ((zero? (car board)) (cons i (find-zeros (cdr board) (+ 1 i))))
          (else (find-zeros (cdr board) (+ 1 i)))))

  (define (add-num board zeros)
    (define zero-in-list (random (len zeros)))
    (define zero-index (index zero-in-list zeros))  
    (letrec ((add-num-iter
              (lambda (board i)
               (if (eq? i zero-index)
                   (cons 2 (cdr board))
                   (cons (car board) (add-num-iter (cdr board) (+ 1 i)))))))
      (add-num-iter board 0)))

  (if (null? (find-zeros (flatten board)))
      #f
      (unflatten (add-num (flatten board) (find-zeros (flatten board))))))

(define (player-move board)

  (define (combine-board board (new-board '()) (score 0))

    (define (combine-row row (score 0) (counter 3))

      (define (comb-iter row (new-row '()) (score 0))
            (cond ((null? (cdr row)) (list (reverse (cons (car row) new-row)) score))
                  ((zero? (cadr row)) (comb-iter (cons (car row) (cddr row)) (cons 0 new-row) score))
                  ((= (car row) (cadr row)) (comb-iter (cons (* 2 (car row)) (cddr row)) (cons 0 new-row) (+ score (car row))))
                  (else (comb-iter (cdr row) (cons (car row) new-row) score))))
  
      (if (zero? counter)
          (list row score)
          (combine-row (car (comb-iter row)) (+ score (cadr (comb-iter row))) (- counter 1))))

    (if (null? board)
        (list (reverse new-board) score)
        (combine-board (cdr board) (cons (car (combine-row (car board))) new-board) (+ score (cadr (combine-row (car board)))))))

  (define input (read))
  (define (transform board (dir input))

    (define (reverse board)

      (define (reverse-row row)
        (if (null? row) '() (append (reverse-row (cdr row)) (list (car row)))))

      (if (null? board) '() (cons (reverse-row (car board)) (reverse (cdr board)))))

    (define (rotate board (new-board '(() () () ())) (i 0)) ; takes flattened board

      (define (add-into-row item row board)
        (if (zero? row)
            (cons (cons item (car board)) (cdr board))
            (cons (car board) (add-into-row item (- row 1) (cdr board)))))
  
      (if (null? board)
          new-board
          (rotate (cdr board) (add-into-row (car board) i new-board) (if (= i 3) 0 (+ 1 i)))))
 
    (cond ((eq? dir 'w) (rotate (flatten (reverse board))))
          ((eq? dir 'a) (reverse board))
          ((eq? dir 's) (rotate (flatten board)))
          (else board)))

  
  (list (transform (car (combine-board (transform board)))) (cadr (combine-board (transform board)))))

(define (main board (score 0))
  (let ((n-board (new-num board)))
    (if n-board
        (begin (print n-board score) 
               (let ((p-board (player-move n-board)))
                 (if p-board
                     (main (car p-board) (+ score (cadr p-board)))
                     (game-over score))))
        (game-over board score))))

(main null-board)
