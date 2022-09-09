Using Explang with Lisp Syntax
==============================

Tutorial
--------

### Expressions

Explang program is a sequence of one or more expressions which are evaluated
from the beginning to the end.

The language works with expressions that return values. There are no statements.

The simplest expressions are things like numbers, booleans or strings, which
evaluate to themselves.

```lisp
> 10

=> 10

> true

=> true

```

Several expressions enclosed between parentheses are also an expression,
they are called lists. When a list is evaluated its first item
is considered as function and the rest of items are passed as 
parameters. In most cases parameters are evaluated from left to right 
and then the operation uses their computed values as arguments. 
The return value of the operation is the value of the expression.

For example,
```lisp
> (+ 1 2 3)

=> 6
```

First the subexpressions +, 1, 2 and 3 were evaluated, returning the
plus function, 1, 2 and 3.  1, 2 and 3 were then passed to the plus
function, which returned 6.


Such expressions may be complex:
```lisp
> (+ (* 2 3) 1)

=> 7
```

### Comments

A semicolon ';' starts a comment. The comment continues until end of line.

```lisp
> "foo" ; a comment

=> "foo"
```


### Symbols and their Values

The expressions `+` and `*` here are Symbols. 
Symbols don’t evaluate to themselves but return values they have been assigned.
If we give `b` the value 10, it will return 10 when evaluated:


```lisp
> (setv b 10)

=> 10
> b

=> 10
```

If we try to evaluate a Symbol that has not been assigned a value we'll get error[^1].

Note that evaluation `(setv b 10)` when `b` still was unassigned did
not cause an error.  This is because there are some operations (they
are called special operators or special formd) that violate the usual
evaluation rule, and `setv` is one of them.  Its first argument isn’t
evaluated.


### Quoting

You can turn off evaluation by using the `quote` special form:

```lisp
> (quote b)

=> b
```

This can be abbreviated by putting a single quote character before an expression: 

```lisp
> 'b

=> b
```

When you quote a list, you get back the list itself.

```lisp
> (+ 1 2)

=> 3

> '(+ 1 2)

=> [+, 1, 2]
```

The first expression returns the number 3. The second, because it was
quoted, returns a list consisting of the symbol + and the numbers 1
and 2.


### The `list` function

To create a list  use the `list` function:

```lisp
> (list 1 (+ 2 3) "foo" 'b)

=> [1, 5, foo, b]
```


### Defining Functions


We’ve already seen some functions: `+`, `*`, `list`. You can define
new ones with `defun`, which takes a symbol to use as the name, a list
of symbols that describe the parameters, and then zero or more
expressions called the body. When the function is called, those
expressions will be evaluated in order with the parameter symbols in
the body temporarily set (“bound”) to the corresponding argument
values. Whatever the last expression returns will be returned as the
value of the call.  Here’s a function that takes two numbers and
returns their average:

```lisp
> (defun average (x y)
	(/ (+ x y) 2))

=> io.opsit.explang.Compiler$LAMBDA$1@5e9f23b4

```

The body of the function consists of one expression, `(/ (+ x y) 2)`
It’s common for functions to consist of one expression; in purely
functional code (code with no side-effects) they always do.

Notice that `defun`, like `setv`, doesn’t evaluate all its arguments.
It is another of those special forms with its own evaluation rule.

What’s the object returned as the value of the def expression?  That’s
the Java Object that represents the function.


Now the symbol `average` is assigned function value and you can invoke
it in the same way you invoke the built-in functions like `+` or `*`:

```lisp
> (average 100 200)

=> 150
```

As the literal representation of a string is a series of characters
surrounded by double quotes, the literal representation of a function
is a list consisting of the symbol `lambda`, followed by its
parameters, followed by its body. So you could represent a function to
return the average of two numbers as:

```lisp
> (lambda (x y) (/ (+ x y) 2))

=> io.opsit.explang.Compiler$LAMBDA$1@37a71e93
```

And can use a literal function wherever you could use a symbol whose value is one, e.g.

```lisp
> ((lambda (x y) (/ (+ x y) 2)) 100 200)

=> 150
```

### Function Values


Notice that if you try to get the function object simply by referencing the `average` symbol you get an error.

```lisp
> average
EXECUTION ERROR: java.lang.RuntimeException: variable 'average' does not exist in this context at:
```

