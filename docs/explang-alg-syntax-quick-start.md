Quick Start for Explang with Algebraic Syntax 
=============================================

Installation
------------

Download an Explang with Algebraic Syntax executable JAR jars from Github 
[releases](https://github.com/opsit-io/opsit-explang-alg-parser/releases)

Or use maven CLI to fetch the artifacts from maven central:

```
mvn org.apache.maven.plugins:maven-dependency-plugin:2.8:get -Dartifact=io.opsit:opsit-explang-alg-parser:{{explang.version}}:jar:runnable   -Dtransitive=false -Ddest=opsit-explang-alg-parser-{{explang.version}}-runnable.jar
```

Using Explang Runnable Jar
--------------------------


## Using REPL

explang-alg-parser contains built-in REPL. Run it in a terminal emulator or in Windows console:

```
$ java -jar opsit-explang-alg-parser-{{explang.version}}-runnable.jar 
Welcome to the EXPLANG REPL!
Active parser is AlgParser
Loaded packages are: [base.math, base.text, io, base.bindings, ffi, base.funcs, loops, runtime, threads, base.version, base.coercion, base.logic, base.lang, base.arithmetics, base.seq, base.control, base.regex, dwim, base.docs, base.beans, base.types]
Please type an EXPLANG expression terminated by an extra NEWLINE
[0]> println("hello, world!");
hello, world!

=> hello, world!
[1]> 
```

This built-in REPL implementation does not support editing of and command history, so one is 
may want to it with some kind of wrapper such as [rlwrap](https://github.com/hanslub42/rlwrap),
VS Code [repeater REPL extension](https://github.com/RegisMelgaco/repeater--repl-tool), 
[Emacs inferior lisp mode](https://www.gnu.org/software/emacs/manual/html_mono/emacs.html#External-Lisp).

There is a REPL implementation with editing and history support in a separate project 
[Explang JLine REPL](https://github.com/opsit-io/opsit-explang-jline-repl).

To exit press ^D (^Z on Windows console) on a new line.


Executing Explang Scripts
-------------------------

```shell
$ java -jar opsit-explang-alg-parser-{{explang.version}}-runnable.jar ./examples/hello.jl
Hello world
```


Further Steps
-------------

- Learn more about the language in [Using Explang with Algebraic Syntax](explang-alg.md).
- See more information on using REPL in [Using Explang REPL](using-explang-REPL.md)
- See how to call Explang from Java code in [Using Explang from Java Code](explang-from-java.md). 
- See how to extend the language [Extending and Customizing the Language](explang-extending.md). 


