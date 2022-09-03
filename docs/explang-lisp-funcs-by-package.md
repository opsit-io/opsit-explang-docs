# Explang Built-in Functions by Package

packages: [base.math, base.text, io, ffi, base.bindings, base.funcs, runtime, threads, loops, base.version, base.coercion, base.logic, base.lang, base.arithmetics, base.seq, base.control, base.regex, dwim, base.docs, user, base.types]

## base.math


### `EXP`

**Perform exponentiation.**

**(EXP  x &OPTIONAL base)**

If base is not given it returns e raised to power x. Returns a Double value.


**builtin function** defined at  **class io.opsit.explang.Funcs$EXP**

### `LOG`

**Computes logarithm.**

**(LOG  x &OPTIONAL base)**

If base is not given it computes natural logarithm. Returns a Double value.


**builtin function** defined at  **class io.opsit.explang.Funcs$LOG**

### `RANDOM`

**Produce Pseudo-Random Number.**

**(RANDOM  limit)**

Returns a pseudo-random number that is a non-negative number less than limit and of the same numeric type as limit. Implemented uding Java Math.random()


**builtin function** defined at  **class io.opsit.explang.Funcs$RANDOM**

### `SQRT`

**Computes square root of the argument.**

**(SQRT  x)**

Returns double value.


**builtin function** defined at  **class io.opsit.explang.Funcs$SQRT**

## base.text


### `FORMAT`

**Format String.**

**(FORMAT  format &REST values)**

Returns a formatted string using the specified format string (in the format of java.util.Formatter) and arguments. Arguments referenced by the format specifiers in the format string. If there are more arguments than format specifiers, the extra arguments are ignored. Throws IllegalFormatException - If a format string contains an illegal syntax, a format specifier that is incompatible with the given arguments, insufficient arguments given the format string, or other illegal conditions.


**builtin function** defined at  **class io.opsit.explang.Funcs$FORMAT**

### `STR`

**Concatenate Strings.**

**(STR  &REST values)**

Returns concatenation of string representationx of the function arguments


**builtin function** defined at  **class io.opsit.explang.Funcs$STR**

## io


### `LOAD`

**Execute program from a file/stream.**

**(LOAD  file-spec)**

Sequentially executes each form it encounters in the input file/or stream named by resource-spec. Returns exception if input could not be read or there were exceptions while compiling or executing forms an exception will be raised. file-spec may be a java.io.File object, file path as String or opened InputStream.


**builtin function** defined at  **class io.opsit.explang.Funcs$LOAD**

### `LOADR`

**Execute program from Java resource.**

**(LOADR  resource-spec)**

Sequentially executes each form it encounters in the java resource file named by resource-spec. Returns exception if file could not be read or there were exceptions while compiling or executing forms an exception will be raised.


**builtin function** defined at  **class io.opsit.explang.Funcs$LOADR**

### `PRINT`



**(PRINT  &REST args)**

Print Arguments on standard output.


**builtin function** defined at  **class io.opsit.explang.Funcs$PRINT**

### `READ-FROM-STRING`

**Parse expression from string.**

**(READ-FROM-STRING  string)**

Reads expression from string using default parser. Returns expression or NIL if no expression has been read


**builtin function** defined at  **class io.opsit.explang.Funcs$READ_FROM_STRING**

## ffi


### `.`

**Call Java Object Method/Read FieldCall method of java object or read contend of object field.**

**(.  object &REST call-args)**




**builtin function** defined at  **class io.opsit.explang.Funcs$DOT**

### `.N`

**Return New Class Instance.**

**(.N  class &OPTIONAL arglist typeslist)**

Optional arglist and typeslist parameters specify parameters to be passed to cosnstructor and their types. When typelist not given it tries to find most narrowly matching constructor on the basis of types of the arguments in arglist. If typeslist is provided exactly matching constructor will be used.


**builtin function** defined at  **class io.opsit.explang.Funcs$DOTN**

### `.S`

**Call Static Java Method/Read Static FieldCall method of java object or read contend of object field.**

**(.S  class &REST call-args)**




**builtin function** defined at  **class io.opsit.explang.Funcs$DOTS**

### `CLASS`

**Return Class by Class Name.Return class object according to it's fully qualified class name.**

**(CLASS  class-spec)**

class-spec may be string, symbol or any object,which string representation will be used


**builtin function** defined at  **class io.opsit.explang.Funcs$CLASS**

## base.bindings


### `BEAN`

**Convert Java Bean to a Map.**

**(BEAN  object &OPTIONAL prefix suffix)**

Returns a Map based on getters in the passed java object. Accepts optional prefix and suffics arguments that are used to modify the generated keys.


**builtin function** defined at  **class io.opsit.explang.Funcs$BEAN**

### `BOUNDP`

**Check if Symbols are Bound.**

