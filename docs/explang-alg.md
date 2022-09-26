Tutorial on Using Explang with Algebraic Syntax
==========================================

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



Explang/Algebraic Syntax Language Reference
===========================================


Expressions
-----------

The language works with expressions that return values. There are no statements.

The expressions can be simple (literal value) or complex ones that consist of several
subexpressions like operator or function invocations.

Expressions are separated by ';'. 

Whitespace is not significant.

Value Types
-----------

All values are Java Objects of some type


Self Evaluating Expressions (Literals)
-------------------------------------

### Numeric Literals

- 1, -2     Integer literals
- 1b, 0b    Byte literals
- 1s, 2s    Short literals
- 1L  0L    Long literals
- 0.5 0e2   Double literals
- 0.5f      Float literals
- NULL NIL  null literals
- TRUE FALSE boolean literals

### String Literals

String literals are 

"foo" "Hello,\nworld!"

### Special Literals

- r"^Foo" r"bar"i - Regular Expression Literals
- v"0.0.3-alpha2" - Version literals

[TBD]
Character Literals


Data Initializers
-----------------


list literals
array literals
map literals
set literals


 
### Variable expansion

Simple expressions that are not recognized as literals are evaluated as variables.
Evaluation of a variable does not exists in current context will cause Runtime Exception
to be thrown.


### Complex expressions


Complex expressions are introduced using the 

```
( form_name  expr .... )

```
 

The first expression inside the parentheses is used as name of operation and rest of expressions serve as parameters.
For example *+* is the addition function:

```

[0]> (+ 1 3 4)

8

```

The expressions are evaluated and return single Java Object as result of evaluation.

 

Complex expressions can be divided into two classes:

 

####  Function calls

 

Functions are evaluated in the following way: first all function parameters are evaluated from left to right,
the results of evaluation are substituted in stead of the parameters, then the function is evaluated using the
computed parameters. Functions can be built-in or user defined. Functions can be built-in (that is written
in java as part of Opsit DSL), user functions written in Opsit DSL (introduced using the LAMBDA and DEFUN forms)
as well as user-provided and written in Java (using extension mechanism).


#### Special forms calls

 

With special forms order of argument evaluation and the way they are evaluated is part of logic of the special form.

For example in the IF special form

```

(IF a b c)

```

first of all a will be evaluated, then according to the effective boolean value of *a* will be evaluated only one of

 the expressions: *b* if *a* is *TRUE* and *c* if a is *FALSE*.

 

# The Opsit-DSL Expression Language Guide and Reference 


## Lanuage Overview

[TBD]

## Opsit-DSL Expressions by example

Suppose we have the following variables set:

```julia
# an empty string
description := ""
# a non-empty string
owner := "infra_team"
# list of strings:
frameworks := ["Django", "Ember", "Django", "Meteor"]

```
The value of expression is expressed by `##=> Value``

### Truthiness value

Generally, NIL, empty things and zero numbers have thruthiness value
of `False` and non empty have thruthiness value of `True`. 

To check truthyness of an expression one can use built-in function `bool(val)`
that returns thruthiness value of an expression. 

Note: The `bool()` function is used here just for illustration, 
you do not really need to wrap your Opsit Checks Expressions with `bool()`
because the DSL automatically converts expressions to boolean when it is
needed according to the context. 


Thus:

A non-empty list is thruthy:
```julia
bool( frameworks )
##=> true
```

Non-zero numeric values are thruthy
```julia
length(frameworks)
##=> 4

bool(length(frameworks))
##=> true
```

Non-empty strings are truthy

```julia
frameworks[0]
##=> "Django"

frameworks[0]
bool(frameworks[0])
##=> true
```

Empty Strings are falsy:

```julia
description
##=>""

bool(description)
##=> false
```


### Numeric values of expressions

All values have a numeric value. This value is used when required by context.

- Numeric types are themselves their numeric value
- Lists, maps, arrays, sets  have they size as their numeric value
- NIL has 0 as its numeric value
- Booleans True ans False has 1 and 0 accordingly  as their numeic values
- Other objects have 1 as their numeric values


```julia
0+list(1,2,4)
##=> 3

0 + False
##=> 0

0+"abc"
##=> 0

0 + NIL
##=> 0

0 + TRUE
##=> 1

