Using Explang with Lisp Syntax
==============================

Introduction into the language
------------------------------

## Data types

The language works mostly with standard Java Objects such like
Strings, Numbers, Arrays, etc. 

## Expressions

The language works with expressions that return values. There are no statements.
The expressions can be simple (Atoms) or complex (Lists) that consist of several 
subexpressions. Expressions are separated by whitespace. 

### Self evaluated expressions (literals)

- "foo" "a bar"  String literal
- 1, -2   Integer literals
- 1b, 0b  Byte literals
- 1s, 2s  Short literals
- 1L  0L  Long literals
- 0.5 0e2 Double literals
- 0.5f    Float literals
- NULL NIL null literals
- TRUE FALSE boolean literals
- ()   Empty list
- v"1.0.0-beta2" Version literal
- #\a  Character literal

The Literals are evaluated into correspondent Java objects.

### Variable expansion

Simple expressions that are not recognized as literals are recognized as Symbols and
in most cases are evaluated as variables.

In default configuration wvaluation of a variable, which does not
exists in current context, will cause an Execution Exception to be
thrown. This behaviour can be switched off [FIXME: link] so that
reference of unknown variables will return NIL.

 
### Effective Boolean values

In addition to java Boolean objects any object has effective boolean value:

NIL, the empty string, empty lists and zero numeric values of all numeric types has effective boolean value of FALSE.

Rest of objects have effective boolean value of TRUE.


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

 