**(BOUNDP  &REST symbols)**

Returns True if all the arguments are bound symbols or names of bound symbols; otherwise, returns False.


**builtin function** defined at  **class io.opsit.explang.Funcs$BOUNDP**

### `DLET`



**(DLET args ...)**

Destructuring LET construct.


**builtin form** defined at  **class io.opsit.explang.Compiler$DLET**

### `FUNCTION`



**(FUNCTION args ...)**

Get Function Given it's symbol.


**builtin form** defined at  **class io.opsit.explang.Compiler$FUNCTION**

### `GETPROP`

**Get Variable Property.**

**(GETPROP  symbol property-key)**

Returns value of a property from variable property map


**builtin function** defined at  **class io.opsit.explang.Funcs$GETPROP**

### `GETPROPS`



**(GETPROPS  symbol)**

Get Properties Map for a Variable.


**builtin function** defined at  **class io.opsit.explang.Funcs$GETPROPS**

### `LET`

**Evaluate code with given var.**

**(LET args ...)**

bindings.


**builtin form** defined at  **class io.opsit.explang.Compiler$LET**

### `MAKUNBOUND`

**Unbind variable given by symbol.**

**(MAKUNBOUND  symbol)**

Always returns symbol.


**builtin function** defined at  **class io.opsit.explang.Funcs$MAKUNBOUND**

### `NEW-CTX`



**(NEW-CTX )**

Create New Empty Context


**builtin function** defined at  **class io.opsit.explang.Funcs$NEW_CTX**

### `SET`

**Change variable value in specified context.**

**(SET  symbol value &KEY uplevel level)**

Set changes the contents of variable symbol in the dynamic context to the given value. If uplevel is set the value will be set in the uplevel-ths previous context. If level is set the value will be changed in the level-th context from the level0 


**builtin function** defined at  **class io.opsit.explang.Funcs$SET**

### `SETPROP`

**Set variable property.**

**(SETPROP  symbol property-key property-value)**

Sets property value in variable property map


**builtin function** defined at  **class io.opsit.explang.Funcs$SETPROP**

### `SETPROPS`



**(SETPROPS  symbol properties-map)**

Set Properties Map for a Variable


**builtin function** defined at  **class io.opsit.explang.Funcs$SETPROPS**

### `SETQ`

**Variable assignment, glocal if not exists.**

**(SETQ  &REST args)**

If variable is already assigned it's value will be replaced by result of form evaluation. If not new global binding will be created in the global scope

var - a symbol naming a variable.

form - an expression, which evaluation result will be assigned to var

Returns: value of the last form, or nil if no pairs were supplied.


**builtin form** defined at  **class io.opsit.explang.Compiler$SETQ**

### `SETV`

**Varianle assignmentm, global if not exists.**

**(SETV  &REST args)**

If variable is already assigned it's value will be replaced by result of form evaluation. If not new global binding will be created in the global scope

var - a symbol naming a variable.

form - an expression, which evaluation result will be assigned to var

Returns: value of the last form, or nil if no pairs were supplied.


**builtin form** defined at  **class io.opsit.explang.Compiler$SETV**

### `SYMBOL`



**(SYMBOL  symbol-name)**

Makes new Symbol for a string


**builtin function** defined at  **class io.opsit.explang.Funcs$SYMBOL**

### `TRY`



**(TRY args ...)**

Try-Catch-Final construction.


**builtin form** defined at  **class io.opsit.explang.Compiler$TRY**

### `WITH-BINDINGS`



**(WITH-BINDINGS args ...)**

Evaluate code with bindings from a Java Map.


**builtin form** defined at  **class io.opsit.explang.Compiler$WITH_BINDINGS**

### `WITH-CTX`



**(WITH-CTX args ...)**

Evaluate code in given context.


**builtin form** defined at  **class io.opsit.explang.Compiler$WITH_CTX**

## base.funcs


### `APPLY`

**Apply function to arguments.**

**(APPLY  f &REST arguments)**

arguments must be a spreadable list designator, i.e. if the last argument is a list, it contents will be appended to the list of arguments.


**builtin function** defined at  **class io.opsit.explang.Funcs$APPLY**

### `BACKTRACE`

**Return callstack backtrace.**

**(BACKTRACE )**

Returns string representation of current stack frame.


**builtin function** defined at  **class io.opsit.explang.Funcs$BACKTRACE**

### `DEFUN`



**(DEFUN args ...)**

Define named function


**builtin form** defined at  **class io.opsit.explang.Compiler$DEFUN**

### `FUNCALL`

**Apply Arguments to a Function.**

**(FUNCALL  function &REST arguments)**

Function must be a function object


**builtin function** defined at  **class io.opsit.explang.Funcs$FUNCALL**

### `FUNCTIONP`

**Check if object is a function.**

