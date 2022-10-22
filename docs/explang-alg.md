Tutorial on Using Explang with Algebraic Syntax
===============================================

Expressions
-----------

Explang program is a sequence of one or more expressions which are evaluated
from the beginning to the end.

The language works with expressions that return values. There are no statements.

Expressions are separated by ';' and whitespace is not significant; 

The simplest expressions are things like numbers, booleans or strings, which
evaluate to themselves.

```julia
> 10

=> 10

> true

=> true

> "foo bar"

=> foo bar
```

Explang supports regular algebraic syntax for building complex expressions
using operators and calls to functions:

```julia
10 * (1 + sqrt(2))

=> 24.14213562373095
```

All the operators like '+', '-', '*', etc are also available for use 
in functional form, for example, the same expression using `+` and `*`
in functional form:

```julia
*(10, +(1,sqrt(2)))
=> => 24.14213562373095

```

The advantage of functional form is that you can call operators not with just two,
but with any number of arguments:

```julia
+(1,2,3)

=> 6

+(1)

=>1

+()

=>0
```



Comments
--------

A line comment starts with the `#` character and runs until end of the line:

```julia
> "foo" # a comment

=> "foo"
```

Explang supports block comments as well, they are started by `#=` and run until 
first occurence of `=#`:


```julia
> 1 + #= a block comment =# 2;

=> 3
```


Symbols and their Values
------------------------

The expressions `+` and `*` here are Symbols. 
Symbols don't evaluate to themselves but return values they have been assigned.
If we give `b` the value 10, it will return 10 when evaluated:


```julia
> b:=10

=> 10
> b

=> 10
```

If we try to evaluate a Symbol that has not been assigned a value we'll get error[^1].

Note that evaluation of `b:=10` when `b` still was unassigned did
not cause an error. 

The symbols that start with letter ':' are special, they are
`keywords` -- symbols that are always assigned values of themselves.

```julia
> :something

=> :something

``` 

They may be used for different kinds of indentifiers: keys in map,
names of parameters, etc.

Creating lists
--------------

To create a list of valies use the `[ ]` operator

```julia
> [1, 2 + 3, "foo", :b]

=> [1, 5, foo, b]
```

This operator is equivalent to function `list`:

```julia
> list(1, 2 + 3, "foo", :b);

=> [1, 5, foo, b]
```


Defining Functions
------------------

We've already seen some functions: `+`, `*`. You can define new ones
with the `function` operator. Here's a function that takes two numbers
and returns their average:

```julia
> function average (x, y)
    (x + y) / 2;
  end;

=> io.opsit.explang.Compiler$LAMBDA$1@27fe3806
```

The operator expects a symbol to use as the name, a list of symbols
that describe the parameters, and then zero or more expressions called
the body.

When the function is called, those expressions will be evaluated in
order with the parameter symbols in the body temporarily set ('bound')
to the corresponding argument values. Whatever the last expression
returns will be returned as the value of the call.

The body of the function consists of one expression, `(x + y) / 2`.
It is common for functions to consist of one expression; in purely
functional code (code with no side-effects) they always do.

What is the object returned as the value of the `function` expression?
That's the Java Object that represents the function.

Now the symbol `average` is assigned function value and you can invoke
it in the same way you invoke the built-in functions like `+` or `*`:

```julia
> average(100,200);

=> 150
```

As the literal representation of a string is a series of characters
surrounded by double quotes, the literal representation of a function
is the language keyword `function`, followed by its
parameters, followed by its body. So you could represent a function to
return the average of two numbers as:

```julia
> function (x, y) (x + y) / 2;  end;

=> io.opsit.explang.Compiler$LAMBDA$1@37a71e93
```

And you can call a literal function just like you can call it using the  symbol, e.g.

```julia
> (function (x,y) (x+y)/2; end)(100,200)

=> 150
```


Short Lambda Definitions
------------------------

When the function body consists only of one function there is a
second, shorter syntax for defining an anonymous function in Explang.

The traditional syntax demonstrated above is equivalent to the shorter
version:

```julia
> (x,y)-> (x+y)/2

=> io.opsit.explang.Compiler$LAMBDA$1@71d15f18
```

And when there is only one argument you can use even simpler form:

```julia
x -> x * 2

=> io.opsit.explang.Compiler$LAMBDA$1@38364841
```

Function Values
---------------

Notice that if you try to get the function object simply by referencing the `average` symbol you get an error.

```julia
> average
EXECUTION ERROR: java.lang.RuntimeException: variable 'average' does not exist in this context at:
```

This is because of imprtant property of Explang: named functions and ordinary data variables are 
living in separate namespaces, that is you may assign value to variable `average` without 
overwriting the function `average`:

```julia
> average:=100;

=> 100
> average(average, 200)

=> 150
```

To reference the value of the defined function one must use special syntax:

```julia
> f"average"

=> io.opsit.explang.Compiler$LAMBDA$1@5e9f23b4
```

And to set the function binding one can use the `fset` function, all the def does is 
basically:

```julia
> fset( :average,  (x,y)-> (x+y)/2);

=> io.opsit.explang.Compiler$LAMBDA$1@28c4711c
```


Getting Help on Functions
-------------------------

To get short description of a function or a special operator use
`describe_function`.


```julia
> describe_function("random")

=> random is a built-in function defined at class io.opsit.explang.Funcs$RANDOM

Arguments:  limit

Documentation: 
    Produce Pseudo-Random Number. Returns a pseudo-random number that is a non-negative number less than limit and of the same numeric type as limit. Implemented uding Java Math.random()
Package: base.math
```

`describe_function` works both with the built-in as well with the
user-defined functions.  For the latter ones the function description
is the value of so called documentation strings - "docstrings".  if
the first expression in the function is a string literal it is
considered to be documentation string:

```julia
>  function average (x,y)
     "Compute average of two numbers.";
	  (x + y) / 2;
   end;
    
=> io.opsit.explang.Compiler$LAMBDA$1@37a71e93

> describe_function("average")

Arguments: x, y

Documentation: 
    Compute average of two numbers.
Package: user
```

To get list of all the available function use `functions_names`:

```julia
> functions_names()

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

```julia
> function average (x,y)
      println("my arguments were: ",x,", ",y, "\n");
	  (x + y) / 2;
  end;

> average(100,500);
my arguments were: 100, 500


