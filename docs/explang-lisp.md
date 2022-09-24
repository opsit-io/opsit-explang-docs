Tutorial on Using Explang with Lisp Syntax
==========================================

Expressions
-----------

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

> "foo bar"

=> foo bar
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

Comments
--------

A semicolon ';' starts a comment. The comment continues until end of line.

```lisp
> "foo" ; a comment

=> "foo"
```


Symbols and their Values
------------------------

The expressions `+` and `*` here are Symbols. 
Symbols don't evaluate to themselves but return values they have been assigned.
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
evaluation rule, and `setv` is one of them.  Its first argument isn't
evaluated.


Quoting
-------

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


The `list` function
-------------------

To create a list  use the `list` function:

```lisp
> (list 1 (+ 2 3) "foo" 'b)

=> [1, 5, foo, b]
```

Defining Functions
------------------

We've already seen some functions: `+`, `*`, `list`. You can define
new ones with `defun`, which takes a symbol to use as the name, a list
of symbols that describe the parameters, and then zero or more
expressions called the body. When the function is called, those
expressions will be evaluated in order with the parameter symbols in
the body temporarily set ('bound') to the corresponding argument
values. Whatever the last expression returns will be returned as the
value of the call.  Here's a function that takes two numbers and
returns their average:

```lisp
> (defun average (x y)
	(/ (+ x y) 2))

=> io.opsit.explang.Compiler$LAMBDA$1@5e9f23b4

```

The body of the function consists of one expression, `(/ (+ x y) 2)`
It is common for functions to consist of one expression; in purely
functional code (code with no side-effects) they always do.

Notice that `defun`, like `setv`, doesn't evaluate all its arguments.
It is another of those special forms with its own evaluation rule.

What is the object returned as the value of the def expression?  That's
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

Function Values
---------------

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

Getting Help on Functions
-------------------------

To get short description of a function or a special operator
use `describe-function`. 


```lisp
> (describe-function 'random)

=> random is a built-in function defined at class io.opsit.explang.Funcs$RANDOM

Arguments:  limit

Documentation: 
    Produce Pseudo-Random Number. Returns a pseudo-random number that is a non-negative number less than limit and of the same numeric type as limit. Implemented uding Java Math.random()
Package: base.math
```

`describe-function` works both with built-in as well with the
user-defined functions.  For the latter ones the function description
is the value of so called documentation strings - "docstrings".  if
the first expression in the function is a string literal it is
considered to be documentation string:

```lisp
> (defun average (x y)
    "Compute average of two numbers."
	(/ (+ x y) 2))
    
=> io.opsit.explang.Compiler$LAMBDA$1@37a71e93

> (describe-function 'average)

=> average is a compiled function defined at INPUT1:line=3:pos=15:o=74:len=0

Arguments:  x y

Documentation: 
    Compute average of two numbers.
Package: user
```

To get list of all the available function use `functions-names`:

```lisp
> (functions-names )

=> [%, *, +, -, ->, ->>, ., .N, .S, /, <, <=, =, ==, ===, >, >=, @->, AND, APPEND 
...

```

Printing values
---------------

So far we've only had things printed out implicity as a result of
evaluating them. The standard way to print things out in the middle of
evaluation is with `print` or `println`. They take multiple arguments and print
them in order; `println` also prints a newline at the end. Here's a variant
of average that tells us what its arguments were:

```lisp
> (defun average (x y)
       (println "my arguments were: " (list x y) "\n")
       (/ (+ x y) 2))
> (average 100 200)
my arguments were: [100 200]

=> 150
```

Return Value of the Function
----------------------------

From the previous example we see that when a function contains several
expressions the return value of the function is the value of the last
expression in the function. Previous expressions are evaluated 
and they value is discarded. 

If you want to return value from function without reaching the last
expression use the `return` operator.

In the following example we define function that solves quadratic
equations. In the case when determinant is negative we print an error
message and exit prematurely returning an empty list.


```lisp
> (defun quadratic-eq-roots(a b c) 
    "Finds real roots of an quadratic equation"
    (setv discriminant (- (* b b) (* 4 a c)))
    (when (< discriminant 0) 
        (println "Error: the equation has no real solutions!")
        (return ())) 
    (list (/ (- (- b) (sqrt discriminant)) (* 2 a))
          (/ (+ (- b) (sqrt discriminant)) (* 2 a))))


> (quadratic-eq-roots 2 4 -4)

=> [-2.732050807568877, 0.7320508075688772]

> (quadratic-eq-roots 1 2 3)

Error: the equation has no real solutions!
=> []

```

