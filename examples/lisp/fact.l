(defun fact(n)
  "Compute factorial"
  (if n (* (fact (- n 1)) n)
      1))

(print (str "5! = " (fact 5) "\n"))

