;;; Factorial (recursive)

(defun fact(n)
  "Compute factorial"
  (if n (* (fact (- n 1)) n)
      1))

(println "5! = " (fact 5))