**(FUNCTIONP  object)**

Returns true if object is a function (built-in or user defined); otherwise, returns false. A function is an object that represents code to be executed when an appropriate number of arguments is supplied. A function can be directly invoked by using it as the first argument to funcall, apply.


**builtin function** defined at  **class io.opsit.explang.Funcs$FUNCTIONP**

### `SYMBOL-FUNCTION`

**Returns function bound to given symbol.**

**(SYMBOL-FUNCTION  symbol)**

If no function bound raises an error. The returned object may be a built-in function, compiled function or built-in special form.


**builtin function** defined at  **class io.opsit.explang.Funcs$SYMBOL_FUNCTION**

## runtime


### `ARGV`

**Access command line arguments.**

**(ARGV  &OPTIONAL n)**

When n is provided return nth argument as String, when not -- return list of command line arguments. If n is out of range return NIL.


**builtin function** defined at  **class io.opsit.explang.Funcs$ARGV**

## threads


### `NEW-THREAD`

**Create new Java thread.**

**(NEW-THREAD  fn &OPTIONAL name)**

Creates new Java thread and prepare it for execution of given function fn.fn must not require parameters for it's execution. The created thread is not started.


**builtin function** defined at  **class io.opsit.explang.Funcs$NEW_THREAD**

## loops


### `WHILE`

**While loop construction.**

**(WHILE args ...)**

Execute sequnce of expressions while the consition is true


**builtin form** defined at  **class io.opsit.explang.Compiler$WHILE**

## base.version


### `VERSION`

**Create Version from text specification.**

**(VERSION  spec)**




**builtin function** defined at  **class io.opsit.explang.Funcs$VERSION**

## base.coercion


### `BOOL`

**Coerce Value to Boolean.**

**(BOOL  value)**

Value may be a Character, a Number, a Boolean, a Byte, a String, any object or NIL:

* Boolean value will be returned as is

* NIL is false

* Character    is false.

* any Number which is equal to zero is false

* an empty String is false

* An empty collection is false 

* Any other object is true.




**builtin function** defined at  **class io.opsit.explang.Funcs$BOOL**

### `BYTE`

**Coerce Value to Byte.**

**(BYTE  value)**

Value may be a Number, String, any object or NIL.String will be parsed as number using same rules as numeric literals. The floating point values will be truncated.


**builtin function** defined at  **class io.opsit.explang.Funcs$BYTE**

### `CHAR`

**Coerce Value to Character.**

**(CHAR  value)**

Value may be a Character, a Number, a Boolean, a Byte, a Stringor NIL:

* Character value will be returned as is.

* NIL will be converted to unicode value # .

* a Boolean True value will be returned as character 'T', False as ' '.

* a Number (other than Byte) will be truncated to short (if needed) and the character at corresponding Unicode code unit will be returned.

* a Byte value will be treated as unsigned integer value and processed as described above.

* a String will be parsed as number using same rules as numeric literals and the resulting value will be used as described above. Conversion to number may fail.

* Any other object will cause conversion error.




**builtin function** defined at  **class io.opsit.explang.Funcs$CHAR**

### `DOUBLE`

**Coerce Value to Double.**

**(DOUBLE  value)**

Value may be a Number, String, any object or NIL.String will be parsed as number using same rules as numeric literals. The floating point values will be truncated.


**builtin function** defined at  **class io.opsit.explang.Funcs$DOUBLE**

### `FLOAT`

**Coerce Value to Float.**

**(FLOAT  value)**

Value may be a Number, String, any object or NIL.String will be parsed as number using same rules as numeric literals. The floating point values will be truncated.


**builtin function** defined at  **class io.opsit.explang.Funcs$FLOAT**

### `INT`

**Coerce value to Integer.**

**(INT  value)**

Value may be a Number, String, any object or NIL.String will be parsed as number using same rules as numeric literals. The floating point value will be truncated.


**builtin function** defined at  **class io.opsit.explang.Funcs$INT**

### `LONG`

**Coerce Value to Long.**

**(LONG  value)**

Value may be a Number, String, any object or NIL.String will be parsed as number using same rules as numeric literals. The floating point values will be truncated.


**builtin function** defined at  **class io.opsit.explang.Funcs$LONG**

### `SHORT`

**Coerce Value to Short.**

**(SHORT  value)**

Value may be a Number, String, any object or NIL.String will be parsed as number using same rules as numeric literals. The floating point values will be truncated.


**builtin function** defined at  **class io.opsit.explang.Funcs$SHORT**

### `STRING`

**Coerce Value to String.**

**(STRING  value)**

Value may be any object or NIL: NIL is converted to String "NIL", any other object converted using it's toString() method


**builtin function** defined at  **class io.opsit.explang.Funcs$STRING**

## base.logic


### `<`