=> 300
```

Return Value of the Function
----------------------------

From the previous example we see that when a function contains several
expressions the return value of the function is the value of the last
expression in the function. Previous expressions are evaluated 
and their value is discarded. 

If you want to return value from function without reaching the last
expression use the `return` operator.

In the following example we define function that solves quadratic
equations. In the case when determinant is negative we print an error
message and exit prematurely returning an empty list.


```julia
> function quadratic_eq_roots(a,b,c) 
    "Finds real roots of an quadratic equation";
    discriminant:= b * b -  4 * a * c;
    if discriminant < 0
        println("Error: the equation has no real solutions!");
        return []; 
    end; 
    [ ((- b) - sqrt(discriminant)) / (2 * a) ,
      ((- b) + sqrt(discriminant)) / (2 * a)];
  end;

> quadratic_eq_roots(2, 4, -4)

=> [-2.732050807568877, 0.7320508075688772]

> quadratic_eq_roots(1, 2, 3)

Error: the equation has no real solutions!
=> []

```


Optional and Vararg Arguments for Functions
-------------------------------------------

We’ve seen above some functions like `list` and `+` that take varying
numbers of arguments. Now we'll learn to define such functions.

Function parameters list can contain extra directives that specify how
the following parameters will be handled.

To make the parameters optional set its default value 
using the assignment `:=` operator.

```julia
function greet(name, o := NIL)
    str("hello ", name, o);
end;

=> io.opsit.explang.Compiler$LAMBDA$1@2e4b8173

> greet("Joe", "!!!! :-)")

=> hello Joe!!!! :-)

> greet("Joe")

=> hello Joe
```

The expression for the default value does not have to be 
a constant. It can be any expression that can refer to values of 
preceding parameters:


```julia
> function greet(name,
               t1:="",
               t2:= if t1=="Mr." ", Sir"  else if t1=="Mrs." ", Ma'am" end; end)
    str("Hello ", t1, " ", name, "! Nice to see you", t2, "!");
end;

> greet("Figman", "Mrs.");

=> Hello Mrs. Figman! Nice to see you, Ma'am!

> greet("Alice");

=> Hello  Alice! Nice to see you!
``` 

Sometimes it is convenient to create functions that can take any number of arguments.
Such functions are often called "varargs - variable number of arguments" functions.
In Explang youcan make such a function by following the last positional
argument by ellipsis:

```julia
> function foo(x, y, z...)
    [x, y, z];
end;

=> io.opsit.explang.Compiler$LAMBDA$1@37f8bb67

> foo(1+2,  3 + 4,  5 + 6,  7 + 8)

=> [3, 7, [11, 15]]
```

To supply a list of arguments to a function we can use the apply function:

```julia
L:=[1, 2, 3];

=> [1, 2, 3]

> apply(f"+", L)

=> 6
```

Now that we have rest parameters and apply, we can write a version of
average that takes any number of arguments.

```julia
function average(args...) 
    apply(f"+", args) / length(args);
end;

=> io.opsit.explang.Compiler$LAMBDA$1@3d646c37

> average(1, 2 ,3)

=> 2
```


Keyword arguments
-----------------

Keyword arguments are used when we want to pass a specific value to a
specific argument. Consider a scenario where there are 3 optional
arguments, what if the user wants to pass just a second optional
argument’s value, here the first arguments even though is optional it
will be mandatory for him to pass its value making it a required
argument.

To solve this problem keyword arguments are used where the caller has
a choice to specify for argument values to which particular argument
they will be passed.

To define keyword arguments in a function, add ';' after defining the
positional arguments (if any). All the arguments after ';' will be
keyword arguments.

```julia
> function keyword_example (;x, y, z)
    [x, y, z]
  end;

=> io.opsit.explang.Compiler$LAMBDA$1@41cf53f9
```

Keyword argument are passed as assignments of arguments and their values:

```lisp
> keyword_example(z:=3, x:=11, y:= 2)

=> [11, 2, 3]
```

The keyword arguments are optional, you can call this function without 
setting all the arguments, the default argument value is `NIL`.


```julia
> keyword_example();

=> [null, null, null]

> keyword_example(x:=1, y:=2)

=> [1, 2, null]
```

You can set default value of the keyword arguments just like with
optional positional arguments:

```lisp
> function keyword_example (; x:=1, y:=2, z:=x + y)
    [x, y, z];
  end;

=> io.opsit.explang.Compiler$LAMBDA$1@2ef1e4fa

> keyword_example();

=> [1, 2, 3]
```

Very much like with the positional vararg functions you can allow functions
to get any number of keyword parameters in addition to those that are named
in the argument list. 

In the following example the 'r' argument, which is marked with an ellipsis
is used to collect pairs of argument names (keywords) and their walues.  

```lisp
> function  otherkeys_example (x ; y, r...)
    [x, y, r];
end;

=> io.opsit.explang.Compiler$LAMBDA$1@5cb0d902

> otherkeys_example(1)

=> [1, null, []]

> otherkeys_example (1,  y:=2, p:=3, q:=4);

> [1, 2, [:p, 3, :q, 4]]

```


Data Types and Values
---------------------

Explang is a dynamically typed language.  There are no type
definitions in the language: each value carries its own type and 
those types are Java types.

The language can work with Java Objects of any type and it has
built-in support for standard data types such as Strings, Numbers,
Arrays, etc. 

To get type of a value we use function `type_of`:

```julia
> type_of("foo")

=> class java.lang.String

> type_of(1.0)

=> class java.lang.Double
```

To check if object is of some specific type use the `typep` operator:

```julia
> typep("abc", "java.lang.String")

=> true
```

Base Java type from the [java.lang](https://docs.oracle.com/javase/8/docs/api/java/lang/package-frame.html)
can be specified without package:

```julia
> typep("abc", "String")

=> true
```

The check returns true for the specific class as well as for class parents and the interfaces that it implements:

```julia
> typep("abc", "CharSequence")  # String implements CharSequence

=> true
```

The second arguments can be a string as well as symbol:

```julia
> typep("abc", "Object")  # String implements CharSequence

=> true
```

The type of NIL is NIL.

```julia
> typep(NIL, NIL);

=> NIL
```

NIL values
----------

NIL represents absense of a useful value, it is implemented as Java `null`. 
It is not really a data type.

```
type_of(NIL)

=> NIL

```

Booleans 
--------

The boolean type has two values, `false` and `true`. It is implemented using
as Java Boolean objects. 


Numeric Types And Values
------------------------

Explang works with Java numeric types. 

Here table of types with examples of literals,

- 1b, 0b  -- Byte 
- 1s, 2s  -- Short (16 bit signed integer)
- 1, -2   -- Integer (32 bit signed integer)
- 1L  0L  -- Long literals (64 bit signed integer)
- 0.5f 1.2e-2f   -- Float literals (32 bit floating point)
- 0.5 1.2e-2 -- Double literals (64 bit floating point)

```julia
> type_of(1)

=> class java.lang.Integer

> type_of(1b)

