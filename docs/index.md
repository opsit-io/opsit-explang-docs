
Welcome to Explang documentation
================================

*Explang* is a simple and customizable dynamically typed
language for the Java platform. 

The main use case for Explang currently is providing simple
customizable user-facing extension language for JVM based
software. Read more in [Explang Goals and Features](explang-goals-and-features.md)

Explang features pluggable syntax frontends (parsers).

Algebraic Syntax
----------------

```julia
function fact(n)
    "Compute factorial";
    if n  fact(n - 1) * n  else  1;  end;
end;
        
print(i"5! = $(fact(5))\n");

```

Read more in [Using Explang with Algebraic Syntax](explang-alg.md)


Lisp Syntax
-----------

```lisp
(defun fact(n)
  "Compute factorial"
  (if n (* (fact (- n 1)) n)
      1))

(print (str "5! = " (fact 5) "\n"))

```


Read more in [Using Explang with Lisp Syntax](explang-lisp.md)


BBBB
____

- [Calling Explang from Java](explang-from-java.md)
- [Extensing Explang in Java](explang-extending.md)
- [Explang License](LICENSE.md)





