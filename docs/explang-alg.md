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