=> class java.lang.Byte

> type_of(0.1e4)

=> class java.lang.Double

```


Numeric Types Promotions
------------------------

When one performs arithmetic operations between different numeric types Explang 
performs automatic promotion of numeric types, i.e. the result of the operation 
will be of the type of the argument with highest precision. Operations between 
integer types and floating types are promoted to floating point types:

```julia
> type_of(1b + 1s)

=> class java.lang.Short

> type_of(1b + 1s + 1 + 1L + 1.0)

=> class java.lang.Double
```

Note that Explang does not perform promotion for overflows between operations:


```julia

> 100s * 1000s   # 100000 won't fit into 16 bit Short Integer,
                 # so we'll get wrong result

=> -31072
```

Converting to Numeric Types
---------------------------

The operators `byte`, `double`, `float`, `int`, `long`, `short` convert to corresponding
numeric types from other numeric types as well as from string representation:

```julia
> double(1L)

=> 1.0

> double("1E4")

=> 10000.0

```


Strings
-------

Explang strings are Java Strings. Strings are constant, that is one cannot
change an existing string but have to create new one.

In code we can delimit literal strings by matching double quotes `"`:

```julia
> " a line"

=> a line
```

String literals  can have embedded newlines, tabs and any other characters except `"`: 

```julia
> "line1
line2
line3"

=> line1
line2
line3
```
To include a `"` one need to escape it using the  `\` escape character:

```julia
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

```julia
> "\\t means tab '\t'\n"

=> \t means tab '	'
```

To convert any object into its string representation use 
the `string` operator:

```julia
> string(1 + 2)

=> 3

> string(NIL)

=> NIL
```

There are a couple of operators for building strings. The most general is
string, which takes any number of arguments and mushes them into a
string.

The most general is `str`, which takes any number of arguments and 
concatenates them into a string. Every argument will appear as it would 
look if printed out by pr, except nil, which is ignored.

```
> str(99, " bottles of ", :bee, "#\r")

=> "99 bottles of beer"

```

To control exactly the way the objects are converted to string use
the `format()` function, which converts its argument to string
using the first argument as format specification: 

