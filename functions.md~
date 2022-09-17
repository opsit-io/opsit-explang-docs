## EXPLANG built-in functions and forms reference

[TOC]

### `%`

Object % is a built-in function defined at class io.opsit.explang.Funcs$REMOP
Arguments: 
    [x, y]
Documentation: 
    Compute Remainder. Generalizations of the remainder function. When both operands are integer returns result of the remainder operation . If one of them is floating point returns result of 
	 number - truncate_to_zero (number / divisor) * divisor (same semantic as for the Java % operator.

-----

### `*`

Object * is a built-in function defined at class io.opsit.explang.Funcs$MULOP
Arguments: 
    [&REST, args]
Documentation: 
    Compute Product. Returns the product of it's arguments , performing any necessary type conversions in the process. If no numbers are supplied, 1 is returned.

-----

### `+`

Object + is a built-in function defined at class io.opsit.explang.Funcs$ADDOP
Arguments: 
    [&REST, args]
Documentation: 
    Compute Sum. Returns the sum of numeric values of it's arguments, performing any necessary type conversions in the process. If no numbers are supplied, 0 is returned.

-----

### `.`

Object . is a built-in function defined at class io.opsit.explang.Funcs$DOT
Arguments: 
    [object, &REST, call-args]
Documentation: 
    Call Java Object Method/Read FieldCall method of java object or read contend of object field. 

-----

### `.N`

Object .N is a built-in function defined at class io.opsit.explang.Funcs$DOTN
Arguments: 
    [class, &OPTIONAL, arglist, typeslist]
Documentation: 
    Return New Class Instance. Optional arglist and typeslist parameters specify parameters to be passed to cosnstructor and their types. When typelist not given it tries to find most narrowly matching constructor on the basis of types of the arguments in arglist. If typeslist is provided exactly matching constructor will be used.

-----

### `.S`

Object .S is a built-in function defined at class io.opsit.explang.Funcs$DOTS
Arguments: 
    [class, &REST, call-args]
Documentation: 
    Call Static Java Method/Read Static FieldCall method of java object or read contend of object field. 

-----

### `/`

Object / is a built-in function defined at class io.opsit.explang.Funcs$DIVOP
Arguments: 
    [&REST, args]
Documentation: 
    Performs Division or Reciprocation. If no denominators are supplied, the function / returns the reciprocal of number. If at least one denominator is supplied, the function / divides the numerator by all of the denominators and returns the resulting quotient. If each argument is either an integer or a ratio, and the result is not an integer, then it is a ratio. The function / performs necessary type conversions. 

-----

### `<`

Object < is a built-in function defined at class io.opsit.explang.Funcs$NUMLT
Arguments: 
    [x, &REST, args]
Documentation: 
    Less Than - Numeric Comparison. Returns True if all arguments are monotonically increasing order.  Returns True if only one argument is given

-----

### `<=`

Object <= is a built-in function defined at class io.opsit.explang.Funcs$NUMLE
Arguments: 
    [x, &REST, args]
Documentation: 
    Less or Equal - Numeric comparison. Returns True if all arguments are monotonically non-decreasing order.  Returns True if only one argument is given

-----

### `=`

Object = is a built-in function defined at class io.opsit.explang.Funcs$NUMEQ
Arguments: 
    [x, &REST, args]
Documentation: 
    Test numeric equality. Returns True if all arguments are numerically equal. Returns True if only one argument is given

-----

### `==`

Object == is a built-in function defined at class io.opsit.explang.Funcs$SEQUAL
Arguments: 
    [x, y]
Documentation: 
    Check Value Equality. Returns true if x equal to y according to call to Java method x.equals(y) or if both objects are NIL. If they are not, it  returns true if  thy are equal numerically or structurally.

-----

### `===`

Object === is a built-in function defined at class io.opsit.explang.Funcs$EQ
Arguments: 
    [x, y]
Documentation: 
    Check Object Equality. Objects identity check: returns true if Object x is same as Object y. Uses java operator == to check objects identity

-----

### `>`

Object > is a built-in function defined at class io.opsit.explang.Funcs$NUMGT
Arguments: 
    [x, &REST, args]
Documentation: 
    Greater Than - Numeric comparison. Returns True if all arguments are monotonically decreasing order.  Returns True if only one argument is given

-----

### `>=`

Object >= is a built-in function defined at class io.opsit.explang.Funcs$NUMGE
Arguments: 
    [x, &REST, args]
Documentation: 
    Greater or Equal - Numeric comparison. Returns True if all arguments are monotonically non-increasing order. Returns True if only one argument is given

-----

### `@_>`

Object @_> is a built-in form defined at class io.opsit.explang.Compiler$TH_PIPE
Arguments: 
    args
Documentation: 
    Threading form on &PIPE or first argument

-----

### `AND`

Object AND is a built-in function defined at class io.opsit.explang.Funcs$AND
Arguments: 
    [&LAZY, &REST, forms]
Documentation: 
    Logical AND. Function AND lazily evaluates each argument form, one at a time from left to right. As soon as any form evaluates to NIL, AND returns NIL without evaluating the remaining forms. If all forms but the last evaluate to true values, AND returns the results produced by evaluating the last form. If no forms are supplied, (AND) returns true.

-----

### `APPEND`

Object APPEND is a built-in function defined at class io.opsit.explang.Funcs$APPEND
Arguments: 
    [&REST, sequences]
Documentation: 
    Concatenate sequences (non-destructive). append returns a new sequence that is the concatenation of the elements of the arguments. All the argument remain unchanged. The resulting sequence is of the same type as the first argument. In no arguments were given an empty list is returned. If target sequence is an array necessary coercions will be performed automatically.

-----

### `APPEND!`

Object APPEND! is a built-in function defined at class io.opsit.explang.Funcs$NAPPEND
Arguments: 
    [&REST, sequences]
Documentation: 
    Concatenate sequences (destructive). Adds to the first given sequence (target sequence) all the elements ofall of the following sequences and return the target sequence.  If no sequences were given an empty list will be returned. Target sequence must be extendable, that means that objects like Arrays or String cannot be target of this operation

-----

### `APPLY`

Object APPLY is a built-in function defined at class io.opsit.explang.Funcs$APPLY
Arguments: 
    [f, &PIPE, &REST, arguments]
Documentation: 
    Apply function to arguments. arguments must be a spreadable list designator, i.e. if the last argument is a list, it contents will be appended to the list of arguments.

-----

### `AREF`

Object AREF is a built-in function defined at class io.opsit.explang.Funcs$AREF
Arguments: 
    [array, index]
Documentation: 
    Get Array element value. Return array element at specified index. Throws ArrayOutOfBoundsException if index is invalid

-----

### `ASET`

Object ASET is a built-in function defined at class io.opsit.explang.Funcs$ASET
Arguments: 
    [array, index, object]
Documentation: 
    Sat array element value. Set value of array element at index to object. If java array is typed (i.e. not array of java.lang.Objects) and object type does not match this function will attempt to perform necessary coercion operations. The coercions work in the same way as INT, FLOAT, STRING and rest of the built-in coercion functions.

-----

### `ASSOC`

Object ASSOC is a built-in function defined at class io.opsit.explang.Funcs$ASSOC
Arguments: 
    map {key val}+
Documentation: 
    Associates value with key in an map structure. 
Return new instance of the structure, the original is left unchanged.

-----

### `ASSOC!`

Object ASSOC! is a built-in function defined at class io.opsit.explang.Funcs$NASSOC
Arguments: 
    map {key val}+
Documentation: 
    Associates value with key in an map structure. 
Modifies the object and returns it as the result.

-----

### `AS_>`

Object AS_> is a built-in form defined at class io.opsit.explang.Compiler$TH_AS
Arguments: 
    args
Documentation: 
    Threading form on named argument

-----

### `BACKTRACE`

Object BACKTRACE is a built-in function defined at class io.opsit.explang.Funcs$BACKTRACE
Arguments: 
    []
Documentation: 
    Return callstack backtrace. Returns string representation of current stack frame.

-----

### `BEAN`

Object BEAN is a built-in function defined at class io.opsit.explang.Funcs$BEAN
Arguments: 
    [object, &OPTIONAL, prefix, suffix]
Documentation: 
    Convert Java Bean to a Map. Returns a Map based on getters in the passed java object. Accepts optional prefix and suffics arguments that are used to modify the generated keys.

-----

### `BOOL`

Object BOOL is a built-in function defined at class io.opsit.explang.Funcs$BOOL
Arguments: 
    [value]
Documentation: 
    Coerce Value to Boolean. Value may be a Character, a Number, a Boolean, a Byte, a String, any object or NIL:
* Boolean value will be returned as is
* NIL is false
* Character    is false.
* any Number which is equal to zero is false
* an empty String is false
* An empty collection is false 
* Any other object is true.


-----

### `BOUNDP`

Object BOUNDP is a built-in function defined at class io.opsit.explang.Funcs$BOUNDP
Arguments: 
    [&REST, symbols]
Documentation: 
    Check if Symbols are Bound. Returns True if all the arguments are bound symbols or names of bound symbols; otherwise, returns False.

-----

### `BYTE`

Object BYTE is a built-in function defined at class io.opsit.explang.Funcs$BYTE
Arguments: 
    [value]
Documentation: 
    Coerce Value to Byte. Value may be a Number, String, any object or NIL.String will be parsed as number using same rules as numeric literals. The floating point values will be truncated.

-----

### `CHAR`

Object CHAR is a built-in function defined at class io.opsit.explang.Funcs$CHAR
Arguments: 
    [value]
Documentation: 
    Coerce Value to Character. Value may be a Character, a Number, a Boolean, a Byte, a Stringor NIL:
* Character value will be returned as is.
* NIL will be converted to unicode value # .
* a Boolean True value will be returned as character 'T', False as ' '.
* a Number (other than Byte) will be truncated to short (if needed) and the character at corresponding Unicode code unit will be returned.
* a Byte value will be treated as unsigned integer value and processed as described above.
* a String will be parsed as number using same rules as numeric literals and the resulting value will be used as described above. Conversion to number may fail.
* Any other object will cause conversion error.


-----

### `CLASS`

Object CLASS is a built-in function defined at class io.opsit.explang.Funcs$CLASS
Arguments: 
    [class-spec]
Documentation: 
    Return Class by Class Name.Return class object according to it's fully qualified class name. class-spec may be string, symbol or any object,which string representation will be used

-----

### `COND`

Object COND is a built-in form defined at class io.opsit.explang.Compiler$COND
Arguments: 
    {test-form form*}*
Documentation: 
    Conditional switch construct. COND allows the execution of forms to be dependent on test-form.
Test-forms are evaluated one at a time in the order in
which they are given in the argument list until a
test-form is found that evaluates to true.  If there
are no forms in that clause, the value of the test-form
is returned by the COND form.  Otherwise, the forms
associated with this test-form are evaluated in order,
left to right and the value returned by the last form
is returned by the COND form.  Once one test-form has
yielded true, no additional test-forms are
evaluated. If no test-form yields true, nil is
returned.

-----

### `CONS`

Object CONS is a built-in function defined at class io.opsit.explang.Funcs$CONS
Arguments: 
    [object-1, object-2]
Documentation: 
    Prepend element to a sequence.

-----

### `DEFUN`

Object DEFUN is a built-in form defined at class io.opsit.explang.Compiler$DEFUN
Arguments: 
    args
Documentation: 
    Define named function

-----

### `DESCRIBE_FUNCTION`

Object DESCRIBE_FUNCTION is a built-in function defined at class io.opsit.explang.Funcs$DESCRIBE_FUNCTION
Arguments: 
    [function]
Documentation: 
    Describe function. Return textual description of given function or built-in form. function is a symbol or function name or a lambda

-----

### `DLET`

Object DLET is a built-in form defined at class io.opsit.explang.Compiler$DLET
Arguments: 
    args
Documentation: 
    Destructuring LET construct.

-----

### `DOCUMENTATION`

Object DOCUMENTATION is a built-in function defined at class io.opsit.explang.Funcs$DOCUMENTATION
Arguments: 
    [function-name]
Documentation: 
    Get Function Docstring. Return documentation string of given function or built-in form. function is a symbol or function name or a lambda

-----

### `DOUBLE`

Object DOUBLE is a built-in function defined at class io.opsit.explang.Funcs$DOUBLE
Arguments: 
    [value]
Documentation: 
    Coerce Value to Double. Value may be a Number, String, any object or NIL.String will be parsed as number using same rules as numeric literals. The floating point values will be truncated.

-----

### `DWIM_FIELDS`

Object DWIM_FIELDS is a built-in function defined at class io.opsit.explang.Funcs$DWIM_FIELDS
Arguments: 
    [object, keyseq]
Documentation: 
    Returns a map containing only those entries in map whose key is in keys. 

-----

### `DWIM_MATCHES`

Object DWIM_MATCHES is a built-in function defined at class io.opsit.explang.DWIM$DWIM_MATCHES
Arguments: 
    {object pattern}
Documentation: 
    Perform DWIM find operation. When pattern is an Regexp tries to find the regexp in String Representation of object.
  When pattern is a String it tries to find its occurences in the String Representation of object.
 When pattern is a Number then numeric equality check is performed. 
 When pattern is any other object the equality test is performed. 
 If there were matches the function returns list of matches. 
If there is no match an empty list is returned.

-----

### `DWIM_SEARCH`

Object DWIM_SEARCH is a built-in form defined at class io.opsit.explang.Compiler$DWIM_SEARCH
Arguments: 
    [sequence, test]
Documentation: 
    Perform DWIM search of an item in a sequence of objects. 

-----

### `EQUAL`

Object EQUAL is a built-in function defined at class io.opsit.explang.Funcs$EQUAL
Arguments: 
    [x, y]
Documentation: 
    Check Object Equality. Returns true if x equal to y according to call to Java method x.equals(y) or if both objects are NIL.

-----

### `EVAL`

Object EVAL is a built-in function defined at class io.opsit.explang.Funcs$EVAL
Arguments: 
    [form]
Documentation: 
    Evaluate a Parsed Expression. Evaluates parsed form in the current dynamic context and return result of evaluation'

-----

### `EXP`

Object EXP is a built-in function defined at class io.opsit.explang.Funcs$EXP
Arguments: 
    [x, &OPTIONAL, base]
Documentation: 
    Perform exponentiation. If base is not given it returns e raised to power x. Returns a Double value.

-----

### `FILTER`

Object FILTER is a built-in function defined at class io.opsit.explang.Funcs$FILTER
Arguments: 
    [test, &PIPE, sequence]
Documentation: 
    Filter operation. test is a function of one argument that returns boolean, seq is input sequence. Return a sequence from which the elements that do not satisfy the test have been removed.

-----

### `FIRST`

Object FIRST is a built-in function defined at class io.opsit.explang.Funcs$FIRST
Arguments: 
    [sequence]
Documentation: 
    Returns the first element of the sequence. Returns NIL when sequence is NIL or empty

-----

### `FLOAT`

Object FLOAT is a built-in function defined at class io.opsit.explang.Funcs$FLOAT
Arguments: 
    [value]
Documentation: 
    Coerce Value to Float. Value may be a Number, String, any object or NIL.String will be parsed as number using same rules as numeric literals. The floating point values will be truncated.

-----

### `FOREACH`

Object FOREACH is a built-in form defined at class io.opsit.explang.Compiler$FOREACH
Arguments: 
    [(, VAR, SEQUENCE, &OPTIONAL, RESULT, ), &REST, body]
Documentation: 
    Foreach Loop over a sequence. 
Evaluate body with VAR bound to each element from SEQUENCE, in turn.
Then evaluate RESULT to get return value, default NIL.

-----

### `FORMAT`

Object FORMAT is a built-in function defined at class io.opsit.explang.Funcs$FORMAT
Arguments: 
    [format, &REST, values]
Documentation: 
    Format String. Returns a formatted string using the specified format string (in the format of java.util.Formatter) and arguments. Arguments referenced by the format specifiers in the format string. If there are more arguments than format specifiers, the extra arguments are ignored. Throws IllegalFormatException - If a format string contains an illegal syntax, a format specifier that is incompatible with the given arguments, insufficient arguments given the format string, or other illegal conditions.

-----

### `FUNCALL`

Object FUNCALL is a built-in function defined at class io.opsit.explang.Funcs$FUNCALL
Arguments: 
    [function, &PIPE, &REST, arguments]
Documentation: 
    Apply Arguments to a Function. Function must be a function object

-----

### `FUNCTION`

Object FUNCTION is a built-in form defined at class io.opsit.explang.Compiler$FUNCTION
Arguments: 
    args
Documentation: 
    Get Function Given it's symbol.

-----

### `FUNCTIONP`

Object FUNCTIONP is a built-in function defined at class io.opsit.explang.Funcs$FUNCTIONP
Arguments: 
    [object]
Documentation: 
    Check if object is a function. Returns true if object is a function (built-in or user defined); otherwise, returns false. A function is an object that represents code to be executed when an appropriate number of arguments is supplied. A function can be directly invoked by using it as the first argument to funcall, apply.

-----

### `FUNCTIONS_NAMES`

Object FUNCTIONS_NAMES is a built-in function defined at class io.opsit.explang.Funcs$FUNCTIONS_NAMES
Arguments: 
    [&REST, names]
Documentation: 
    Get list of names of defined functions. If names are given use them as filter expressions:  only those which match at least one of filter expressions will be returned. Filters may be strings (substring match) or regular expressions (java.util.regex.Pattern objects).

-----

### `GET`

Object GET is a built-in function defined at class io.opsit.explang.Funcs$GET
Arguments: 
    [structure, key, &OPTIONAL, not-found]
Documentation: 
    Returns the value from an associative structure. 
Return value from an associative structure struct, 
 Returns NIL if the key is not present, or the not-found value if supplied.

-----

### `GETPROP`

Object GETPROP is a built-in function defined at class io.opsit.explang.Funcs$GETPROP
Arguments: 
    [symbol, property-key]
Documentation: 
    Get Variable Property. Returns value of a property from variable property map

-----

### `GETPROPS`

Object GETPROPS is a built-in function defined at class io.opsit.explang.Funcs$GETPROPS
Arguments: 
    [symbol]
Documentation: 
    Get Properties Map for a Variable.

-----

### `GET_IN`

Object GET_IN is a built-in function defined at class io.opsit.explang.Funcs$GET_IN
Arguments: 
    [structure, ks, &OPTIONAL, not-found]
Documentation: 
    Returns the value from an associative structure. 
Return value from an associative structure struct, 
where ks is a sequence of keys. Returns NIL if the key
 is not present, or the not-found value if supplied.

-----

### `HASHMAP`

Object HASHMAP is a built-in function defined at class io.opsit.explang.Funcs$HASHMAP
Arguments: 
    [&REST, pairs]
Documentation: 
    Create a HashMap. Returns new HashMap filled with given keys and values. Throws InvalidParametersException if non-even number of arguments is given.

-----

### `HASHSET`

Object HASHSET is a built-in function defined at class io.opsit.explang.Funcs$HASHSET
Arguments: 
    [&REST, args]
Documentation: 
    Create a HashSet. Returns a set containing the supplied objects. 

-----

### `IF`

Object IF is a built-in form defined at class io.opsit.explang.Compiler$IF
Arguments: 
    args
Documentation: 
    If-else conditional construct.

-----

### `IN`

Object IN is a built-in function defined at class io.opsit.explang.Funcs$IN
Arguments: 
    [elt, &PIPE, sequence]
Documentation: 
    Check if an element is contained in a sequence. 

-----

### `INT`

Object INT is a built-in function defined at class io.opsit.explang.Funcs$INT
Arguments: 
    [value]
Documentation: 
    Coerce value to Integer. Value may be a Number, String, any object or NIL.String will be parsed as number using same rules as numeric literals. The floating point value will be truncated.

-----

### `LAMBDA`

Object LAMBDA is a built-in form defined at class io.opsit.explang.Compiler$LAMBDA
Arguments: 
    args
Documentation: 
    Define anonymous function

-----

### `LENGTH`

Object LENGTH is a built-in function defined at class io.opsit.explang.Funcs$LENGTH
Arguments: 
    [sequence]
Documentation: 
    Return length of a sequence. Parameter may be any supported sequence (collection, array, character sequence) or NIL (0 will be returned).

-----

### `LET`

Object LET is a built-in form defined at class io.opsit.explang.Compiler$LET
Arguments: 
    args
Documentation: 
    Evaluate code with given var. bindings.

-----

### `LIST`

Object LIST is a built-in function defined at class io.opsit.explang.Funcs$LIST
Arguments: 
    [&REST, args]
Documentation: 
    Create a list. Returns a list containing the supplied objects. 

-----

### `LOAD`

Object LOAD is a built-in function defined at class io.opsit.explang.Funcs$LOAD
Arguments: 
    [file-spec]
Documentation: 
    Execute program from a file/stream. Sequentially executes each form it encounters in the input file/or stream named by resource-spec. Returns exception if input could not be read or there were exceptions while compiling or executing forms an exception will be raised. file-spec may be a java.io.File object, file path as String or opened InputStream.

-----

### `LOADR`

Object LOADR is a built-in function defined at class io.opsit.explang.Funcs$LOADR
Arguments: 
    [resource-spec]
Documentation: 
    Execute program from Java resource. Sequentially executes each form it encounters in the java resource file named by resource-spec. Returns exception if file could not be read or there were exceptions while compiling or executing forms an exception will be raised.

-----

### `LOG`

Object LOG is a built-in function defined at class io.opsit.explang.Funcs$LOG
Arguments: 
    [x, &OPTIONAL, base]
Documentation: 
    Computes logarithm. If base is not given it computes natural logarithm. Returns a Double value.

-----

### `LONG`

Object LONG is a built-in function defined at class io.opsit.explang.Funcs$LONG
Arguments: 
    [value]
Documentation: 
    Coerce Value to Long. Value may be a Number, String, any object or NIL.String will be parsed as number using same rules as numeric literals. The floating point values will be truncated.

-----

### `MAKE_ARRAY`

Object MAKE_ARRAY is a built-in function defined at class io.opsit.explang.Funcs$MAKE_ARRAY
Arguments: 
    [size, &KEY, element-type]
Documentation: 
    Ceate an Array. Creates array of objects of specified size. Optional :element-type argument specifies type of array elements. The default is java.lang.Object

-----

### `MAKUNBOUND`

Object MAKUNBOUND is a built-in function defined at class io.opsit.explang.Funcs$MAKUNBOUND
Arguments: 
    [symbol]
Documentation: 
    Unbind variable given by symbol. Always returns symbol.

-----

### `MAP`

Object MAP is a built-in function defined at class io.opsit.explang.Funcs$MAP
Arguments: 
    [func, &PIPE, &REST, lists]
Documentation: 
    Apply function on elements of collections. Returns a sequence consisting of the result of applying func to the set of first items of each list, followed by applying func to the set of second items in each list, until any one of the lists is exhausted.  Any remaining items in other lists are ignored. Function func should accept number arguments that is equal to number of lists.

-----

### `MAPPROD`

Object MAPPROD is a built-in function defined at class io.opsit.explang.Funcs$MAPPROD
Arguments: 
    [f, &PIPE, &REST, lists]
Documentation: 
    Apply function on cartesioan product of lists. Returns a sequence consisting of the result of applying func to the cartesian product of the lists. Function func should accept number arguments that is equal to number of lists.

-----

### `MAX`

Object MAX is a built-in function defined at class io.opsit.explang.Funcs$MAXOP
Arguments: 
    [x, &REST, args]
Documentation: 
    Find maximum. Returns the maximum of numeric values of it's arguments, performing any necessary type conversions in the process. 

-----

### `MIN`

Object MIN is a built-in function defined at class io.opsit.explang.Funcs$MINOP
Arguments: 
    [x, &REST, args]
Documentation: 
    Find minimum. Returns the maximum of numeric values of it's arguments, performing any necessary type conversions in the process. 

-----

### `MOD`

Object MOD is a built-in function defined at class io.opsit.explang.Funcs$MODOP
Arguments: 
    [number, divisor]
Documentation: 
    Compute Modulus. Generalizations of the modulus function. When both operands are integer returns result of the modulus operation. If one of them is floating point returns result of 
	 number - ⌊ (number / divisor) ⌋ * divisor 

-----

### `NEW_CTX`

Object NEW_CTX is a built-in function defined at class io.opsit.explang.Funcs$NEW_CTX
Arguments: 
    []
Documentation: 
    Create New Empty Context

-----

### `NEW_THREAD`

Object NEW_THREAD is a built-in function defined at class io.opsit.explang.Funcs$NEW_THREAD
Arguments: 
    [fn, &OPTIONAL, name]
Documentation: 
    Create new Java thread. Creates new Java thread and prepare it for execution of given function fn.fn must not require parameters for it's execution. The created thread is not started.

-----

### `NOT`

Object NOT is a built-in function defined at class io.opsit.explang.Funcs$NOT
Arguments: 
    [x]
Documentation: 
    Logical Negation. Returns True if x has false logical value; otherwise, returns False.Parameter x can be any object. Only NIL, the empty list (), the empty String "", 0  and FALSE have false logical value. All other objects have true logical value

-----

### `NTH`

Object NTH is a built-in function defined at class io.opsit.explang.Funcs$NTH
Arguments: 
    [n, &PIPE, sequence]
Documentation: 
    Locates the nth element of a sequence. n may be any non-negative number. Returns NIL when sequence is NIL or n is out of bounds

-----

### `OR`

Object OR is a built-in function defined at class io.opsit.explang.Funcs$OR
Arguments: 
    [&LAZY, &REST, args]
Documentation: 
    Logical OR. Function OR lazily evaluates each form, one at a time, from left to right. The evaluation of all forms terminates when a form evaluates to true (i.e., something other than nil) and OR immediately returns that value without evaluating the remaining forms.

-----

### `PRINT`

Object PRINT is a built-in function defined at class io.opsit.explang.Funcs$PRINT
Arguments: 
    [&REST, args]
Documentation: 
    Print Arguments on standard output.

-----

### `PROGN`

Object PROGN is a built-in form defined at class io.opsit.explang.Compiler$PROGN
Arguments: 
    args
Documentation: 
    Evaluate sequence of expressions.

-----

### `QUOTE`

Object QUOTE is a built-in form defined at class io.opsit.explang.Compiler$QUOTE
Arguments: 
    args
Documentation: 
    Return its argument without evaluation.

-----

### `RANDOM`

Object RANDOM is a built-in function defined at class io.opsit.explang.Funcs$RANDOM
Arguments: 
    [limit]
Documentation: 
    Produce Pseudo-Random Number. Returns a pseudo-random number that is a non-negative number less than limit and of the same numeric type as limit. Implemented uding Java Math.random()

-----

### `RANGE`

Object RANGE is a built-in function defined at class io.opsit.explang.Funcs$RANGE
Arguments: 
    [start, stop, &OPTIONAL, step]
Documentation: 
    Return sequence of numbers. Returns sequence of numbers  from start to stop (inclusively) with .

-----

### `READ_FROM_STRING`

Object READ_FROM_STRING is a built-in function defined at class io.opsit.explang.Funcs$READ_FROM_STRING
Arguments: 
    [string]
Documentation: 
    Parse expression from string. Reads expression from string using default parser. Returns expression or NIL if no expression has been read

-----

### `REDUCE`

Object REDUCE is a built-in function defined at class io.opsit.explang.Funcs$REDUCE
Arguments: 
    [func, &OPTIONAL, val, &PIPE, &REQUIRED, seq]
Documentation: 
    Reduce operation.
 func is a function of 2 arguments, value - optional starting value, seq is input sequence.
When val is not given:  apply func to the first 2 items in the seq, then to the result and 3rd, etc. If seq contains no items, func must accept no arguments, return (func).If seq has 1 item, return it without calling func;
If value is supplied, apply func on value and the first seq element, then on the result and the second element, etc. If there is no elements - return val;

-----

### `REM`

Object REM is a built-in function defined at class io.opsit.explang.Funcs$REMOP
Arguments: 
    [x, y]
Documentation: 
    Compute Remainder. Generalizations of the remainder function. When both operands are integer returns result of the remainder operation . If one of them is floating point returns result of 
	 number - truncate_to_zero (number / divisor) * divisor (same semantic as for the Java % operator.

-----

### `REST`

Object REST is a built-in function defined at class io.opsit.explang.Funcs$REST
Arguments: 
    [sequence]
Documentation: 
    Return 2nd and further elements of sqeuence.

-----

### `REVERSE`

Object REVERSE is a built-in function defined at class io.opsit.explang.Funcs$REVERSE
Arguments: 
    [sequence]
Documentation: 
    Reverse a sequence (non-destructive).

-----

### `REVERSE!`

Object REVERSE! is a built-in function defined at class io.opsit.explang.Funcs$NREVERSE
Arguments: 
    [sequence]
Documentation: 
    Reverse a sequence (destructive).

-----

### `RE_FIND`

Object RE_FIND is a built-in function defined at class io.opsit.explang.Funcs$RE_FIND
Arguments: 
    {pattern schar-seq | matcher}
Documentation: 
    Perform Regexp Find. When called With two arguments creates java.util.regex.Matcher using pattern and char-seq.
  When called with one arguments it uses given Matcher. 
 Returns the next ,match, if any, of string to pattern, using Matcher.find(). 
 if no groups were defined it returns the matched string.
 If groups were defined it returns a list consisting of the full match and matched groups
 If there is no match NIL is returned

-----

### `RE_GLOB`

Object RE_GLOB is a built-in function defined at class io.opsit.explang.Funcs$RE_GLOB
Arguments: 
    [pattern]
Documentation: 
    Compile a Globbing Pattern. On success returns a java.util.regex.Pattern object. On error raises exception.

-----

### `RE_GROUPS`

Object RE_GROUPS is a built-in function defined at class io.opsit.explang.Funcs$RE_GROUPS
Arguments: 
    [matcher]
Documentation: 
    Return Groups for a Regexp Match. Returns the groups from the most recent match/find.
If there are no nested groups, returns a string of the entire
match. If there are nested groups, returns a list of the groups,
the first element being the entire match.

-----

### `RE_MATCHER`

Object RE_MATCHER is a built-in function defined at class io.opsit.explang.Funcs$RE_MATCHER
Arguments: 
    [pattern, &PIPE, char-seq]
Documentation: 
    Return Regexp Matcher. Returns an instance of java.util.regex.Matcher, for use, e.g. in RE-FIND.

-----

### `RE_MATCHES`

Object RE_MATCHES is a built-in function defined at class io.opsit.explang.Funcs$RE_MATCHES
Arguments: 
    {pattern schar-seq | matcher}
Documentation: 
    Perform regexp match. When called With two arguments created java.util.regex.Matcher using pattern and char-seq.
  When called with one arguments it uses given Matcher. 
 Returns the match, if any, of string to pattern, using Matcher.matches(). 
 if no groups were defined it returns the matched string.
 If groups were defined it returns a list consisting of the full match and matched groups
 If there is no match NIL is returned

-----

### `RE_PATTERN`

Object RE_PATTERN is a built-in function defined at class io.opsit.explang.Funcs$RE_PATTERN
Arguments: 
    [pattern]
Documentation: 
    Compile A Regexp Pattern. On success returns a java.util.regex.Pattern objec. On error raises exception.

-----

### `RE_SEQ`

Object RE_SEQ is a built-in function defined at class io.opsit.explang.Funcs$RE_SEQ
Arguments: 
    {pattern schar-seq | matcher}
Documentation: 
    Return Results of Regexp Find as a Lazy Sequence. When called With two arguments created java.util.regex.Matcher using pattern and char-seq.
  Returns lazy iterable sequence (instance of Iterable) of matches of string to pattern, using Matcher.find(). 
 When called with one arguments it uses given Matcher. 
 if no groups were defined the elements of the sequence are the matched string.
 If groups were defined it returns a list consisting of the full match and matched groups
 If there is no match empty sequence is returned

-----

### `SELECT_KEYS`

Object SELECT_KEYS is a built-in function defined at class io.opsit.explang.Funcs$SELECT_KEYS
Arguments: 
    [object, keyseq]
Documentation: 
    Returns a map containing only those entries in map whose key is in keys. 

-----

### `SEQ`

Object SEQ is a built-in function defined at class io.opsit.explang.Funcs$SEQ
Arguments: 
    [object]
Documentation: 
    Coerce object into a sequence.

-----

### `SEQUENCEP`

Object SEQUENCEP is a built-in function defined at class io.opsit.explang.Funcs$SEQUENCEP
Arguments: 
    [object]
Documentation: 
    Check if an object is a sequence.

-----

### `SET`

Object SET is a built-in function defined at class io.opsit.explang.Funcs$SET
Arguments: 
    symbol value { level | uplevel }?
Documentation: 
    Change variable value in specified context. Set changes the contents of variable symbol in the dynamic context to the given value. If uplevel is set the value will be set in the uplevel-ths previous context. If level is set the value will be changed in the level-th context from the level0 

-----

### `SETPROP`

Object SETPROP is a built-in function defined at class io.opsit.explang.Funcs$SETPROP
Arguments: 
    [symbol, property-key, property-value]
Documentation: 
    Set variable property. Sets property value in variable property map

-----

### `SETPROPS`

Object SETPROPS is a built-in function defined at class io.opsit.explang.Funcs$SETPROPS
Arguments: 
    [symbol, properties-map]
Documentation: 
    Set Properties Map for a Variable

-----

### `SETQ`

Object SETQ is a built-in form defined at class io.opsit.explang.Compiler$SETQ
Arguments: 
    {var form}*
Documentation: 
    Variable assignment, glocal if not exists. If variable is already assigned it's value will be replaced by result of form evaluation. If not new global binding will be created in the global scope
var - a symbol naming a variable.
form - an expression, which evaluation result will be assigned to var
Returns: value of the last form, or nil if no pairs were supplied.

-----

### `SETV`

Object SETV is a built-in form defined at class io.opsit.explang.Compiler$SETV
Arguments: 
    {var form}*
Documentation: 
    Varianle assignmentm, global if not exists. If variable is already assigned it's value will be replaced by result of form evaluation. If not new global binding will be created in the global scope
var - a symbol naming a variable.
form - an expression, which evaluation result will be assigned to var
Returns: value of the last form, or nil if no pairs were supplied.

-----

### `SHORT`

Object SHORT is a built-in function defined at class io.opsit.explang.Funcs$SHORT
Arguments: 
    [value]
Documentation: 
    Coerce Value to Short. Value may be a Number, String, any object or NIL.String will be parsed as number using same rules as numeric literals. The floating point values will be truncated.

-----

### `SIGNUM`

Object SIGNUM is a built-in function defined at class io.opsit.explang.Funcs$SIGNUM
Arguments: 
    [x]
Documentation: 
    Return Number Sign. Determines a numerical value that indicates whether number is negative, zero, or positive. Returns one of -1, 0, or 1 according to whether number is negative, zero, or positive. The type of the result is of the same numeric type as x

-----

### `SORT`

Object SORT is a built-in function defined at class io.opsit.explang.Funcs$SORT
Arguments: 
    [&OPTIONAL, f, &PIPE, &REQUIRED, sequence]
Documentation: 
    Sort a sequence (non destructively).

-----

### `SORT!`

Object SORT! is a built-in function defined at class io.opsit.explang.Funcs$NSORT
Arguments: 
    [&OPTIONAL, f, &PIPE, &REQUIRED, sequence]
Documentation: 
    Sort a sequence (destructively).

-----

### `SQRT`

Object SQRT is a built-in function defined at class io.opsit.explang.Funcs$SQRT
Arguments: 
    [x]
Documentation: 
    Computes square root of the argument. Returns double value.

-----

### `STR`

Object STR is a built-in function defined at class io.opsit.explang.Funcs$STR
Arguments: 
    [&REST, values]
Documentation: 
    Concatenate Strings. Returns concatenation of string representationx of the function arguments

-----

### `STRING`

Object STRING is a built-in function defined at class io.opsit.explang.Funcs$STRING
Arguments: 
    [value]
Documentation: 
    Coerce Value to String. Value may be any object or NIL: NIL is converted to String "NIL", any other object converted using it's toString() method

-----

### `SUBSEQ`

Object SUBSEQ is a built-in function defined at class io.opsit.explang.Funcs$SUBSEQ
Arguments: 
    [sequence, start, &OPTIONAL, end]
Documentation: 
    Return subsequnce of a sequence. subseq creates a sequence that is a copy of the subsequence of sequence bounded by start and end. Start specifies an offset into the original sequence and marks the beginning position of the subsequence. end marks the position following the last element of the subsequence. subseq always allocates a new sequence for a result; it never shares storage with an old sequence. The result subsequence is of the same kind as sequence.

-----

### `SYMBOL`

Object SYMBOL is a built-in function defined at class io.opsit.explang.Funcs$SYMBOL
Arguments: 
    [symbol-name]
Documentation: 
    Makes new Symbol for a string

-----

### `SYMBOL_FUNCTION`

Object SYMBOL_FUNCTION is a built-in function defined at class io.opsit.explang.Funcs$SYMBOL_FUNCTION
Arguments: 
    [symbol]
Documentation: 
    Returns function bound to given symbol. If no function bound raises an error. The returned object may be a built-in function, compiled function or built-in special form.

-----

### `TAKE`

Object TAKE is a built-in function defined at class io.opsit.explang.Funcs$TAKE
Arguments: 
    [n, &PIPE, seq]
Documentation: 
    Return  first n elements of a sequence. take creates new sequence with first n elements of seq. If n is bigger than length of the sequence all the elementsare returned. The result subsequence is of the same kind as sequence.

-----

### `THROW`

Object THROW is a built-in function defined at class io.opsit.explang.Funcs$THROW
Arguments: 
    [exception]
Documentation: 
    Throw Java Exception. The exception may be a java Throwable object or String. In the latter case a new ExecutionException with given message will be created and thrown.

-----

### `TRY`

Object TRY is a built-in form defined at class io.opsit.explang.Compiler$TRY
Arguments: 
    args
Documentation: 
    Try-Catch-Final construction.

-----

### `TYPEP`

Object TYPEP is a built-in function defined at class io.opsit.explang.Funcs$TYPEP
Arguments: 
    [object, type-specifier]
Documentation: 
    Check if Object is of Specified Type. Returns True if object is of the specified type. Type specifier may be a Class object or string or symbol which is a valid type-specifier.

-----

### `TYPE_OF`

Object TYPE_OF is a built-in function defined at class io.opsit.explang.Funcs$TYPE_OF
Arguments: 
    [object]
Documentation: 
    Return Object Type. Returns type (as class) of the given object. For NIL argument return NIL.

-----

### `VERSION`

Object VERSION is a built-in function defined at class io.opsit.explang.Funcs$VERSION
Arguments: 
    [spec]
Documentation: 
    Create Version from text specification. 

-----

### `WHILE`

Object WHILE is a built-in form defined at class io.opsit.explang.Compiler$WHILE
Arguments: 
    args
Documentation: 
    While loop construction. Execute sequnce of expressions while the consition is true

-----

### `WITH_BINDINGS`

Object WITH_BINDINGS is a built-in form defined at class io.opsit.explang.Compiler$WITH_BINDINGS
Arguments: 
    args
Documentation: 
    Evaluate code with bindings from a Java Map.

-----

### `WITH_CTX`

Object WITH_CTX is a built-in form defined at class io.opsit.explang.Compiler$WITH_CTX
Arguments: 
    args
Documentation: 
    Evaluate code in given context.

-----

### `_`

Object _ is a built-in function defined at class io.opsit.explang.Funcs$SUBOP
Arguments: 
    [&REST, args]
Documentation: 
    Performs subtraction or negation. If only one number is supplied, the negation of that number is returned. If more than one argument is given, it subtracts rest of the arguments from the first one and returns the result. The function performs necessary type conversions.

-----

### `_>`

Object _> is a built-in form defined at class io.opsit.explang.Compiler$TH_1ST
Arguments: 
    args
Documentation: 
    Threading form on first argument

-----

### `_>>`

Object _>> is a built-in form defined at class io.opsit.explang.Compiler$TH_LAST
Arguments: 
    args
Documentation: 
    Threading form on last argument.

-----