Data Types and Values
---------------------

Explang is a dynamically typed language.  There are no type
definitions in the language: each value carries its own type and 
those types are Java types.

The language can work with Java Objects of any type and it has
built-in support for standard data types such as Strings, Numbers,
Arrays, etc. 



To get type of a value we use function `type-of`:

```lisp
> (type-of "foo")

=> class java.lang.String

> (type-of 1.0)

=> class java.lang.Double
```

To check if object is of some type use the `typep` operator:

```lisp
> (typep "abc" 'java.lang.String)

=> true
```

Base Java type from the [java.lang](https://docs.oracle.com/javase/8/docs/api/java/lang/package-frame.html)
can be specified without package:

```lisp
> (typep "abc" 'String)

=> true
```

The check returns true for the specific class as well as for class parents and the interfaces that it implements:

```lisp
> (typep "abc" 'CharSequence)  ;; String implements CharSequence

=> true
```

The second arguments can be a string as well as symbol:

```lisp
> (typep "abc" "Object")  ;; String implements CharSequence

=> true
```

The type of NIL is NIL.

```lisp
> (typep NIL NIL)

=> NIL
```

NIL values
----------

NIL represents absense of a useful value, it is implemented as Java `null`. 
It is not really a data type.

```
(type-of NIL)

=> NIL

```

Booleans 
--------

The boolean type has two values, `false` and `true`. It is implemented using
as Java Boolean objects. 


### Numeric Types And Values

Explang works with Java numeric types. 

Here table of types with examples of literals,

- 1b, 0b  -- Byte 
- 1s, 2s  -- Short (16 bit signed integer)
- 1, -2   -- Integer (32 bit signed integer)
- 1L  0L  -- Long literals (64 bit signed integer)
- 0.5f 1.2e-2f   -- Float literals (32 bit floating point)
- 0.5 1.2e-2 -- Double literals (64 bit floating point)

```lisp
> (type-of 1)

=> class java.lang.Integer

> (type-of 1b)

=> class java.lang.Byte

> 0.1e4

=> 1000.0

```

Numeric Types Promotions
------------------------

When one performs arithmetic operations between different numeric types Explang 
performs automatic promotion of numeric types, i.e. the result of the operation 
will be of the type of the argument with highest precision. Operations between 
integer types and floating types are promoted to floating point types:

```lisp
> (type-of (+ 1b 1s))

=> class java.lang.Short

> (type-of (+ 1b 1s 1 1L 1.0))

=> class java.lang.Double
```

Note that Explang does not perform promotion for overflows between operations:

```lisp
> (* 100s 1000s)   ; 100000 won't fit into 16 bit Short Integer,
                   ; we'll get wrong result

=> -31072
```

Converting to Numeric Types
---------------------------

The operators `byte`, `double`, `float`, `int`, `long`, `short` convert to corresponding
numeric types from other numeric types as well as from string representation:

```lisp
> (double 1L)

=> 1.0

> (double "1E4")

=> 10000.0

```

Strings
-------

Explang strings are Java Strings. Strings are constant, that is one cannot
change an existing string but have to create new one.

In code we can delimit literal strings by matching double quotes `"`:

```lisp
> " a line"

=> a line
```

String literals  can have embedded newlines, tabs and any other characters except `"`: 

```lisp
> "line1
line2
line3"

=> line1
line2
line3
```
To include a `"` one need to escape it using the  `\` escape character:

```lisp
> "quoted word \"foo\""

=> quoted word "foo"
```

There are other escape characters supported:

- \b - backspace 0x08
- \t - tab 0x09
- \n - newline 0x0a
- \f - form feed 0x0c
- \r - carriage return 0x0d

Other characters when escaped will be inserted as they are:

```lisp
> "\\t means tab '\t'\n"

=> \t means tab '	'
```

To convert any object into its string representation use 
the `string` operator:

```lisp
> (string (+ 1 2))

=> 3

(string nil)

=> NIL
```

There are a couple of operators for building strings. The most general is
string, which takes any number of arguments and mushes them into a
string.

The most general is `str`, which takes any number of arguments and 
concatenates them into a string. Every argument will appear as it would 
look if printed out by pr, except nil, which is ignored.

```
> (str 99 " bottles of " 'bee #\r)

=> "99 bottles of beer"

```

To control exactly the way the objects are converted to string use
the `format` function, which converts its argument to string
using the first argument as format specification: 

```lisp
(setv x 9786)
(format "Decimal: %d, hexadecimal: %x  octal: %o  char: %c \n" x x x x)

=> Decimal: 9786, hexadecimal: 263a  octal: 23072  char: ☺

```
See [java.util.Formatter](https://docs.oracle.com/javase/8/docs/api/java/util/Formatter.html),
for details on building the format strings.

Explang considers Strings as Sequences of Character, see below on both.


Character Type
--------------

Explang Characters represent Unicode 16bit characters and implemented using Java 
[java.lang.Character](https://docs.oracle.com/javase/8/docs/api/java/lang/Character.html).

Character literals are delimited using the #\C, #\UHEX or #\ESCAPE notation:

```lisp
> '(#\H #\e #\l #\l #\o #\NEWLINE #\u263a )

=> [H, e, l, l, o, 
, ☺]
```


The `char` operator allows to create Characters from their numeric code:

```lisp
> char(33)

=> !
```

Characters can be used as operand of arithmetic expressions:

```lisp
(char (+ 1 #\A))

=> B
```

Collection and Sequence types
-----------------------------

Explang attempts to provide operators that can be used 
on sequence and collection like objects of different types: 
lists, arrays, sets, hash maps and so on.

### Lists

Lists contains entries (objects or null) in slots that can be
addressed by their zero-based index. Lists do not have fixed size,
they grow/shring dynamically when elements are added/removed.

The `list` operator creates and initializes a list. The lists created are implemented by 
[java.util.ArrayList](https://docs.oracle.com/javase/8/docs/api/java/lang/Character.html).


```lisp
> (list 1 2 (list 3 4))

[1, 2, [3, 4]]
```

### Maps

Use the `hashmap` to create and initialize a Map 
(implemented by [java.util.HashMap](https://docs.oracle.com/javase/8/docs/api/java/util/HashMap.html)).


```lisp
 > (hashmap "a" 1 "b" "foo" "c" (hashmap "d" "e"))
 
 => {a=1, b=foo, c={d=e}}
```

### Sets

A Set is a collection that contains no duplicate elements. More
formally, sets contain no pair of elements e1 and e2 such that `(equal
e1 e2) return true. As implied by its name, this type models the
mathematical set abstraction.

The `hashset` operator creates a set and initializes it with the specified elements.

```lisp
(hashset 1 2 3 7)

=> [1, 2, 3, 7]
```

```lisp
(hashset 1 1 (list 1 2 3) (list 1 2 3) NIL NIL)

=> [null, 1, [1, 2, 3]]
```

### Arrays

Arrays are areas of memory that contain entries in slots that can be
addressed by their zero-based index.  Arrays have fixed size that
determined at their creation time. Unlike lists arrays are created 
to contain objects or primitive values of given type.

The `make-array` operator creates array and initializes it with 
specified elements. 

By defaults `make-array` creates array of type Object that can contain any java object.

```
> (make-array 1 "123" (list 1 2) NIL) ;; array with specified objects

=> [1, 123, [1, 2], null]

> (make-array :size 5) ;; array of specified size 

=> [null, null, null, null, null]

> (make-array :size 5 :element-type "double") ;; array for storing primitive double values

=> [0.0, 0.0, 0.0, 0.0, 0.0]


> (make-array :size 10      ; array of size 10 
    :element-type "char"    ; for storing primitive character values
    #\H #\E #\L #\L  #\O)   ; partially filled

=> [0.0, 0.0, 0.0, 0.0, 0.0]

=> [H, E, L, L, O,  ,  ,  ,  ,  ]

```

### Character Sequences

Regular string objects that we've seen earlier is one of the types that 
are called Character Sequences. In Java these objects 
implement interface
[java.lang.CharSequence](https://docs.oracle.com/javase/8/docs/api/java/lang/CharSequence.html)).

There are other such types that, unlike strings, can be modified in place:

The `string-buffer` function creates a 
[StringBuffer](https://docs.oracle.com/javase/8/docs/api/java/lang/StringBuffer.html) object:
```lisp
> (string-buffer) ;; creates empty StringBuffer

=> 

> (string-buffer "foo" "bar")  ;; create stringbuffer with text

=> "foobar"
```

The `string-buffer` function creates a StringBuffer object:
```lisp
> (string-buffer) ;; creates empty StringBuffer

=> 

> (string-buffer "foo" "bar")  ;; create stringbuffer with text

=> "foobar"
```

The `string-builder` function creates a 
[StringBuilder](https://docs.oracle.com/javase/8/docs/api/java/lang/StringBuilder.html) object.
StringBuilder is similar to StringBuffer, but unlike StringBuffer it can be safely 
modified from differennt threads.

```lisp
> (string-builder) ;; creates empty StringBuilder

=> 

> (string-builder "foo" "bar")  ;; create stringbuilder with text

=> "foobar"
```

The `string-builder` function creates a StringBuilder object:
```lisp
> (string-builder) ;; creates empty StringBuilder

=> 

> (string-builder "foo" "bar")  ;; create StringBuilder with text

=> "foobar"
```

In the following chapters we'll learn to operate on data in sequence types.


Getting Inforrmation About Collections and Sequences
----------------------------------------------------


Length returns number of objects in a collection or sequence:

```lisp
> (list (length "Hello") 
        (length (hashmap "a" 1))  
        (length (hashset 1 2 3)) 
        (length (range 1 10)))

=> [5, 1, 3, 10]
```

The collection predicates return `true` or `false` allow to check if an objects have some 
property or ability. By convention their name ends by _p_ - predicate.


`collp` returns true if the object is a collection of some kind, for example:

```lisp
> (list  (collp ())
         (collp (make-array))
         (collp "foo")        ; string is a CharSequence
         (collp (range 1 2))
         (collp nil) ;; non-object 
         (collp 1))  ;; individual object

=> [true, true, true, true, false, false]
```

`seqp` returns true if the object is a sequence, that is collection with specific order.

`indexedp` returns true if objects in the collection can be addressed by integer index.

`mapp` returns true if objects in the collection can be addressed by key objects.

`mapp` returns true if the object is a Set.

`associativep` returns true if objects in collection are indexed or have keys.


Accessing data in collections and sequences
-------------------------------------------

Explang attempts to provide data access operators that can be used on
all kinds of sequences and collections like lists, arrays, sets, hash
maps and so on.

### `get` - value accessor

The `get` function returns a Sequence element by its index
or a Map entry by its key:

```lisp
> (setv lst (list "foo" 'bar 1 null))

=> [foo, bar, 1, null]

> (setv m (hashmap "a" 1 "b" "2"))

=> {a=1, b=2}

> (get lst 0)

=> fooo

> (get lst 1)

=> bar

> (get m "a")

=> 1

```

When provided an invalid index `get` returns NIL:

```lisp
> (get lst 10)

=> NIL
```

`get` accepts an optional third argument -- default value. 
If index is invalid or key is missing it will return the value of the
third argument:

> (get lst 10 "No such index")

=> No such index


### `get-in` access values in nested structures


When the structure is complex like in the following example using get may become cumbersome and require
use of several nesting expressions.

```lisp
> (setv data
      (hashmap 'people (hashmap 1 (hashmap 'name "John"
                                           'surname "Doe" 
                                           'relatives (hashmap 'motherId 3
                                                               'fatherId 2)
				           'friendIds (list 4))
                                2 (hashmap 'name "Jack"
                                           'surname "Doe")
                                3 (hashmap 'name "Ann"
                                           'surname "Roe")
				4 (hashmap 'name "Bill"
					   'surname "Moe"))))

=> {people={1={friendIds=[4], surname=Doe, name=John, 
relatives={motherId=3, fatherId=2}}, 2={surname=Doe, name=Jack}, 
3={surname=Roe, name=Ann}, 4={surname=Moe, name=Bill}}}
```

`get-in' accepts list of keys to specify path to the needed value:


```lisp
> (get-in data '(people 1 relatives motherId))

=> 3
```

When there is no mapping get-in returns provided default value or NIL when no default specified:

```lisp
> (get-in data '(people 2 relatives motherId))

=> NIL

> (get-in data '(people 2 relatives motherId) "N/A")

=> N/A
```

`get-in' works not only with Maps but with lists and other sequences:

```lisp
> (get-in data '(people 1 friendIds 0))

=> 4

> (get-in data '(people 1 name 0))

=> J
```

### `select-keys` select entries by their keys/indices

Returns map of  entries selected  by their keys/indices

```lisp
> (select-keys (hashmap "a" 1 "b" 2 "c" 3) (list "a" "b"))

=> {a=1, b=2}

> (select-keys (list "a" "b" "c") (list 0 2))

=> {2=c, 0=a}

```

The returned Map is actually kind of view into the original object, 
that is it refkects changes in the original:

```lisp
> (setv m (hashmap "a" 1 "b" 2))

=> {a=1, b=2}

> (setv s (select-keys m (list "a" "c")))

=> {a=1}

> (assoc! m "c" "3")

=> {a=1, b=2, c=3}

> s

=> {a=1, c=3} ;; now s got new entry c=3
```

### `first` return first object in collection


```lisp
> (first (range 2 10))

=> 2
```





Conditionals
------------

### `If` Operator

The standard conditional operator is `if`. Like `setv` and `defun`, it
does not evaluate all its arguments. When given three arguments, it
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

### The `when` operator

`when` is just a simpler form than `if`: it has only the 'then' part of it. 
This part may contain several expressions. In the case when condition is false
the return value of when is `NIL`:

```lisp
(when (>= x 0)
    (println x " is positive")
    (println "square root of x is " (sqrt x)))

```


### Truth values

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

### `cond` Operator

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
> (setv x 2)

=> 2
> (cond ((< x 0)
	   (println x " is negative") NIL)
      ((= x 0)
	   (println x " is zero") x)
      ((> x 0)
 	   (println x " is positive") x)
      (true (println "This won't happen")))

2 is positive

=> 2
```


The Logical operators
---------------------

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

They operate like conditionals because they don't evaluate more arguments than they have to and 
return the last value that was computed


```lisp
> (and true 0  (println "you'll never see this"))

=> 0

> (or false 0 "foo"  (println "you'll never see this too"))

=> foo
```

Equality Check and Comparison Operators
---------------------------------------


### `=='

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

### `equal`

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

### `===`

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


### `=` Numeric equality operator

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

### Comparison operators `<`, `<=`, `>=`, `>`


These operators take any number of arguments and check that all of their arguments are in specified order.

```lisp
> (< 0 1)

=> true

> (< -1 0 1 2 3)

=> true

> (< 0 1 2 1.5)

=> false
```


### in - test if a sequence contains a value.

If you want to test whether something is one of several alternatives, you could say 
`(or (== x y) (== x z) ...)`, but this situation is common enough that there's an operator for it.

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

Iteration Operators
-------------------

To iterate through the elements of a list or string, use `foreach`.

```lisp
> (foreach (c (list 1 2 3))
    (println c))
1
2
3

=> NIL
```

The NIL you see at the end is not printed out by the code in the loop.
They're the return values of the iteration expressions. One can give 
one additional argument that will be computed after end of the iteration
and used as return value.


```lisp
> (foreach (c (list 2 3 4) x) 
    (println c)
    (setv x (+ x c)))

=> 9
```

To continue iterating while some condition is true, use `while`.

```
> (setv x 10)

=> 10

> (while (> x 5)
    (setv x (- x 1))
    (println x))
9
8
7
6
5

=> 5
```

The `map` function takes a function and a list and returns the result of applying the function to successive elements.


```lisp
> (map (lambda (x) (+ x 10)) '(1 2 3))


=> [11, 12, 13]
```

Actually it can take any number of sequences, and keeps going till the shortest runs out:

```
> (map #'+ '(1 2 3 4) '(100 200 300))

=> [101, 202, 303]
```

There are functions like `map` that apply functions to successive
elements of sequences. The most commonly used is `filter`, which
returns the elements satisfying some test.

```
> (filter (lambda (x) (> x 0)) '(-2 -1 0 1 2 3))

=> [1, 2, 3]
```

`mapprod` returns a sequence consisting of the result of applying 
func to the cartesian product of the lists:

```lisp
(mapprod #'str '("A" "B" "C") '("1" "2" "3"))

=> [A1, B1, C1, A2, B2, C2, A3, B3, C3]
```


`reduce` allows to apply function to each sequence element while
accumulating the results.  The function must accept two
arguments. Initially it applies the function on the initial value and
the first element of the sequence, then `reduce` applies the function
on its previous result and next element in the list. `reduce` returns
result of it's last function application.

In this example we compute frequencies table for elements of a list of objects.

```lisp
> (reduce 
    (lambda (m x)                    ; function of m - hashmap, x - next element
        (assoc m x (+ 1 (get m x)))) ; increase counter for current word and return updated map
    (hashmap)                        ; initial value of m - empty hashmap of counters
    (list 0 1 0 1 2 1 0 1 2 3 2 1 0 1 2 3 4 3 2 1 0)) 

=> {0=5, 1=7, 2=5, 3=3, 4=1}
```


