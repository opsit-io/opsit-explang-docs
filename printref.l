
(setq *javadoc-url* (argv 1))

(defun format-funcall (funcname args)
  (str "(" funcname " "  args ")"))

(defun format-details (details)
  (if (in #\NEWLINE details)
      (str "\n```\n" details "\n```\n")
      (replace details "\n" "\n\n")))

(defun format-toc (items)
  (foreach (item items)
	   (print "[" item "](#"
		  (replace (lowercase (string item)) "." "")
		  ") "))
  (println))
	   
(defun format-location (loc)
  (let ((loc-match (re-matches (re-pattern "^(class) +(.*)$") loc)))
    (if loc-match
	(str "[" loc  "]" "(" *javadoc-url* "/" (replace (replace (get loc-match 2) "." "/") "$" ".") ".html)")
	(str "**" loc "**"))))

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


**%s %s** in package **%s** defined at  %s 
"
		     name
		     summary
		     (format-funcall name argDescr)
		     (format-details details)
		     (if builtIn "builtin" "compiled") codeType packageName (format-location defLocation))))))

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
	(format-toc packages)
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
	(format-toc letters)
	(foreach (letter (append (list) letters))
		 (print (str "\n## " letter "\n\n"))
		 (foreach (descr (filter
				  (lambda (descr)
				    (equal letter (get (get descr "name") 0)))
				  descrs))
			  (if (not (== (get descr "packageName") "user"))
			      (printfunc descr)))))))
