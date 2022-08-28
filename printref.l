(PRINT "## EXPLANG built-in functions and forms reference\n\n")
(FOREACH (fn (FUNCTIONS-NAMES)) 	      
         (PRINT "\n### `" fn "`\n\n"
		(DESCRIBE-FUNCTION fn) "\n-----\n"))