```

### Getting values from nested structures:


Suppose we have the following variables set:

```julia
teams := [{
  "name" : "New Hampshire birds",
  "uniqueId" : "New-Hampshire-birds-Shipper81788",
  "description" : "I have no idea where this will lead us. But I have a definite feeling it will be a place both wonderful and strange.",
  "members" : [ {
    "role" : "Project Manager",
    "name" : "Luke Hauck",
    "email" : "josue.friesen@gmail.com"
  }, {
    "role" : "Project Manager",
    "name" : "Ambrose Dickinson",
    "email" : "joyce.price@gmail.com"
  }, {
    "role" : "Developer",
    "name" : "Idalia Frami DDS",
    "email" : "malcom.hahn@hotmail.com"
  }, {
    "role" : "Lead DevOps",
    "name" : "Catarina Ullrich",
    "email" : "edmundo.bode@yahoo.com"
  }, {
    "role" : "Team Lead",
    "name" : "Jan Bednar Sr.",
    "email" : "blythe.heaney@gmail.com"
  }, {
    "role" : "Lead Developer",
    "name" : "Marianela Jerde",
    "email" : "mary.bashirian@gmail.com"
  } ]
}, {
  "name" : "Idaho birds",
  "uniqueId" : "Idaho-birds-Shipper28978",
  "description" : "That gum you like is going to come back in style.",
  "members" : [ {
    "role" : "Project Manager",
    "name" : "Mr. Gaston Cummings",
    "email" : "alberto.buckridge@yahoo.com"
  }, {
    "role" : "Developer",
    "name" : "Elida Ondricka",
    "email" : "maurita.thiel@gmail.com"
  }, {
    "role" : "Product Manager",
    "name" : "Edna Green",
    "email" : "britni.cormier@yahoo.com"
  }, {
    "role" : "Developer",
    "name" : "Jonathan Prosacco",
    "email" : "vernetta.kerluke@hotmail.com"
  }, {
    "role" : "Project Manager",
    "name" : "Leilani Kuhlman",
    "email" : "carmine.hermann@yahoo.com"
  }, {
    "role" : "Developer",
    "name" : "Tyson Shanahan",
    "email" : "max.vonrueden@yahoo.com"
  } ]
} ]
```

### The Subscript Operator `[]` 

The subscript operator `[]` allows to fetch nested objects by keys or indices. 

The subscript may be any expression, the evaluation result will be used as  key (in case of Map or Java Bean) 
or index (in case of Lists, arrays, and other sequences). 

[To be
It can be as well a slice or filter specification. In this case the operator will return a collection of selected entries.


```julia
teams[0]
##=> {
  "name" : "New Hampshire birds",
  "uniqueId" : "New-Hampshire-birds-Shipper81788",
  "description" : "I have no idea where this will lead us. But I have a definite feeling it will be a place both wonderful and strange.",
  "members" : [ {
    "role" : "Project Manager",
    "name" : "Luke Hauck",
    "email" : "josue.friesen@gmail.com"
  }, {
    "role" : "Project Manager",
    "name" : "Ambrose Dickinson",
    "email" : "joyce.price@gmail.com"
  }, {
    "role" : "Developer",
    "name" : "Idalia Frami DDS",
    "email" : "malcom.hahn@hotmail.com"
  }, {
    "role" : "Lead DevOps",
    "name" : "Catarina Ullrich",
    "email" : "edmundo.bode@yahoo.com"
  }, {
    "role" : "Team Lead",
    "name" : "Jan Bednar Sr.",
    "email" : "blythe.heaney@gmail.com"
  }, {
    "role" : "Lead Developer",
    "name" : "Marianela Jerde",
    "email" : "mary.bashirian@gmail.com"
  } ]
```

One can join [] operators:

```julia

teams[0]["name"]
##=> "New Hampshire birds"

teams[0]["name"][2]
##=> "w"
```

Missing keys/indices result in `NIL`

```
teams[0]["kuku"]
##=> NIL

teams[1000]
##=> NIL
```

Subscribing missing values returns NIL as well

```
teams[1000]["name"]
##=> NIL
```

When there is no index specified the operator works as an iterator,
that is it applies all the following operations on all the values:

```
teams[]["name"]
##=> [ "New Hampshire birds", "Idaho birds" ]

teams[]["name"][]
##=> [ [ "N", "e", "w", " ", "H", "a", "m", "p", "s", "h", "i", "r", "e", " ", "b", "i", "r", "d", "s" ], [ "I", "d", "a", "h", "o", " ", "b", "i", "r", "d", "s" ] ]
```

### The `.` (dot) operator


The `.` (dot) operator as well allows to look up nested objects:
```
teams[0].name
##=> "New Hampshire birds"

teams[0].members[0].name
##=> "Luke Hauck"

```

but it works somewhat differently:
1. The keys aresSymbols and not expressions, i.e. the components are not evaluated
2. It does not support keys that are not valid symbols, that is they must start with a letter and not contain funny characters [TBD: elaborate]


### The Universal Lookup Function `get_in`

The `get_in()` function works as sequence of '[]' and additionally allows to specify default value instead of null, that is it allows
to differenciate between NIL values and NILs that result from missing keys. 

```julia

get_in(teams, list(0,"members",1,"role"),"Missing!")
##=> "Project Manager"

get_in(teams, list(0,"members",1000,"role"),"Missing!")
##=> "Missing!"


```

Empty key sequence will return the target object itself:

```
get_in("foo", list(),"Missing!")
##=> "foo"
```



## Examples for OPSIT-DSL Expressions

The DSL is based on evaluation of expressions in contexts. Contexts, which is essentially a collection 
of variables, may be assotiated with objects like Orgservices, Organizations, etc.

### Examples for OrgService contexts


#### Get owner of an Orgservice.

```
owner
```

#### Get list of frameworks in use by the Orgservice

```
frameworks 
```

#### Get number of OrgServoce Teams 

```
length(teams)
```

#### Get list names of team names

```
teams[]["name"]
```

#### Check if project has `kubernetes` in its list of tags

```
"kubernetes" in tags
```

#### Find mattermost channels in the contact lists

```
contacts | search type  =~ "mattermost" 
```

#### Print email addrsees with descriptions from project contact list

```
contacts | fields email, description
```
#### Get number of Software Components with development versions (that is  < 1.0.0 according to the Semantic Versioning).

```
components | search version <= v"1.0.0"  | LENGTH()
```

#### Find teams that have less than 3 members

```
teams search length(members) <2
```

#### Check if Orgservice depends on software library of particular version

```
components SEARCH (dependencies SEARCH version <= v"3.2.2" and  name == "spring-web" )
```

### Examples for searches


### Get list of names of Orgservices that use the `angular` framework

```
ORGSERVICES()  | SEARCH   "angular" in frameworks  | []["name"]
```

#### Get list of Orgservices and Languages when languages is not java

```
ORGSERVICES()  | SEARCH   NOT ( language == "java") | fields name,language

```

#### Get list of notes for services with name that starts from `opsit`

```
NOTES() SEARCH serviceId in (ORGSERVICES() | SEARCH name =~ r"^opsit"  | []["id"])
```