This is because of imprtant property of Explang: named functions and ordinary data variables are 
living in separate namespaces, that is you may assign value to variable `average` without 
overwriting the function `average`:

```lisp
> (setv average 100)

=> 100
> (average average 200)

=> 150
```

To reference the value of the defined function one must use the `function` special operator
(which can be abbreviated as `#'`:

```lisp
> (function average)

=> io.opsit.explang.Compiler$LAMBDA$1@5e9f23b4
```

And to set the function binding one can use the `fset` function, all the def does is 
basically:

```lisp
(fset 'average (lambda (x y) (/ (+ x y) 2)))
```

### Printing values


So far we’ve only had things printed out implicity as a result of
evaluating them. The standard way to print things out in the middle of
evaluation is with `print` or `println`. They take multiple arguments and print
them in order; `println` also prints a newline at the end. Here’s a variant
of average that tells us what its arguments were:

```lisp
> (defun average (x y)
       (println "my arguments were: " (list x y) "\n")
       (/ (+ x y) 2))
> (average 100 200)
my arguments were: [100 200]

=> 150
```


### Conditionals

#### `If` Operator

The standard conditional operator is `if`. Like `setv` and `defun`, it
doesn’t evaluate all its arguments. When given three arguments, it
evaluates the first, and if that returns true, it returns the value of
the second, otherwise the value of the third:

```lisp
> (if (> 2 1) 'a 'b)

=> a
> (if (> 1 2) 'a 'b)

=> b
```

The second argument (then) to `if` is a single expression. so if you
want to do there multiple things, combine them into one expression with `progn`:

```lisp
(setv x 70)
(if (>= x 0)
    (progn 
      (println "can compute square root")
      (sqrt x))
  (println "nope"))
can compute square root

=> 8.366600265340756
```

If you  want several expressions to be evaluated when the condition is false, you 
can add them as additional arguments:

```lisp
> (setv x 70)

=> 70

> (if (< x 0)
      (println "nope")
    (println "can compute square root")
    (sqrt x))

can compute square root

=> 8.366600265340756
```

In fact the third `if` argument is optional, if it not provided and the condition does not hold
`if` will return null.

```lisp
(setv x -2)
(if (>= x 0) (sqrt x))

=> NIL
```

#### Truth values

The `if` operator checks the truth value of the first argument. The comparison functions
like `<` or `>=`  return Java Boolean objects `true` or `false`:

```lisp
> (< 1 0)

=> false
```

but in Explang all expressions have implicit truth values and thus can
be used in conditional expressions.

Generally, False, NIL, zero numbers, empty lists, sets, strings  and other sequences 
have implicit `False` truth value. Other object thruth value of `true`. 

For example 

```lisp
> (if 0 'yes 'no)

=> no
```

To check truthyness of an expression one can use built-in function `bool`
that returns thruthiness value of an expression. 

```lisp
> (bool "")

=> false
```

#### `COND` Operator

The `cond` conditional operator is used to choose between arbitrary number of alternatives 

Syntax for cond is

```
(cond   ((test1    action1 ...)
   (test2    action2 ... )
   ...
   (testn   actionn ...)))
```

Each clause within the cond statement consists of a conditional test and an list of actions to be performed.

If the first test following cond, test1, is evaluated to be true, then the related actions are executed, 
and value of the its value is returned and the rest of the clauses are skipped over.

If test1 evaluates to be nil, then control moves to the second clause without executing action1, and the same process is followed.

If none of the test conditions are evaluated to be true, then the cond statement returns nil.

```list
(setv x 2)
(cond ((< x 0)
	(println x " < 0") NIL)
       (true
	(println x " >= 0") (sqrt x)))
2 >= 0

=> 1.4142135623730951
```

#### The Logical operators

The logical negation fnction is called `not`, it returns Boolean value, which is inverse of the
the truth value of its argument:

```lisp
> (not true)

=> false
> (not false)

=> true
> (NOT "foo")

=> false
```

Logical operators `and` and `or`:

```
(or true false)

=> true
```

They operate like conditionals because they don’t evaluate more arguments than they have to and 
return the last value that was computed


```lisp
> (and true 0  (println "you'll never see this"))

=> 0

> (or false 0 "foo"  (println "you'll never see this too"))

=> foo
```

#### Equality Check Operators


##### `=='

The `==` operator compares two objects in sort of 
"Do What I Mean" fashion: it returns true if two objects are 
equal structurally or numerically:

```lisp
> (== nil nil)

=> true

> (== 5 5)

=> true
```

Numerically equal Integer and Long numbers:
```lisp
> (== 5 5L)

=> true
```

Numerically equal Integer and Double numbers:

```lisp

> (== 5 5.0)

=> true
```

Same inside lists:

```lisp

> (== '(1.0 2) '(1 2L))

=> true
```

Numerically unequal Integer and Long numbers:
```lisp
(== 5 5.1)

=> false
```

##### `equal`

The `equal` operator checks two objects for equality by applying the
equals() java method of the first argument on the scond one.  It will
return true also if both the arguments are NILs.

Comparing using java Object's equals method: java.util.List.equals(),
which checks that both objects are lists of equal length with equal
elements at the same indexes.

```lisp
> (equal (list 1 2 3) (list 1 2 3)) 

=> true

> (equal null null)

=> true

> (equal 555 555)

=> true
```

Different numeric types (Integer and Long)
```
> (equal 555 555L)

=> false

```

##### `===`

The most strict of the equality checks is the objects identity check
`===`: it returns true if Object x is same as Object y or if both
values are NIL.  Internally it uses the java operator `==` to check
objects identity.

```
(=== (list 1 2 3) (list 1 2 3))  ;; check that two variables contain the same object, they are not: 

=> false

```

Note that the `===` operator inherits some quirks from the underlying java operator:

```lisp
> (=== 5 5)

=> true
> (=== 5555 5555)

=> false
```


#### `=`

The '=' operator checks the arguments for numeric equality taking in account their implicit numeric values.
Unlike other equality operators it takes any number of arguments. It returns true if all of them are equal.

```lisp
> (= 1 1.0)

=> true

> (= 1 1.0 1L 1b 1.0f)

=> true
```

Implicit numeric values:

```lisp
> (= nil 0L)

=> true

> (= 1 (list 1))

=> true

> (= 0 '() "")

=> true

> (= 33 "33.0" "33" "33.0f" #\!) ;; ASCII code of ! is 33

=> true
```


#### in - test if a sequence contains a value.

If you want to test whether something is one of several alternatives, you could say 
`(or (== x y) (== x z) ...)`, but this situation is common enough that there’s an operator for it.

```lisp 
> (in 3 '(list 1 2 3 "foo" null))

=> true

(in null '(list 1 2 3 "foo" null))

=> true

(in 5 '(list 1 2 3 "foo" null))

=> false

> (in #\o in "hello!") 

=> true

```

###  Iteration Operators


To iterate through the elements of a list or string, use `foreach`.

```lisp
> (foreach (c "Hello!" x)
    (println c))
H
e
l
l
o
!

=> END
```

The NIL you see at the end is not printed out by the code in the loop.
They’re the return values of the iteration expressions. One can give 
one additional argument that will be computed after end of the iteration
and used as return value.


```lisp
> (foreach (c (list 2 3 4) x) 
    (println c)
    (setv x (+ x c)))

=> 9
```





## Case Sensitivity



## Difference between the `lisp` and `sexp` parsers.


Data Types and Values
---------------------

Explang is a dynamically typed language.  There are no type
definitions in the language: each value carries its own type.

The language can work with Java Objects of any type and it has
built-in support for standard data types such as Strings, Numbers,
Arrays, etc. 

### NIL or NULL

NIL represents absense of a useful value, it is implemented as Java `null`. 

### Booleans and Boolean values.

The boolean type has two values, `FALSE` and `TRUE`, which are represented by Java Boolean objects. 

In Explang in conditional or logical  expressions any object has an implicit boolean value:
NIL, empty list (), empty string, and 0 numeric values are considered FALSE, other objects are considered as TRUE.

### Numbers

Explang works with Java numeric types:

- 1b, 0b  -- Byte 
- 1s, 2s  -- Short
- 1, -2   -- Integer 


- "foo" "a bar"  String literal

- 1b, 0b  Byte literals

- 1L  0L  Long literals
- 0.5 0e2 Double literals
- 0.5f    Float literals
- NULL NIL null literals
- TRUE FALSE boolean literals
- ()   Empty list
- v"1.0.0-beta2" Version literal
- \#\a  Character literal [^*]

### Strings

The Literals are evaluated into correspondent Java objects.

### Characters

### Bytes

### Version






### Variable expansion

Simple expressions that are not recognized as literals are recognized as Symbols and
in most cases are evaluated as variables.

In the default configuration evaluation of a variable, which does not
exists in current context, will cause an Execution Exception to be
thrown[^1]. 

[^1]: This behaviour can be switched off [FIXME: link] so that reference of unknown variables will return NIL.

 
### Effective Boolean values

In addition to java Boolean objects any object has effective boolean value:


### Complex expressions

Complex expressions are introduced using the list based syntax:

```lisp
( form_name  expr .... )

```

The first expression inside the parentheses is used as name of operation and rest of expressions serve as parameters.

For example *+* is the addition function:

```

[0]> (+ 1 3 4)

8

```

The expressions are evaluated and return a single Java Object or NIL as evaluation result.

Complex expressions can be divided into two classes:

####  Function calls

Functions are evaluated in the following way: first all function parameters are evaluated from left to right,

the results of evaluation are substituted in stead of the parameters, then the function is evaluated using the 

computed parameters. Functions can be built-in or user defined. Functions can be built-in (that is written 

in java as part of EXPLANG), user functions written in EXPLANG (introduced using the LAMBDA and DEFUN forms)

as well as user-provided and written in Java (using extension mechanism).

 

#### Special forms calls 


With special forms order of argument evaluation and the way they are evaluated is part of logic of the special form.

For example in the IF special form

```

(IF a b c)

```

 first of all a will be evaluated, then according to the effective boolean value of *a* will be evaluated only one of 

 the expressions: *b* if *a* is *TRUE* and *c* if a is *FALSE*.

#### 

## List of built-in special forms:

### (DEFUN function-name (parameter-list) expressions-list)

Define a named user-defined explang function. In the following example

```
(DEFUN fact (x) 
    "Compute Factorial"
    (IF x 
        (* x (fact (- x 1))) 
        1))
(fact 5) 

=> 120

```
a named function with name *fact* is defined and then it is used to
compute factorial of 5.

### Parameter List

### Expressions List


###  `LET'

 

(LET ((var1 value1) ...) expressions-list)

 

Bind values to variables 

 

```

(LET ((a 1) 

      (b (+ a 2)))

     (+ a b))

--> 4

```




### 'DLET' - destructuring LET

(DLET (variables-list) (values-list) (expressions list))

 

Will bind values in the values-list to variables in the variables-list and

execute expressions with given bindings.

 

```

(DLET (a b c d) (LIST 1 2 3 4) 

      (LIST d c b a))

--> (4 3 2 1)

```

 

### `FUNCTION'

 

(FUNCTION function_name)

 

Return function with given name. The parameter will not be expanded as variable. 

 

```

(FUNCTION LIST)

---> org.dudinea.explang.Funcs$LIST@7daf6ecc

```

 

### `IF`

 

(IF a b c)

 

Conditional expression. If *a* evaluates as true it Will evaluate b and return its value, otherwise c will be evaluated.

 

### `LAMBDA`

 

(LAMBDA (parameter-list) expression list) 

 

Returns anonymous function that accepts given parameters.

 

 

The variable bindings are dynamic, that is they depend on the chain of nested execution contexts, context 

become inaccessible and get garbage collected when execution exists from the context.

 

```

(LET ((a 1))

    (DEFUN get-a () a)

    (get-a))

--> 1

 

(LET ((a 2))

    (get -a))

--> 2

 

```

 

### `PROGN`

 

Introduce block: evaluate arguments in their order (left to right). Return the value of the last parameter.

 

```

(PROGN 1 

    (+ 1 2) 

    123)

```

 

### `QUOTE`

 

(QUOTE expression)

 

Return expression without evaluation of forms:

 

```

(QUOTE (FOO "bar" 1.0 (1)))

---> (FOO "BAR" 1.0 (1))

```

 

### `WITH-BINDINGS` 

 

Convert Java map into variable bindings

 

```

(WITH-BINDINGS 

    (HASHMAP "a" 1 "b" 2) 

    (LIST a b))

--> (1 2)

```

 
