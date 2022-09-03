
function format_funcall(funcname,args)
   str(funcname, "(", args, ")");
end;


function format_details(details)
   replace(details, "\n", "\n\n");
end;


function printfunc(descr)
    matches := re_matches(re_matcher(r"(?s)^(.*?\.)[ \n\t\r]+(.*)$", descr.docstring));
    summary := if matches str("**", get(matches, 1), "**") else  "" end;
    details := if matches get(matches,2) else  descr.docstring end;
    funcType := if descr.builtIn "builtin" else "compiled" end;
    print(i"
### `$(descr.name)`

$(summary)

**$(format_funcall(descr.name, descr.argDescr))**

$(format_details(details))


**$(funcType) $(descr.codeType)** defined at  **$(descr.defLocation)**
"
          );
end;


fnames := functions_names();
descrs := map( f"describe_function", fnames); 

if argv(0) == "by-package"
    packages := append(hashset(),
                       map( descr -> descr.packageName, descrs));
    print("# Explang Built-in Functions by Package\n\n");
	print(str("packages: ", packages, "\n"));

    foreach([package, append(list(), packages)],
            begin
                print(str("\n## ", package, "\n\n"));
                foreach([descr,  filter(dsc -> package == dsc.packageName, descrs)],
                        printfunc(descr));
            end);
else
    letters := append(hashset(), map ( fname -> fname[0], fnames));
 	print("# Explang/Alg Built-in Functions by Name\n\n");
    print(str("letters: ", letters,  "\n"));

    foreach([letter,append(list(), letters)],
            begin
                print(str("\n## ", letter, "\n\n"));
                foreach([descr, filter(dsc -> letter == dsc.name[0], descrs)],
                        printfunc(descr));
            end);
end;            
        
# 				  (lambda (descr)
# 				    (equal package (get descr "packageName")))
# 				  descrs))
               # 			  (printfunc descr))))

               
# (let ((fnames  (functions-names))
#       (descrs (map
# 	       (lambda (fn) (describe-function fn))
# 	       fnames)))
#   (if (equal (argv 0) "by-package")
#       (let ((packages (append (hashset)
# 			(map
# 			 (lambda (descr) (get descr "packageName"))
# 			 descrs))))
# 	(print "# Explang Built-in Functions by Package\n\n")
# 	(print (str "packages: " packages "\n"))
# 	(foreach (package (append (list) packages))
# 		 (print (str "\n## " package "\n\n"))
# 		 (foreach (descr (filter
# 				  (lambda (descr)
# 				    (equal package (get descr "packageName")))
# 				  descrs))
# 			  (printfunc descr))))
#       (let ((letters (append (hashset)
# 			     (map
# 			      (lambda (fname) (get fname 0))
# 			      fnames))))
# 	(PRINT "# Explang Built-in Functions by Name\n\n")
# 	(print (str "letters: " letters "\n"))
# 	(foreach (letter (append (list) letters))
# 		 (print (str "\n## " letter "\n\n"))
# 		 (foreach (descr (filter
# 				  (lambda (descr)
# 				    (equal letter (get (get descr "name") 0)))
# 				  descrs))
# 			  (printfunc descr))))))
