;;; Factorial (lazy sequence)

(defun fact(n)
  "Compute factorial"
  (apply #'* (range 1 (+ n 1))))

(println "5! = " (fact 5))

