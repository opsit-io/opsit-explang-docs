;;; reading and evaluating explang code

;; read source from string and evaluate
(let ((read-eval-test "(+ 1 2 3)"))
  (print "reading and evaluation test: \n")
  (print (str "before read-eval: " read-eval-test "\n"))
  (print (str "after read-eval:  " (eval (read-from-string read-eval-test)) "\n\n")))

;; evaluate code 
(let ((add-test '(+ 1 2 3)))
  (print "evaluation test: \n")
  (print (str "before eval: " add-test "\n"))
  (print (str "after eval:  " (eval add-test) "\n\n")))

;; evaluate a quine - input == output
(let ((quine  '((LAMBDA (X) (LIST X (LIST (QUOTE QUOTE) X))) (QUOTE (LAMBDA (X) (LIST X (LIST (QUOTE QUOTE) X)))))))
  (print "quine evaluation: \n")
  (print (str "before eval: " quine "\n"))
  (print (str "after eval:  " (eval quine) "\n\n")))
