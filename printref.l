(defun format-funcall (funcname args)
  (str funcname " "  args))

(defun printfunc(descr)
  (with-bindings descr
    (print (format "
### `%s`

**%s**

%s


**%s %s** defined at  **%s**
"
		 name
		 (format-funcall name argDescr)
		 docstring
		 (if builtIn "builtin" "compiled") codeType defLocation))))

(let ((fnames  (functions-names))
      (descrs (map
	       (lambda (fn) (describe-function fn))
	       fnames)))
  (if (equal (argv 0) "by-package")
      (let ((packages (append (hashset)
			(map
			 (lambda (descr) (get descr "packageName"))
			 descrs))))
	(PRINT "# Explang Built-in Functions by Package\n\n")
	(print (str "packages: " packages "\n"))
	(foreach (package (append (list) packages))
		 (print (str "\n## " package "\n\n"))
		 (foreach (descr (filter
				  (lambda (descr)
				    (equal package (get descr "packageName")))
				  descrs))
			  (printfunc descr))))
      (let ((letters (append (hashset)
			     (map
			      (lambda (fname) (get fname 0))
			      fnames))))
	(PRINT "# Explang Built-in Functions by Name\n\n")
	(print (str "letters: " letters "\n"))
	(foreach (letter (append (list) letters))
		 (print (str "\n## " letter "\n\n"))
		 (foreach (descr (filter
				  (lambda (descr)
				    (equal letter (get (get descr "name") 0)))
				  descrs))
			  (printfunc descr))))))
