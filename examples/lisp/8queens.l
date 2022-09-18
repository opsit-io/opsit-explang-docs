;;; The 8 Queens Problem

(setq N 8)
(setq solutions (list))

(defun print-solution (s)
  (foreach (i (range 0 N))
	   (foreach  (j  (range 0 N))
		     (print (if (== (get s i) j) #\U2655 "-")))
	   (println))
  (println))

(defun check-placement (a n c)
  "Check if placement (n c) is free from attacks from queens in board a."
  (foreach (i (range 0 n) true)    ;; loop returns true unless return called inside
	   (let ((pos (get a i)))
	     (if (or (= pos c)               ; same column?
		     (= (- pos i) (- c n))   ; same diagonal
		     (= (+ pos i) (+ c n)))  ; same diagonal		     
		 (return false)))))

(defun add-queen (a n)
  "Add to board a all queens from n up to N"
  (if (>= n N)
      (push! solutions (copy a)) ; all queens have been placed, 
      (foreach (c (range 0 N))   ; try to place next queen
	       (if (check-placement a n c)
		   (progn 
		     (put! a n c)
		     (add-queen a (+ n 1)))))))

;; position: list of integers that represent queen position in a row
(add-queen '() 0)

(println "Found " (length solutions) " solutions")
(println "First solution:")
(print-solution (first solutions))
