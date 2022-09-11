(defun format-funcall (funcname args)
  (str "(" funcname " "  args ")"))

(defun format-details (details)
  (replace details "\n" "\n\n"))

(defun printfunc(descr)
  (with-bindings descr
    (let ((matches (re-matches (re-matcher
				(re-pattern "(?s)^(.*?\\.)[ \\n\\t\\r]+(.*)$") docstring)))
	  (summary (if matches (str "**" (get matches 1) "**") ""))
	  (details (if matches (get matches 2) docstring)))
      (print (format "
### `%s`

%s

**%s**

%s


**%s %s** defined at  **%s** in package **%s**
"
		     name
		     summary
		     (format-funcall name argDescr)
		     (format-details details)
		     (if builtIn "builtin" "compiled") codeType defLocation packageName)))))

(let ((fnames  (functions-names))
      (descrs (map
	       (lambda (fn) (describe-function fn))
	       fnames)))
  (if (equal (argv 0) "by-package")
      (let ((packages (append (hashset)
			(map
			 (lambda (descr) (get descr "packageName"))
			 descrs))))
	(print "# Explang/lisp Built-in Functions by Package\n\n")
	(print (str "packages: " packages "\n"))
	(foreach (package (append (list) packages))
		 (if (not (== package "user"))
		     (progn 
		       (print (str "\n## " package "\n\n"))
		       (foreach (descr (filter
					(lambda (descr)
					  (equal package (get descr "packageName")))
					descrs))
				(printfunc descr))))))
      (let ((letters (append (hashset)
			     (map
			      (lambda (fname) (get fname 0))
			      fnames))))
	(print "# Explang/lisp Built-in Functions by Name\n\n")
	(print (str "letters: " letters "\n"))
	(foreach (letter (append (list) letters))
		 (print (str "\n## " letter "\n\n"))
		 (foreach (descr (filter
				  (lambda (descr)
				    (equal letter (get (get descr "name") 0)))
				  descrs))
			  (if (not (== (get descr "packageName") "user"))
			      (printfunc descr)))))))