```julia
(setv x 9786)
(format "Decimal: %d, hexadecimal: %x  octal: %o  char: %c \n" x x x x)

=> Decimal: 9786, hexadecimal: 263a  octal: 23072  char: ☺

```
See [java.util.Formatter](https://docs.oracle.com/javase/8/docs/api/java/util/Formatter.html),
for details on building the format strings.

`uppercase()` and `lowercase()` can be used to change case of a string:

Strings in explang are considered a kind of indexed sequences
and can be operated upon using generic functions that work with sequences,
for example to get substring one should use `subseq()`, 
to get a specific character one uses `get()` or `areq()` and so on. 
See below on how to work with sequences.


Character Type
--------------

Explang Characters represent Unicode 16bit characters and implemented using Java 
[java.lang.Character](https://docs.oracle.com/javase/8/docs/api/java/lang/Character.html).

Character literals are delimited using the 'c', '\UHEX','\uHEX' or '\ESCAPE' notation:

```julia
> [ 'H', 'e', 'l', 'l', 'o', '\n', '\u263a' ];

=> [H, e, l, l, o, 
, ☺]
```


The `char` operator allows to create Characters from their numeric code:

```julia
> char(33)

=> !
```

Characters can be used as operand of arithmetic expressions:

```lisp
char(1 + 'A')

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
they grow/shrink dynamically when elements are added/removed.

The `list` operator creates and initializes a list. By default the
lists created are implemented by
[java.util.ArrayList](https://docs.oracle.com/javase/8/docs/api/java/util/ArrayList.html).


```julia
> list(1, 2, list( 3, 4));

[1, 2, [3, 4]]
```

Call to `list()` may be abbreviated using the '[ ]' syntax:

```
> [1, 2, [3, 4]]

=> [1, 2, [3, 4]]
```


### Maps

Use the `hashmap` to create and initialize a Map 
(implemented by [java.util.HashMap](https://docs.oracle.com/javase/8/docs/api/java/util/HashMap.html)).


```julia
 > hashmap("a", 1, "b", "foo", "c", hashmap("d", "e"))
 
 => {a=1, b=foo, c={d=e}}
```

Call to `hashmap()` may be abbreviated using the '{}' syntax:

```
> { "a" : 1, "b" : "foo",  "c" : { "d" : "e"}}

=> {a=1, b=foo, c={d=e}}
```

Note, that [] and {} syntaxes together allow to initialize data structures using
a JSON compatible notation.


### Sets

A Set is a collection that contains no duplicate elements. More
formally, sets contain no pair of elements e1 and e2 such that `e1 == e2`
would return true. 

As implied by its name, this type models the mathematical set
abstraction.

The `hashset` operator creates a set and initializes it with the specified elements:

```julia
hashset(1, 2, 3, 7)

=> [1, 2, 3, 7]
```

```julia
hashset(1, 1, [1, 2, 3], [1, 2, 3], NIL, NIL)

=> [null, 1, [1, 2, 3]]
```


### Arrays

Arrays are areas of memory that contain entries in slots that can be
addressed by their zero-based index.  Arrays have fixed size that
determined at their creation time. Unlike lists arrays are created 
to contain objects or primitive values of given type.

The `make_array` operator creates array and initializes it with 
specified elements. 

By defaults `make_array` creates array of type Object that can contain any java object.

```julia
> make_array(1,"123", list(1,2), NIL) # array with specified objects

=> [1, 123, [1, 2], null]

> make_array(size:=5)  # array of specified size 

=> [null, null, null, null, null]

> make_array(size:=5, elementType:="double") # array for storing primitive double values

=> [0.0, 0.0, 0.0, 0.0, 0.0]

> make_array(size:=10,                ; array of size 10 
             elementType:="char",     ; for storing primitive character values
             'H', 'E', 'L', 'L', 'O') ;  partially filled

=> [H, E, L, L, O,  ,  ,  ,  ,  ]

```


### Character Sequences

Regular string objects that we've seen earlier is one of the types that 
are called Character Sequences. In Java these objects 
implement interface
[java.lang.CharSequence](https://docs.oracle.com/javase/8/docs/api/java/lang/CharSequence.html)).

There are other such types that, unlike strings, can be modified in place:

The `string_buffer` function creates a 
[StringBuffer](https://docs.oracle.com/javase/8/docs/api/java/lang/StringBuffer.html) object:

```julia
> string_buffer() # creates empty StringBuffer

=> 

> string_buffer("foo", "bar")  # create stringbuffer with text

=> "foobar"
```
The `string_builder` function creates a 
[StringBuilder](https://docs.oracle.com/javase/8/docs/api/java/lang/StringBuilder.html) object.
StringBuilder is similar to StringBuffer, but unlike StringBuffer it can be safely 
modified from differennt threads.

```julia
> string_builder() ;; creates empty StringBuilder

=> 

> string_builder("foo", "bar")  ;; create stringbuilder with text

=> "foobar"
```

In the following chapters we'll learn to operate on data in sequence types.


Getting Information About Collections and Sequences
----------------------------------------------------

The function `length()` returns length of a collection or sequence:

```julia
> [length("Hello"), length(hashmap("a",1)), length(hashset(1, 2, 3)) length(range(1, 10))]

=> [5, 1, 3, 9]
```

The collection predicates return `true` or `false` allow to check if an objects have some 
property or ability. By convention their name ends by _p_ - predicate.


`collp` returns true if the object is a collection of some kind, for example:

```lisp
> [ collp([]),
    collp(make-array()), 
    collp("foo"),         ; string is a CharSequence
    collp(range(1,2)),
    collp(nil),           ;; non-object 
    collp(1)]             ;; individual object

=> [true, true, true, true, false, false]
```

`seqp` returns true if the object is a sequence, that is collection with specific order.

`indexedp` returns true if objects in the collection can be addressed by integer index.

`mapp` returns true if it is a Map.

`setp` returns true if the object is a Set.

`associativep` returns true if objects in collection are indexed or have keys.


### `in` check if a collection contains an object.

The `in` operator checks if a collection contains an object. 

```lisp
> "foo" in hashset("bar","baz","foo")

=> true

> 1000 in range(1, 100)

=> false

> 'e' in  "Hi there!"

=> true
```

Accessing data in collections and Objects
-----------------------------------------

Explang attempts to provide generic data access operators that can be used on
all kinds of sequences, collections and objects like lists, arrays, sets, hash
maps, java beans and so on.

### The Subscript Operator `[k]` 

The subscript operator with key/index `[k]` allows to fetch nested
objects by keys or indices.

The subscript may be any expression, the evaluation result will be used as  key
(in case of Map or Java Bean) or index (in case of Lists, arrays, and other sequences). 

Let's define a data structure that we'll use in our examples:


```julia
data::={ "people": { 1 : { "name"      : "John",
                           "surname"   : "Doe", 
                           "relatives" : {"motherId" : 3,
                                          "fatherId" : 2},
				           "friendIds" : [ 4 ]},
                     2 : { "name"    : "Jack",
                           "surname" : "Doe"},
                     3 : { "name"    : "Ann",
                           "surname" : "Roe"},
				     4 : { "name"    : "Bill",
					       "surname" : "Moe"}}};

{people={1={friendIds=[4], surname=Doe, name=John, relatives={motherId=3, fatherId=2}}, 2={surname=Doe, name=Jack}, 3={surname=Roe, name=Ann}, 4={surname=Moe, name=Bill}}}
```

```julia
> data["people"]

{1={friendIds=[4], surname=Doe, name=John, relatives={motherId=3, fatherId=2}}, 2={surname=Doe, name=Jack}, 3={surname=Roe, name=Ann}, 4={surname=Moe, name=Bill}}

> data["people"][1]["name"]

John

> data["people"][1]["friendIds"][0]

=> 4
```

When provided an invalid index `[k]` returns NIL:

```julia
> data["people"][1]["friendIds"][2]

=> NIL

``` 

It means that it is not possible to know from the return value if an
element is missing or it is a NIL element.

When this is important one can use the `get` function, which
works like `[k]`,but accepts an optional third argument -- default value. 
If index is invalid or key is missing it will return the value of the
third argument:

```julia
> get(data["people"][1]["friendIds"], 3, "No such index")

=> No such index
```

### The `.` (dot) operator

The `.` (dot) operator as well as [k] allows to look up nested
objects, but it works somewhat differently:

- The keys are constant: they are not evaluated at runtime,
- It does not support keys that are not valid symbols: they must start
  with a letter or with`_` and can contain only alphanumeric
  characters, `_` and `!`.


```julia
data.people[1].friendIds

=> [4]

> data.people[1].surname.bytes  # gets array of bytes from  String.getBytes()

=> [68, 111, 101]

```

### Empty subscript `[]`

When there is no index specified the operator works as an iterator,
that is it applies all the following subkey operations on all the values
in the collection:

```julia
> data.people[]   # return list off map entries

=> [1={friendIds=[4], surname=Doe, name=John, relatives={motherId=3, fatherId=2}}, 2={surname=Doe, name=Jack}, 3={surname=Roe, name=Ann}, 4={surname=Moe, name=Bill}]


> data.people[]["key"]  # returns list of map keys

=> [1, 2, 3, 4]

> data.people[]["value"]  # returns list of map values

=> [{friendIds=[4], surname=Doe, name=John, relatives={motherId=3, fatherId=2}}, {surname=Doe, name=Jack}, {surname=Roe, name=Ann}, {surname=Moe, name=Bill}]

> data.people[]["value"]["name"]

[John, Jack, Ann, Bill]
```

### `get_in` function access values in nested structures

`get_in` performs data retrival like a chain of `[k]` operators, but 
list of keys is provided as a list that can be set dynamically at runtime.

```julia
> get_in(data, ["people",1,"relatives", "motherId"])

=> 3
```

When there is no mapping get-in returns NIL.

```julia
> get_in(data, ["people",1,"relatives", "brothersIds"])

=> NIL
```

`get_in` also allows to specify default for missing keys/indices:

```
> get_in(data, ["people",1,"relatives", "brothersIds"], "N/A")

=> N/A
```


### `fields` operator

The fields operator allows to select a subset of keys 
from a map or from list/array entries:

```
> data.people[]["value"]  fields name, surname

[{name=John, surname=Doe}, {surname=Doe, name=Jack}, {surname=Roe, name=Ann}, {name=Bill, surname=Moe}]

> data.people[1] | fields name, surname

=> {surname=Doe, name=John}

```

### `select_keys` function select entries by their keys/indices

Returns map of  entries selected  by their keys/indices

```julia
> select_keys(data.people, [1,2])

=> {2={surname=Doe, name=Jack}, 1={friendIds=[4], surname=Doe, name=John, relatives={motherId=3, fatherId=2}}}
```
The returned Map is actually kind of a view into the original object, 
that is it reflects changes in the original:

```julia
> m:={ "a": 1, "b" : 2}

=> {a=1, b=2}

> s:=select_keys(m, list("a","c"))

=> {a=1}

>  m["c"]:="3"

=> 3

> m

=> {a=1, b=2, c=3}

> s

=> {a=1, c=3} # now s got new entry c=3
```
### `first` 

`first` return first object in collection

```julia
> first([2,3,4,5])

=> 2
```


### `rest`, `take` and `subseq`

`rest` returns the subsequence starting from the second element.

`take` returns first n elements of the sequence.

`subseq` returns a subsequence from the given index or between the first given index and up to the second given index (excluding):

```
> a:=[1,2,3,4,5,6]

=> [1, 2, 3, 4, 5, 6]

> first(a)

=> 1

> rest(a)

=> [2, 3, 4, 5, 6]

> subseq(a,1)

> [2, 3, 4, 5, 6]
```

The `take` and `subseq` return sequence of the same kind as the source
sequence.  The type of the returned sequence differs depending on the
type of the source sequence.  For lists it returns a sublist, which is
sharing the elements with the source list.  For arrays this is not
possible and the data is copied into new array.

```
b:=subseq(a,1,3)

=> [2, 3]

> a[1]:=8

=> 8

> b

=> [8, 3]
```

### haskey 

`haskey` checks if a Map has given key or if an indexed sequence has specified index.
Unlike `get` and `in` this allows to check whether a map contains NIL as a key.


```julia
> M:={1 : 2,  NIL : NIL}

=> {null=null, 1=2}

> haskey(M, 1)

=> true

> haskey(M, NIL)

=> true

> haskey(M, 2)

=> false
```


Destructuring of Data Structures
--------------------------------

Destructuring allows to easily fetch data elements from data
structures and asign them to variables without fetching them
individually using functions like `get` or `get-in`.

The idea is to provide on the receiving end of the assignment operator
a sort of template for the data structure with the desired names of variables.

### Destructuring of sequences

Suppose we have a function that returns a vector with three values that represent coordinates:

```julia
> function getpos() [1,2,3]; end;

=> io.opsit.explang.Compiler$LAMBDA$1@7b49cea0

> pos := getpos();

=> [1, 2, 3]
```

We could access individual coordinates using subscripts like `pos[0]`, but this is 
kinde of cumbersome and not very readable. We could also assign individual values to variables 
`x`,`y`,`z` using assignments,  but destructuring allows to do it in one easy statement:


```julia
> [x,y,z] := getpos();

=> [1, 2, 3]

> format("x=%d, y=%d, z=%d\n", x,y,z);

=> x=1, y=2, z=3
```

When there are more elements in the source sequence than in the target template, the rest of the 
values are ignored. So if we were interested only in the first coordinate we could write:


```julia
> [x] := getpos();

=> [1, 2, 3]

> x

=> 1
```

One can use same symbol several times in the template, the name will
end up bound to the last value. For example, if we were interested
only in the last coordinate we could write:

```julia
> [_, _, z] := getpos();

=> [1, 2, 3]

> z

=> 3
> _

=> 2
```

By convention a single underscore is used for variables that we
have to use, but do not care about their value.

Destructuring works for various kinds of sequences, not just lists:

```julia
> [a, b ,c, d, e] := "CHARS";

=> CHARS

> [a, b, c, d, e]

=> [C, H, A, R, S]
```

### Destructuring of Nested Sequences

Instead of being a symbol an element of the template can be a 
nested list. In this case the destructuring will proceed 
recursively:

```julia
> val:=[1, 2, [3, 4], 5];

=> [1, 2, [3, 4], 5]

> [a,b, [c, d], e] := val;

=> [1, 2, [3, 4], 5]

> [ a, b, c, d, e]

=> [1, 2, 3, 4, 5]
```

### Destructuring of Maps

Destructuring also works for Maps. The idea is the same as with
sequences: you provide a template for the map: a structure that
includes the symbols that you want to bind to values in the map and
the keys of those values.

Suppose we have this simple map with personal data:

```julia
> entry := { "name"    : "John",
             "surname" : "Doe",
             "age"     :  44 };
=> {surname=Doe, name=John, age=44}
```

To extract name and surname from the above record we 
provide map with variable symbols as keys and keys of the source 
map as symbols:

```julia
> {surname : "surname", name : "name" } := entry;

=> {surname=Doe, name=John, age=44}

format("name=%s, surname=%s\n", name, surname);

=> name=John, surname=Doe
```

One can destructure nested structures as well. Let's add a nested map and a nested 
list to the above data structure:

```julia
> entry := { "name"    : "John",
             "surname" : "Doe",
             "age"     :  44 ,
             "parents" : { "mother" : "Mary Doe", "father" : "Richard Doe" },
             "brothers" : [ "jack", "harry"]};

=> {brothers=[jack, harry], surname=Doe, name=John, age=44, parents={mother=Mary Doe, father=Richard Doe}}

```

To extract names of parents we add to the left-side map in place of a symbol
a submap to destructure the nested map:

```julia
> { { mom : "mother", dad : "father"} : "parents" } := entry;

=> {brothers=[jack, harry], surname=Doe, name=John, age=44, parents={mother=Mary Doe, father=Richard Doe}}


> format("mom=%s, dad=%s\n", mom, dad);

=> mom=Mary Doe, dad=Richard Doe

```

To extract names of both brothers:


```julia
> { [ brother1, brother2] : "brothers" } := entry;

=> {brothers=[jack, harry], surname=Doe, name=John, age=44, parents={mother=Mary Doe, father=Richard Doe}}

> brother1

=> jack

> brother2

=> harry

```




Modifying data in collections
-----------------------------

There are two kinds of functions that modify data in collections:
those that change the data in place (mutating) and those that return
new data structures with requested changes. By convention the former
ones have names that end with exclamation mark.

### `put!` - put element value into an associative structure.

Set value of element at index/key in the target structure to object. 

If target object is a list or an array and an out of bound exception happens
the function returns normally without any change to the target structure

This function returns previous value of the element or NIL if id did not exist
or no change has been made."


Example with a Map:

```lisp
> m:={"foo" : 1 }

=> {foo=1}

=> 

> put!(m,"bar",77)

=> NIL

> put!(m, "foo",0)

=> 1

> m

{bar=77, foo=0}
```

Example with an array of integer numbers:

```julia
> a:=make_array(size:=5, elementType:="int")

=> [0, 0, 0, 0, 0]

> put!(a, 1, 10)

=> 0

> a

=> [0, 10, 0, 0, 0]
```

### Using the assignment operator to modify data structures.

Let's add some friends to John using the same structure 
from the `get-in` example above:

```julia
data::={ "people": { 1 : { "name"      : "John",
                           "surname"   : "Doe", 
                           "relatives" : {"motherId" : 3,
                                          "fatherId" : 2},
				           "friendIds" : [ 4 ]},
                     2 : { "name"    : "Jack",
                           "surname" : "Doe"},
                     3 : { "name"    : "Ann",
                           "surname" : "Roe"},
				     4 : { "name"    : "Bill",
					       "surname" : "Moe"}}};

{people={1={friendIds=[4], surname=Doe, name=John, relatives={motherId=3, fatherId=2}}, 2={surname=Doe, name=Jack}, 3={surname=Roe, name=Ann}, 4={surname=Moe, name=Bill}}}
```

Use of the subscript [k] and `.` operators is supported on the left side of the assignment:

```julia
> data["people"][5]:={"name" : "Rick", "surname": "Hoe"} # add new person to map with index 5

=> {surname=Hoe, name=Rick}

> data["people"][1]["friendIds"][1] :=  5 # add id of the newly added person

=> 5

> data

=> {people={1={friendIds=[4, 5], surname=Doe, name=John, relatives={motherId=3, fatherId=2}}, 2={surname=Doe, name=Jack}, 3={surname=Roe, name=Ann}, 4={surname=Moe, name=Bill}, 5={surname=Hoe, name=Rick}}}

```

### the put_in! modify value in a hierarchy of nested associative structures.

The `put_in!` function performs data modification like the assignment
operator on a chain of `[k]` and `.` operators. It accepts a list of
keys that allows to navigate dynamically in nested associative
structures. `put_in!` return the modified data structure.

The same operation as above using `put_in!`:

```julia
> put_in!(data,["people",5], {"name" : "Rick", "surname": "Hoe"}) # add new person to map

=> {people={1={friendIds=[4], surname=Doe, name=John, relatives={motherId=3, fatherId=2}}, 2={surname=Doe, name=Jack}, 3={surname=Roe, name=Ann}, 4={surname=Moe, name=Bill}, 5={surname=Hoe, name=Rick}}}
```

In addition `put_in!` accepts one optional argument that allows to
specify how to automatically create structures along the path in case
they do not exist. For example this will add Rick Row (id=5) as a
friend to Bill that does not have a list of friend identifiers.
`put-in` would copy the provided object (an empty list) to create list
of friendIds.


```julia
> put_in!(data, ["people",4,"friendIds", 0], 5, [])

=> {people={1={friendIds=[4, 5], surname=Doe, name=John, relatives={motherId=3, fatherId=2}}, 2={surname=Doe, name=Jack}, 3={surname=Roe, name=Ann}, 4={friendIds=[5], surname=Moe, name=Bill}, 5={surname=Hoe, name=Rick}}}

```

### remove!

Removes an object from a collection according to its key or index. 
For sets it will remove the object by its value.

```
L:=[1, 2, 3]

=> [1, 2, 3]

> remove!(L, 1)

=> 2

> L

=> [1, 3]

```

### `insert!`, `push!` and `pop!`

These functions work for lists and mutable character sequences. 


`insert!` inserts an object at given index:

```julia
> L:=[1, 2, 3]

=> [1, 2, 3]

> insert!(L, 1, "X")

[1, X, 2, 3]
```


`push!` will add an object to the end of a sequence, `pop!` will
remove and return the object at the end of the sequence.

```julia
> stack:=[]

> push!(stack, "foo")

=> [foo]

> push!(stack, "bar")

=> [foo, bar]

> pop!(stack)

=> "bar"

> stack

=> [foo]
```

### APPEND! 

`append!` adds to the target sequence all the elements of all of the following sequences.
It will return the target sequence. For example:

```julia
> L:=[1, 2, 3]

=> [1, 2, 3]

> append!(L, [4, 5, 6],  make_array(7, 8, 9), "HELLO!" )

=> [1, 2, 3, 4, 5, 6, 7, 8, 9, H, E, L, L, O, !]
```

Target sequence must be mutable extendable, that means that objects 
like Arrays (non-extendable) or String (immutable) cannot be target of this operation.


### `reverse!` 

`reverse!` Reverses the order of elements in the given sequence:

```lisp
> L:=[1, 2, 3, 4, 5, 6]

=> [1, 2, 3, 4, 5, 6]

> reverse!(L)

=> [6, 5, 4, 3, 2, 1]

> reverse!(subseq(L,1,4))

=> [3, 4, 5]

> L

=> [6, 3, 4, 5, 2, 1]
```

### `sort!` sort a sequence.

`sort!` will sort a sequence. It can sort 
according to the natural order of its objects (if they implement 
`java.lang.Comparable`) or using a user specified compare function.

```julia
> L:= make_array(1, 9, 8, 8, 6)

=> [1, 9, 8, 8, 6]

> sort!(L)

=> [1, 6, 8, 8, 9]

> L

=> [1, 6, 8, 8, 9]
```

Sort according to length of sequences with a custom compare function:

```julia
> L:=[[], [1, 2, 3, 4, 5], [1, 2], [1, 2, 3], [1]];

=> [[], [1, 2, 3, 4, 5], [1, 2], [1, 2, 3], [1]]

> sort!( (a, b) -> length (a) - length (b), L)

=> [[], [1], [1, 2], [1, 2, 3], [1, 2, 3, 4, 5]]

> L

=> [[], [1], [1, 2], [1, 2, 3], [1, 2, 3, 4, 5]]
```


Collection Specific Access functions
------------------------------------

In addition to the generic data access functions there are 
data access functions that are specific for concrete collection types.

### aref and aset! -- array member access.

Unlike `put!` and `get` they will fail with exception when index is invalid. 


```julia
> L:=[1, 2, 3]

=> [1, 2, 3]

> aset!(L, 1, 0)

=> 2

> L

=> [1, 0, 3]

>

```

### assoc! 

Adds one or more mappings to a Map:

```julia
> M:={}

=> {}

> assoc!(M, 1, 2, 3, 4, 5, 6)

=> {1=2, 3=4, 5=6}
```


Modifying data with non-mutating functions
------------------------------------------

The mutating functions that were described above have non-mutating
counterparts that have same names without the '!' suffixes, accept
same arguments and, instead of modifying target objects, 
return new object with required modifications 
leaving the original objects unmodified.


For example `append` concatenates its argument into new sequence:

```lisp
> L:=[0]

> append(L, [1, 2, 3], "Hello")

=> [0, 1, 2, 3, H, e, l, l, o]

> L  # not changed

=> [0]
> 
```

The returned sequence is of the same kind as the first function argument, so this 
construction may be used to convert collection into other collection types:

```lisp
> append( [] hashset(1, 2, 3))  ;; convert a set into a list
```

List of non-mutating functions for data modification:

`append`, `aset`, `assoc`, `insert`, `push`, `pop`, `put`, `put-in`, `remove`, `reverse`,
`sort`



Searching and Matching Text Data Using Regular Expressions
----------------------------------------------------------

Regular expression (regex) support in Explang is implemented using the
Java regular expression engine.

This guide assumes that you have general understanding of what the
regular expressions are and how to use them.  There are good resources
for learing about regular expressions and trying them online,
for example [Regex 101](https://regex101.com).
The reference documentation for Java regex syntax is here:
[java.util.regex.Pattern](https://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html).


### Creating Regex Patterns


In explang you can create a regex using a literal syntax. 
Strings with a '#' in front are interpreted as regexes:


```julia
> r"^Hello$"

=> ^Hello$

```

This will create and instance of `java.util.regex.Pattern` that can be 
immediately used for matching a text or saved for later use.

Alternatively you can create regexes from string using the `re-pattern`
function:

```julia
> re_pattern("^Hello$")

=> ^Hello$

```

The literal syntax is the most convenient because you don't need to
double escape regexp special characters. For example, if you want to
represent the regex string to match a digit, using a string
you would need to write this:

For example, if you want to represent the regex string to match a
digit, using a string you would need to write this:

```julia
> re_pattern("\\d")

=> \d
```

Notice that you have to escape the backslash to get a literal
backslash in the string. However with literals you do not need to
double escape:

```julia
> r"\d"

=> \d
```

On the other hand, the `re_pattern` function is good when you have to
build regexes dynamically or get them from some external source.



### Globbing Patterns

Globbing patterns are commonly used to specify sets of filenames with
wildcard characters. 

- `*` a wildcard standing for any string of characters
- `?` a wildcard that stands for one character

For example "a*.txt" is a glob pattern that would match 
names of files with '.txt' extension.

Explang supports globbing patterns by internally converting them to
regex patterns. One can use the produced pattern just like 
regular regex patterns.

You can create globbing patterns using  a literal syntax,
Strings with a '#g' in front are interpreted as regexes:


```julia
> g"a*.txt"

==> a.*\.txt

```

Alternatively you can create globbing patterns 
from strings using the `re_glob` function:

```julia
> (re_glob "a*.txt")

=> a.*\.txt

```

### Creating a Case Insensitive Regex (and other flags)


The Java regex engine allows to supply extra flags when creatting
regexp pattern.  The most commonly used flag is `i` - case insensitive
matching.

Java regexes allow for a special syntax (embedded flags expression) to
enable flags within the regex.

no flags (case-sensitive):
```
> re_matches(r"abc","ABC")

=> NIL
```

case-insensitive flag set

```
> re_matches(r"(?i)abc", "ABC")

=> ABC
```

Explang regex literals support specifying flags after the expression:

```
> re_matches(r"abc"i, "ABC")

=> ABC
```


The `re-pattern` and `re-glob` functions accept an optional string
argument that contains string of regexp flags:

```
> re_matches(re_pattern("abc","i"), "ABC")

=> ABC
```

There are other flags but 'i', see the full list in the 
[Java documentation](https://docs.oracle.com/javase/7/docs/api/java/util/regex/Pattern.html).
The characters used for flags are the same that are used for embedded flags.

### Matching a Regex to a String with Groups

Very often, you want to match an entire string. The function to do
that is called `re-matches`. it takes a regex and a
string and returns the result of the match.

```julia
re_matches(<REGEX>,<STRING>) 

=> <RESULT>
```

The result it returns is a little complex. There are three things it can return.

If the whole string does not match, re-matches returns NIL.

```julia
> re_matches(r"abc", "xyz")

=> NIL

> re_matches(r"abc", "zzzabcxxx")

=> NIL

> re_matches(r"(a)bc", "hello, world")

=> NIL
```

If the string does match, and there are no groups (parens) in the
regex, then it returns the matched string.

```
> re_matches(r"abc","abc")

=> abc

> re_matches(r"\d+", "3324")

=> 3324
```

Note, that can use re-matches as the test expression of a conditional when matched string cannot be empty:

```julia
if re_matches(r"\d+", x)
  println("x is all digits");
else
  println("x is not all digits")
end;
```

Since the emplicit boolean value of an empty string is false, so if regexp matches 
empty string, you need to explicitly test that the returned value is not null:

```julia
if notnilp(re_matches(r"\d+", x))
  println("x is all digits");
else
  println("x is not all digits")
end;
```
  
If it matches and there are groups, then it returns a list, its first
element is the entire match. The remaining elements are the group
matches.

```julia
> re_matches(r"abc(.*)", "abcxyz") 

=> ["abcxyz" "xyz"]

> re_matches(r"(a+)(b+)(\d+)", "abb234")

=> ["abb234" "a" "bb" "234"]
```

### Finding a regex substring within a string with groups

Sometimes we want to find a match within a string. `re-find` returns the
first match within the string. The return values are similar to
re-matches.

1. No match returns nil

```julia
> re_find(r"sss", "Loch Ness") 

=> NIL
```

2. Match without groups returns the matched string

```
re_find(r"s+", "dress") 
=> "ss"
```

3. Match with groups returns a list

```
re_find(r"s+(.*)(s+)","success") 

=> ["success" "ucces" "s"]
```

### Finding all substrings that match within a string

To find all substrings that match within a string use `re-seq`.
`re-seq` returns a lazy seq of all of the matches.
The elements of the seq are whatever type re-find would have returned.


```julia
append([],re_seq(r"s+","mississippi"))

=> ["ss" "ss"]
```

```julia
append([], re_seq(r"[a-zA-Z](\d+)", "abc x123 b44 234")) 
        
=> [[x123, 123], [b44, 44]]
```

`append ()` materializes lazy sequence that re-seq returns so we can
see text of matched strings.




Conditionals
------------

Conditional evaluation allows portion of code to be evaluated or not evaluated
depending on a value of an expression (condition). 
In explang The conditional operator has form

```julia
If x < y
   println("x is less than y");
elseif x > y
   println("x is greater than y");
else 
   println("x is equal to y");
end
```

If the condition expression x < y is true, then the corresponding
block is evaluated; otherwise the condition expression x > y is
evaluated, and if it is true, the corresponding block is evaluated;
if; if none of the expression is true, the else block is evaluated. 

Here it is in action:

```julia
function test(x, y)
    if x < y
        println("x is less than y");
    elseif x > y
        println("x is greater than y");
    else
        println("x is equal to y");
    end;
end;
=> io.opsit.explang.Compiler$LAMBDA$1@2d1ef81a

> test(1,2)
x is less than y

=> x is less than y

> test(2,1)
x is greater than y

=> x is greater than y

> test(1,1)
x is equal to y

=> x is equal to y
```

The `elseif` and `else` blocks are optional, and as many `elseif` blocks as
desired can be used. The condition expressions in the if-elseif-else
construct are evaluated until the first one evaluates to true, after
which the associated block is evaluated, and no further condition
expressions or blocks are evaluated.

`if` blocks also return a value: this value is simply the return
value of the last executed statement in the branch that was chosen.
If no branch was chosen the return value is NIL:


```julia

> x:=-5;

=> -5

> println( if x > 0 "positive" elseif x < 0 "negative" else "zero" end);

=> negative

> if x >= 0 sqrt(x); end

=> NIL

```

### Implicit Truth values

The `if` operator checks the truth value of its condition. The comparison functions
like `<` or `>=`  return Java Boolean objects `true` or `false`:

```julia
> 1 < 0

=> false
```

But, actually, in Explang all expressions have implicit truth values and thus can
be used in conditional expressions.

Generally, `false`, `NIL`, zero numbers of different types, 
empty lists, sets, strings  and other sequences have implicit `False` truth value. 
Other objects have  thruth value of `true`. 

For example 

```julia
> if 0 "yes" else "no" end;

=> no
```

To check truthyness of an expression one can use built-in function `bool`
that returns thruthiness value of an expression. 

```julia
> bool("")

=> false
```


The Logical operators
---------------------

The logical negation function is called `not`, it returns Boolean value, which is inverse of the
the truth value of its argument:

```julia
> not true

=> false
> not false

=> true

> not "foo"

=> false
```

Logical operators `and` and `or`:

```
true or false

=> true
```

Like most other operators they can be used using function call syntax on any number of arguments.

`and` evaluates its argument from left to right and returns false if it encounters an argument
 that has logical value false it stops evaluation and returns the encountered value.
 If no such argument encountered it returns true:
 

```julia
> and()

=> true

> and(true, false, 0)

=> false

> and(1, 0, false) 

=> 0
```
Similarly 'or' evaluates its argument from left to right and returns false if it encounters an argument
 that has logical value false it stops evaluation and returns the encountered value.
 If no such argument encountered it returns true:
 

```julia
> or()

=> false

> or(false, 1, true)

=> 1

> or(false, true, 1)

=> true
```

This behavior may be  used to form an alternative to very short if statements. 
Instead of using if one can write <condition> `AND` <statement>;
(which could be read as: <condition> and then <statement>). 
Similarly, instead of if `NOT` <condition> <statement> end, one can write 
<condition> `OR` <statement>; (which could be read as: <cond> or else <statement>).

For example, a recursive factorial routine could be defined like this:

```
> function fact(n)
           n >= 0 or return("ERROR: n must be non-negative");
           n == 0 and return 1;
           n * fact(n-1);
  end;

=> io.opsit.explang.Compiler$LAMBDA$1@2ea41516

> fact(5)

=> 120
```

Iteration Operators
-------------------

### `for-in` loop

To iterate through the elements of a colleaction or sequence  use `for-in` operator:

```julia
> for c in [ "one", "two", "three" ]
    println(c);
  end;
  
one
two
three

=> NIL
```

The NIL you see at the end is not printed out by the code in the loop.
They're the return values of the iteration expressions. One can give 
one additional argument that will be computed after the end of the iteration
and used as return value.


```julia

> function stddev(args...)
    "computes standard deviation sqrt(E(X-mu)^2)"
    avg := apply(f"average", args); # call average() we defined before
    sum:=0.0;
    for x in args result sqrt(sum / length(args)) 
        sum := sum + (x - avg) * (x - avg);
    end
end;

> stddev(2,4,4,4,5,5,7,9)

=> 2.0
```

To iterate over numeric ranges use for-in with range() that creates lazy sequences of numbers.
In this example we'll find prime numbers from 3 up to 1000:

```julia
for num in range(3, 100, 2)  # only odd numbers
    prime:=true;
    for i in range (2, sqrt(num)+1)
        if (num % i) = 0
            prime:=false;
        end;
    end;
    if prime
        print(" ", num);
    end;
end;
```

### `while` loop

To continue iterating while some condition is true, use `while` operator.


This is example will solve equation log(2-x)=x iterating while the solution
keeps changing more then defined limit;

```
new:=1.0;
x:=0;
r:=(while (x-new)*(x-new) > 0.000001
        println(x);
        x:=new;
        new:= log(2-x);
    end);

println("result=",r);

0
1.0
0.0
0.6931471805599453
0.26762181884443453
0.549495135702461
0.37191167810526626
0.48740651788686606
0.4138257153687164
0.4613250066022943
0.4309216521766674
0.45048840738203205
0.4379397797394399
0.4460056039781503
0.44082864577540753
0.4441544969443128
0.44201912973119606
result=0.44250995001095506
```

### `map` iterator


The `map` function takes a function and a sequence and returns the
result of applying the function to successive elements.


```julia
> map(x -> x * x, [1, 2, 3, 4, 5])

=> [1, 4, 9, 16, 25]
```

Actually it can take any number of sequences, and keeps going till the shortest runs out.
The function must accept same number of arguments.

```
> map((x,y) -> x + y, [1, 2, 3, 4], [100, 200, 300])

=> [101, 202, 303]
```

### `filter`

There are other functions like `map` that apply functions to successive
elements of sequences. The most commonly used is `filter`, which
returns the elements satisfying some test.

```
> filter( x -> x > 0, [-2, -1, 0, 1, 2, 3])

=> [1, 2, 3]
```

### `mapprod`

`mapprod` returns a sequence consisting of the result of applying 
func to the cartesian product of the lists:

```julia
mapprod( f"str", ["A", "B", "C"], [1, 2, 3, 4])

=> [A1, B1, C1, A2, B2, C2, A3, B3, C3, A4, B4, C4]
```

### `reduce`


`reduce` allows to apply function to each sequence element while
accumulating the results.  The function must accept two
arguments. Initially it applies the function on the initial value and
the first element of the sequence, then `reduce` applies the function
on its previous result and next element in the list. `reduce` returns
result of it's last function application.

In this example we compute frequencies table for elements of a list of
objects. The initial value is an empty map `{}` of counters for elements
of sequence. The function increases counter for each encountered
element of the sequence (initially there is no entry, but it works
since NIL has implicit numeric value of 0).


```julia
> L:=[0, 1, 0, 1, 2, 1, 0, 1, 2, 3, 2, 1, 0, 1, 2, 3, 4, 3, 2, 1, 0]

=> [0, 1, 0, 1, 2, 1, 0, 1, 2, 3, 2, 1, 0, 1, 2, 3, 4, 3, 2, 1, 0]

> reduce( (m,x) -> assoc(m, x, m[x]+1), {}, L);

=> {0=5, 1=7, 2=5, 3=3, 4=1}
```








