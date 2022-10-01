Explang Core Quick Start
========================

Installation
------------

Download an Explang Core executable JAR jars from Github 
[releases](https://github.com/opsit-io/opsit-explang-core/releases)

Or use maven CLI to fetch the artifacts from maven central:

```
mvn org.apache.maven.plugins:maven-dependency-plugin:2.8:get -Dartifact=io.opsit:opsit-explang-core:{{explang.version}}:jar:runnable   -Dtransitive=false -Ddest=opsit-explang-core-{{explang.version}}-runnable.jar
```

Using Explang Runnable Jar
--------------------------


## Using REPL

Explang-core contains built-in REPL. Run it in a terminal emulator or in Windows console:

```
$ java -jar opsit-explang-core-{{explang.version}}-runnable.jar 
Welcome to the EXPLANG REPL!
Active parser is LispParser
Loaded packages are: [base.math, base.text, io, base.bindings, ffi, base.funcs, loops, threads, base.version, base.coercion, base.logic, base.lang, base.arithmetics, base.seq, base.control, base.regex, dwim, base.docs, base.beans, base.types]
Please type an EXPLANG expression 
[0]> (print "hello, world!\n")
hello world

=> hello world

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
$ java -jar opsit-explang-core-{{explang.version}}-runnable.jar ./examples/hello.l
Hello world
```


Further Steps
-------------

- Learn more about the language in [Using Explang with Lisp Syntax](explang-lisp.md).
- See more information on using REPL in [Using Explang REPL](using-explang-REPL.md)
- See how to call Explang from Java code in [Using Explang from Java Code](explang-from-java.md). 
- See how to extend the language [Extending and Customizing the Language](explang-extending.md). 


