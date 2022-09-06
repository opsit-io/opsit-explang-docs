Explang Goals and Features
==========================

Focus on support for Programming in the Small, friendliness to casual users of the language
-------------------------------------------------------------------------------------------

- Dynamic typing, implicit conversions to boolean and numeric values when required.
- Dynamic variables: allows for passing values as variables in the
  context and defining user functions without arguments.
- Lisp2 language: different namespaces for variables and functions, so
  there is no potential conflict between user-defined variables and
  built-in functions.
- Batteries included: contains rich set of utility functions for
  operating on collections, regexp and globbing support, etc.
- Support for both imperative and functional style programming.
- Has a rich set of features for defining function arguments (keyword
  args, rest args, optional args, etc) instead of functions overloading.
- Documentation mechanism for user functions and builtins.  

Pluggable parsers for language syntax
-------------------------------------

Explang comes with two parsers for LISP like languages:
- lisp - recursive parser that a sub-set of Common Lisp parser
  features.
- sexp - simple S-exp parser that is written imperatively (no depth
  limit because of JVM stack).

There is a parser with a Julia-like Algebraic syntax:
- [opsit-explang-alg-parser](https://github.com/opsit-io/opsit-explang-alg-parser)

Modularity and adaptability
---------------------------

Language features come in packages so language integrators may select
just the features that are needed for their use cases. For example, to
implement a calculator one may include only arithmetical operations
and variables.  For integrating webhooks one may allow conditionals,
declaration of functions but not loops or FFI for calling arbitrary
Java methods. 

The language strives to provide feature flags and configuration
parameters to allow configuration of language behavious, such as case
sensitivity, use of default values vs. exceptions on access to
undefined variables, etc.


Simplicity for integration in existing systems
----------------------------------------------

- Explang Core comes with minimum dependencies. 
- No data types of its own: Explang works with built-in Java data
  types: Strings, Numbers, Collections, arrays, Character sequences.
- Abstraction mechanisms to use same functions on different Java
  native types (such as Collections, arrays and character sequences).
- Ability to use Java Beans like objects without writing glue code in
  Java.
- Ability to add easily additional Java based functions and special
  forms to be called from Explang code.
- Explang source strives to be simple and understandable by Java
  programmers. There are currently no language features that defined
  in Explang itself.