**Less Than - Numeric Comparison.**

**(<  x &REST args)**

Returns True if all arguments are monotonically increasing order.  Returns True if only one argument is given


**builtin function** defined at  **class io.opsit.explang.Funcs$NUMLT**

### `<=`

**Less or Equal - Numeric comparison.**

**(<=  x &REST args)**

Returns True if all arguments are monotonically non-decreasing order.  Returns True if only one argument is given


**builtin function** defined at  **class io.opsit.explang.Funcs$NUMLE**

### `=`

**Test numeric equality.**

**(=  x &REST args)**

Returns True if all arguments are numerically equal. Returns True if only one argument is given


**builtin function** defined at  **class io.opsit.explang.Funcs$NUMEQ**

### `==`

**Check Value Equality.**

**(==  x y)**

Returns true if x equal to y according to call to Java method x.equals(y) or if both objects are NIL. If they are not, it  returns true if  thy are equal numerically or structurally.


**builtin function** defined at  **class io.opsit.explang.Funcs$SEQUAL**

### `===`

**Check Object Equality.**

**(===  x y)**

Objects identity check: returns true if Object x is same as Object y. Uses java operator == to check objects identity


**builtin function** defined at  **class io.opsit.explang.Funcs$EQ**

### `>`

**Greater Than - Numeric comparison.**

**(>  x &REST args)**

Returns True if all arguments are monotonically decreasing order.  Returns True if only one argument is given


**builtin function** defined at  **class io.opsit.explang.Funcs$NUMGT**

### `>=`

**Greater or Equal - Numeric comparison.**

**(>=  x &REST args)**

Returns True if all arguments are monotonically non-increasing order. Returns True if only one argument is given


**builtin function** defined at  **class io.opsit.explang.Funcs$NUMGE**

### `AND`

**Logical AND.**

**(AND  &REST &LAZY forms)**

Function AND lazily evaluates each argument form, one at a time from left to right. As soon as any form evaluates to NIL, AND returns NIL without evaluating the remaining forms. If all forms but the last evaluate to true values, AND returns the results produced by evaluating the last form. If no forms are supplied, (AND) returns true.


**builtin function** defined at  **class io.opsit.explang.Funcs$AND**

### `DWIM-MATCHES`

**Perform DWIM find operation.**

**(DWIM-MATCHES  arg0 &OPTIONAL arg2)**

When pattern is an Regexp tries to find the regexp in String Representation of object.

  When pattern is a String it tries to find its occurences in the String Representation of object.

 When pattern is a Number then numeric equality check is performed. 

 When pattern is any other object the equality test is performed. 

 If there were matches the function returns list of matches. 

If there is no match an empty list is returned.


**builtin function** defined at  **class io.opsit.explang.DWIM$DWIM_MATCHES**

### `EQUAL`

**Check Object Equality.**

**(EQUAL  x y)**

Returns true if x equal to y according to call to Java method x.equals(y) or if both objects are NIL.


**builtin function** defined at  **class io.opsit.explang.Funcs$EQUAL**

### `NOT`

**Logical Negation.**

**(NOT  x)**

Returns True if x has false logical value; otherwise, returns False.Parameter x can be any object. Only NIL, the empty list (), the empty String "", 0  and FALSE have false logical value. All other objects have true logical value


**builtin function** defined at  **class io.opsit.explang.Funcs$NOT**

### `OR`

**Logical OR.**

**(OR  &REST &LAZY args)**

Function OR lazily evaluates each form, one at a time, from left to right. The evaluation of all forms terminates when a form evaluates to true (i.e., something other than nil) and OR immediately returns that value without evaluating the remaining forms.


**builtin function** defined at  **class io.opsit.explang.Funcs$OR**

## base.lang


### `EVAL`

**Evaluate a Parsed Expression.**

**(EVAL  form)**

Evaluates parsed form in the current dynamic context and return result of evaluation'


**builtin function** defined at  **class io.opsit.explang.Funcs$EVAL**

### `QUOTE`



**(QUOTE args ...)**

Return its argument without evaluation.


**builtin form** defined at  **class io.opsit.explang.Compiler$QUOTE**

## base.arithmetics


### `%`

**Compute Remainder.**

**(%  x y)**

