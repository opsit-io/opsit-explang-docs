;;; Expression Reading and Evaluation

;; read source from string and evaluate
(let ((read-eval-test "(+ 1 2 3)"))
  (println "reading and evaluation test:")
  (println "before read-eval: " read-eval-test)
  (println "after read-eval:  " (eval (read-from-string read-eval-test)) "\n"))

;; evaluate code 
(let ((add-test '(+ 1 2 3)))
  (println "evaluation test:")
  (println "before eval: " add-test)
  (println "after eval:  " (eval add-test) "\n"))

;; evaluate a quine - input == output
(let ((quine  '((LAMBDA (X) (LIST X (LIST (QUOTE QUOTE) X))) (QUOTE (LAMBDA (X) (LIST X (LIST (QUOTE QUOTE) X)))))))
  (println "quine evaluation:")
  (println "before eval: " quine)
  (println "after eval:  " (eval quine) "\n"))
