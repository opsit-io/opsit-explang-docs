
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

Read more in [Using Explang with Algebraic Syntax](explang-alg.md),
[Examples With Algebraic Syntax](explang-examples-alg.md).


Lisp Syntax
-----------

```lisp
(defun fact(n)
  "Compute factorial"
  (if n (* (fact (- n 1)) n)
      1))

(print (str "5! = " (fact 5) "\n"))

```


Read more in [Explang Core Quick Start](explang-core-quick-start.md),
[Using Explang with Lisp Syntax](explang-lisp.md),
[Examples With Lisp Syntax](explang-examples-lisp.md).



Further Information
-------------------

- [Using Explang from Java Code](explang-from-java.md)
- [Extending and Customizing the Language](explang-extending.md)
- [REPL Reference](REPL-reference.md).
- [Explang License](LICENSE.md)





