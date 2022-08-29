(PRINT "# Explang Built-in functions by package\n")


(defun format-funcall (funcname args)
  (str funcname " "  args))

(defun printfunc(descr)
  (print (format "
### %s

%s

%s


%s %s defined at  %s
"
		 (get descr "name")
		 (format-funcall (get descr "name") (get descr "argDescr"))
		 (get descr "docstring")
		 (if (get descr "builtIn") "builtin" "compiled") (get descr "codeType") (get  descr "defLocation"))))

(let ((fnames  (functions-names))
      (descrs (map
	       (lambda (fn) (describe-function fn))
	       fnames))
      (packages (append (hashset)
			(map
			 (lambda (descr) (get descr "packageName"))
			 descrs)))
      (letters (append (hashset)
		       (map
			 (lambda (fname) (get fname 0))
			 fnames))))
  (print (str "packages: " packages "\n"))
  (print (str "letters: " letters "\n"))
  (foreach (package (append (list) packages))
	   (print (str "\n## " package "\n\n"))
	   (foreach (descr (filter
			     (lambda (descr)
			       (equal package (get descr "packageName")))
			     descrs))
		    (printfunc descr))))