Generalizations of the remainder function. When both operands are integer returns result of the remainder operation . If one of them is floating point returns result of 

	 number - truncate_to_zero (number / divisor) * divisor (same semantic as for the Java % operator.


**builtin function** defined at  **class io.opsit.explang.Funcs$REMOP**

### `*`

**Compute Product.**

**(*  &REST args)**

Returns the product of it's arguments , performing any necessary type conversions in the process. If no numbers are supplied, 1 is returned.


**builtin function** defined at  **class io.opsit.explang.Funcs$MULOP**

### `+`

**Compute Sum.**

**(+  &REST args)**

Returns the sum of numeric values of it's arguments, performing any necessary type conversions in the process. If no numbers are supplied, 0 is returned.


**builtin function** defined at  **class io.opsit.explang.Funcs$ADDOP**

### `-`

**Performs subtraction or negation.**

**(-  &REST args)**

If only one number is supplied, the negation of that number is returned. If more than one argument is given, it subtracts rest of the arguments from the first one and returns the result. The function performs necessary type conversions.


**builtin function** defined at  **class io.opsit.explang.Funcs$SUBOP**

### `/`

**Performs Division or Reciprocation.**

**(/  &REST args)**

If no denominators are supplied, the function / returns the reciprocal of number. If at least one denominator is supplied, the function / divides the numerator by all of the denominators and returns the resulting quotient. If each argument is either an integer or a ratio, and the result is not an integer, then it is a ratio. The function / performs necessary type conversions. 


**builtin function** defined at  **class io.opsit.explang.Funcs$DIVOP**

### `MAX`

**Find maximum.**

**(MAX  x &REST args)**

Returns the maximum of numeric values of it's arguments, performing any necessary type conversions in the process. 


**builtin function** defined at  **class io.opsit.explang.Funcs$MAXOP**

### `MIN`

**Find minimum.**

**(MIN  x &REST args)**

Returns the maximum of numeric values of it's arguments, performing any necessary type conversions in the process. 


**builtin function** defined at  **class io.opsit.explang.Funcs$MINOP**

### `MOD`

**Compute Modulus.**

**(MOD  number divisor)**

Generalizations of the modulus function. When both operands are integer returns result of the modulus operation. If one of them is floating point returns result of 

	 number - ⌊ (number / divisor) ⌋ * divisor 


**builtin function** defined at  **class io.opsit.explang.Funcs$MODOP**

### `REM`

**Compute Remainder.**

**(REM  x y)**

Generalizations of the remainder function. When both operands are integer returns result of the remainder operation . If one of them is floating point returns result of 

	 number - truncate_to_zero (number / divisor) * divisor (same semantic as for the Java % operator.


**builtin function** defined at  **class io.opsit.explang.Funcs$REMOP**

### `SIGNUM`

**Return Number Sign.**

**(SIGNUM  x)**

Determines a numerical value that indicates whether number is negative, zero, or positive. Returns one of -1, 0, or 1 according to whether number is negative, zero, or positive. The type of the result is of the same numeric type as x


**builtin function** defined at  **class io.opsit.explang.Funcs$SIGNUM**

## base.seq


### `->`



**(-> args ...)**

Threading form on first argument


**builtin form** defined at  **class io.opsit.explang.Compiler$TH_1ST**

### `APPEND`

**Concatenate sequences (non-destructive).**

**(APPEND  &REST sequences)**

append returns a new sequence that is the concatenation of the elements of the arguments. All the argument remain unchanged. The resulting sequence is of the same type as the first argument. In no arguments were given an empty list is returned. If target sequence is an array necessary coercions will be performed automatically.


**builtin function** defined at  **class io.opsit.explang.Funcs$APPEND**

### `APPEND!`

**Concatenate sequences (destructive).**

**(APPEND!  &REST sequences)**

Adds to the first given sequence (target sequence) all the elements ofall of the following sequences and return the target sequence.  If no sequences were given an empty list will be returned. Target sequence must be extendable, that means that objects like Arrays or String cannot be target of this operation


**builtin function** defined at  **class io.opsit.explang.Funcs$NAPPEND**

### `AREF`

**Get Array element value.**

**(AREF  array index)**

Return array element at specified index. Throws ArrayOutOfBoundsException if index is invalid


**builtin function** defined at  **class io.opsit.explang.Funcs$AREF**

### `ASET`

**Sat array element value.**

**(ASET  array index object)**

Set value of array element at index to object. If java array is typed (i.e. not array of java.lang.Objects) and object type does not match this function will attempt to perform necessary coercion operations. The coercions work in the same way as INT, FLOAT, STRING and rest of the built-in coercion functions.


**builtin function** defined at  **class io.opsit.explang.Funcs$ASET**

### `ASSOC`

**Associates value with key in an map structure.**

**(ASSOC  map key val &REST kvpairs)**

Return new instance of the structure, the original is left unchanged.


**builtin function** defined at  **class io.opsit.explang.Funcs$ASSOC**

### `ASSOC!`

**Associates value with key in an map structure.**

**(ASSOC!  map key val &REST kvpairs)**

Modifies the object and returns it as the result.


**builtin function** defined at  **class io.opsit.explang.Funcs$NASSOC**

### `CONS`



**(CONS  object-1 object-2)**

Prepend element to a sequence.


**builtin function** defined at  **class io.opsit.explang.Funcs$CONS**

### `FILTER`

**Filter operation.**

**(FILTER  test sequence)**

test is a function of one argument that returns boolean, seq is input sequence. Return a sequence from which the elements that do not satisfy the test have been removed.


**builtin function** defined at  **class io.opsit.explang.Funcs$FILTER**

### `FIRST`

**Returns the first element of the sequence.**

**(FIRST  sequence)**

Returns NIL when sequence is NIL or empty


**builtin function** defined at  **class io.opsit.explang.Funcs$FIRST**

### `FOREACH`

**Foreach Loop over a sequence.**

**(FOREACH  ( VAR SEQUENCE &OPTIONAL RESULT ) &REST body)**

Evaluate body with VAR bound to each element from SEQUENCE, in turn.

Then evaluate RESULT to get return value, default NIL.


**builtin form** defined at  **class io.opsit.explang.Compiler$FOREACH**

### `GET`

**Returns the value from an associative structure.**

**(GET  structure key &OPTIONAL not-found)**

Return value from an associative structure struct, 

 Returns NIL if the key is not present, or the not-found value if supplied.


**builtin function** defined at  **class io.opsit.explang.Funcs$GET**

### `GET-IN`

**Returns the value from an associative structure.**

**(GET-IN  structure ks &OPTIONAL not-found)**

Return value from an associative structure struct, 

where ks is a sequence of keys. Returns NIL if the key

 is not present, or the not-found value if supplied.


**builtin function** defined at  **class io.opsit.explang.Funcs$GET_IN**

### `HASHMAP`

**Create a HashMap.**

**(HASHMAP  &REST pairs)**

Returns new HashMap filled with given keys and values. Throws InvalidParametersException if non-even number of arguments is given.


**builtin function** defined at  **class io.opsit.explang.Funcs$HASHMAP**

### `HASHSET`

**Create a HashSet.**

**(HASHSET  &REST args)**

Returns a set containing the supplied objects. 


**builtin function** defined at  **class io.opsit.explang.Funcs$HASHSET**

### `IN`

**Check if an element is contained in a sequence.**

**(IN  elt sequence)**




**builtin function** defined at  **class io.opsit.explang.Funcs$IN**

### `LENGTH`

**Return length of a sequence.**

**(LENGTH  sequence)**

Parameter may be any supported sequence (collection, array, character sequence) or NIL (0 will be returned).


**builtin function** defined at  **class io.opsit.explang.Funcs$LENGTH**

### `LIST`

**Create a list.**

**(LIST  &REST args)**

Returns a list containing the supplied objects. 


**builtin function** defined at  **class io.opsit.explang.Funcs$LIST**

### `MAKE-ARRAY`

**Ceate an Array.**

**(MAKE-ARRAY  size &KEY element-type)**

Creates array of objects of specified size. Optional :element-type argument specifies type of array elements. The default is java.lang.Object


**builtin function** defined at  **class io.opsit.explang.Funcs$MAKE_ARRAY**

### `MAP`

**Apply function on elements of collections.**

**(MAP  func &REST lists)**

Returns a sequence consisting of the result of applying func to the set of first items of each list, followed by applying func to the set of second items in each list, until any one of the lists is exhausted.  Any remaining items in other lists are ignored. Function func should accept number arguments that is equal to number of lists.


**builtin function** defined at  **class io.opsit.explang.Funcs$MAP**

### `MAPPROD`

**Apply function on cartesioan product of lists.**

**(MAPPROD  f &REST lists)**

Returns a sequence consisting of the result of applying func to the cartesian product of the lists. Function func should accept number arguments that is equal to number of lists.


**builtin function** defined at  **class io.opsit.explang.Funcs$MAPPROD**

### `NTH`

**Locates the nth element of a sequence.**

**(NTH  n sequence)**

n may be any non-negative number. Returns NIL when sequence is NIL or n is out of bounds


**builtin function** defined at  **class io.opsit.explang.Funcs$NTH**

### `RANGE`

**Return sequence of numbers.**

**(RANGE  start stop &OPTIONAL step)**

Returns sequence of numbers  from start to stop (inclusively) with .


**builtin function** defined at  **class io.opsit.explang.Funcs$RANGE**

### `REDUCE`

**Reduce operation.**

**(REDUCE  func &OPTIONAL val &REQUIRED seq)**

func is a function of 2 arguments, value - optional starting value, seq is input sequence.

When val is not given:  apply func to the first 2 items in the seq, then to the result and 3rd, etc. If seq contains no items, func must accept no arguments, return (func).If seq has 1 item, return it without calling func;

If value is supplied, apply func on value and the first seq element, then on the result and the second element, etc. If there is no elements - return val;


**builtin function** defined at  **class io.opsit.explang.Funcs$REDUCE**

### `REPLACE`

**Replace eache subsequence in seq that equals to target with replacement sequence.**

**(REPLACE  seq target &OPTIONAL replacement)**

Return resulting sequence. The original sequence is not modified.


**builtin function** defined at  **class io.opsit.explang.Funcs$REPLACE**

### `REST`



**(REST  sequence)**

Return 2nd and further elements of sqeuence.


**builtin function** defined at  **class io.opsit.explang.Funcs$REST**

### `REVERSE`



**(REVERSE  sequence)**

Reverse a sequence (non-destructive).


**builtin function** defined at  **class io.opsit.explang.Funcs$REVERSE**

### `REVERSE!`



**(REVERSE!  sequence)**

Reverse a sequence (destructive).


**builtin function** defined at  **class io.opsit.explang.Funcs$NREVERSE**

### `SELECT-KEYS`

**Returns a map containing only those entries in map whose key is in keys.**

**(SELECT-KEYS  object keyseq)**




**builtin function** defined at  **class io.opsit.explang.Funcs$SELECT_KEYS**

### `SEQ`



**(SEQ  object)**

Coerce object into a sequence.


**builtin function** defined at  **class io.opsit.explang.Funcs$SEQ**

### `SEQUENCEP`



**(SEQUENCEP  object)**

Check if an object is a sequence.


**builtin function** defined at  **class io.opsit.explang.Funcs$SEQUENCEP**

### `SORT`



**(SORT  &OPTIONAL f &REQUIRED sequence)**

Sort a sequence (non destructively).


**builtin function** defined at  **class io.opsit.explang.Funcs$SORT**

### `SORT!`



**(SORT!  &OPTIONAL f &REQUIRED sequence)**

Sort a sequence (destructively).


**builtin function** defined at  **class io.opsit.explang.Funcs$NSORT**

### `SUBSEQ`

**Return subsequnce of a sequence.**

**(SUBSEQ  sequence start &OPTIONAL end)**

subseq creates a sequence that is a copy of the subsequence of sequence bounded by start and end. Start specifies an offset into the original sequence and marks the beginning position of the subsequence. end marks the position following the last element of the subsequence. subseq always allocates a new sequence for a result; it never shares storage with an old sequence. The result subsequence is of the same kind as sequence.


**builtin function** defined at  **class io.opsit.explang.Funcs$SUBSEQ**

### `TAKE`

**Return  first n elements of a sequence.**

**(TAKE  n seq)**

take creates new sequence with first n elements of seq. If n is bigger than length of the sequence all the elementsare returned. The result subsequence is of the same kind as sequence.


**builtin function** defined at  **class io.opsit.explang.Funcs$TAKE**

## base.control


### `->>`



**(->> args ...)**

Threading form on last argument.


**builtin form** defined at  **class io.opsit.explang.Compiler$TH_LAST**

### `@->`



**(@-> args ...)**

Threading form on &PIPE or first argument


**builtin form** defined at  **class io.opsit.explang.Compiler$TH_PIPE**

### `AS->`



**(AS-> args ...)**

Threading form on named argument


**builtin form** defined at  **class io.opsit.explang.Compiler$TH_AS**

### `COND`

**Conditional switch construct.**

**(COND  &REST args)**

COND allows the execution of forms to be dependent on test-form.

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


**builtin form** defined at  **class io.opsit.explang.Compiler$COND**

### `IF`



**(IF args ...)**

If-else conditional construct.


**builtin form** defined at  **class io.opsit.explang.Compiler$IF**

### `LAMBDA`



**(LAMBDA args ...)**

Define anonymous function


**builtin form** defined at  **class io.opsit.explang.Compiler$LAMBDA**

### `PROGN`



**(PROGN args ...)**

Evaluate sequence of expressions.


**builtin form** defined at  **class io.opsit.explang.Compiler$PROGN**

### `THROW`

**Throw Java Exception.**

**(THROW  exception)**

The exception may be a java Throwable object or String. In the latter case a new ExecutionException with given message will be created and thrown.


**builtin function** defined at  **class io.opsit.explang.Funcs$THROW**

## base.regex


### `RE-FIND`

**Perform Regexp Find.**

**(RE-FIND  arg0 &OPTIONAL arg2)**

When called With two arguments creates java.util.regex.Matcher using pattern and char-seq.

  When called with one arguments it uses given Matcher. 

 Returns the next ,match, if any, of string to pattern, using Matcher.find(). 

 if no groups were defined it returns the matched string.

 If groups were defined it returns a list consisting of the full match and matched groups

 If there is no match NIL is returned


**builtin function** defined at  **class io.opsit.explang.Funcs$RE_FIND**

### `RE-GLOB`

**Compile a Globbing Pattern.**

**(RE-GLOB  pattern)**

On success returns a java.util.regex.Pattern object. On error raises exception.


**builtin function** defined at  **class io.opsit.explang.Funcs$RE_GLOB**

### `RE-GROUPS`

**Return Groups for a Regexp Match.**

**(RE-GROUPS  matcher)**

Returns the groups from the most recent match/find.

If there are no nested groups, returns a string of the entire

match. If there are nested groups, returns a list of the groups,

the first element being the entire match.


**builtin function** defined at  **class io.opsit.explang.Funcs$RE_GROUPS**

### `RE-MATCHER`

**Return Regexp Matcher.**

**(RE-MATCHER  pattern char-seq)**

Returns an instance of java.util.regex.Matcher, for use, e.g. in RE-FIND.


**builtin function** defined at  **class io.opsit.explang.Funcs$RE_MATCHER**

### `RE-MATCHES`

**Perform regexp match.**

**(RE-MATCHES  arg0 &OPTIONAL arg2)**

When called With two arguments created java.util.regex.Matcher using pattern and char-seq.

  When called with one arguments it uses given Matcher. 

 Returns the match, if any, of string to pattern, using Matcher.matches(). 

 if no groups were defined it returns the matched string.

 If groups were defined it returns a list consisting of the full match and matched groups

 If there is no match NIL is returned


**builtin function** defined at  **class io.opsit.explang.Funcs$RE_MATCHES**

### `RE-PATTERN`

**Compile A Regexp Pattern.**

**(RE-PATTERN  pattern)**

On success returns a java.util.regex.Pattern objec. On error raises exception.


**builtin function** defined at  **class io.opsit.explang.Funcs$RE_PATTERN**

### `RE-SEQ`

**Return Results of Regexp Find as a Lazy Sequence.**

**(RE-SEQ  arg0 &OPTIONAL arg2)**

When called With two arguments created java.util.regex.Matcher using pattern and char-seq.

  Returns lazy iterable sequence (instance of Iterable) of matches of string to pattern, using Matcher.find(). 

 When called with one arguments it uses given Matcher. 

 if no groups were defined the elements of the sequence are the matched string.

 If groups were defined it returns a list consisting of the full match and matched groups

 If there is no match empty sequence is returned


**builtin function** defined at  **class io.opsit.explang.Funcs$RE_SEQ**

## dwim


### `DWIM-SEARCH`

**Perform DWIM search of an item in a sequence of objects.**

**(DWIM-SEARCH  sequence test)**




**builtin form** defined at  **class io.opsit.explang.Compiler$DWIM_SEARCH**

### `DWIM_FIELDS`

**Returns a map containing only those entries in map whose key is in keys.**

**(DWIM_FIELDS  object keyseq)**




**builtin function** defined at  **class io.opsit.explang.Funcs$DWIM_FIELDS**

## base.docs


### `DESCRIBE-FUNCTION`

**Describe function.**

**(DESCRIBE-FUNCTION  function)**

Return textual description of given function or built-in form. function is a symbol or function name or a lambda


**builtin function** defined at  **class io.opsit.explang.Funcs$DESCRIBE_FUNCTION**

### `DOCUMENTATION`

**Get Function Docstring.**

**(DOCUMENTATION  function-name)**

Return documentation string of given function or built-in form. function is a symbol or function name or a lambda


**builtin function** defined at  **class io.opsit.explang.Funcs$DOCUMENTATION**

### `FUNCTIONS-NAMES`

**Get list of names of defined functions.**

**(FUNCTIONS-NAMES  &REST names)**

If names are given use them as filter expressions:  only those which match at least one of filter expressions will be returned. Filters may be strings (substring match) or regular expressions (java.util.regex.Pattern objects).


**builtin function** defined at  **class io.opsit.explang.Funcs$FUNCTIONS_NAMES**

## user


### `FORMAT-DETAILS`



**(FORMAT-DETAILS  details)**

N/A


**compiled compiled function** defined at  **printref.l:line=61:pos=0:o=1668:len=0**

### `FORMAT-FUNCALL`



**(FORMAT-FUNCALL  funcname args)**

N/A


**compiled compiled function** defined at  **printref.l:line=61:pos=0:o=1668:len=0**

### `PRINTFUNC`



**(PRINTFUNC  descr)**

N/A


**compiled compiled function** defined at  **printref.l:line=61:pos=0:o=1668:len=0**

## base.types


### `TYPE-OF`

**Return Object Type.**

**(TYPE-OF  object)**

Returns type (as class) of the given object. For NIL argument return NIL.


**builtin function** defined at  **class io.opsit.explang.Funcs$TYPE_OF**

### `TYPEP`

**Check if Object is of Specified Type.**

**(TYPEP  object type-specifier)**

Returns True if object is of the specified type. Type specifier may be a Class object or string or symbol which is a valid type-specifier.


**builtin function** defined at  **class io.opsit.explang.Funcs$TYPEP**
