Using Explang from Java Code
----------------------------

### Add to the dependencies list in *pom.xml*


```xml
<dependencies>
  <dependency>
    <groupId>io.opsit</groupId>
    <artifactId>opsit-explang-core</artifactId>
    <version>{{explang.version}}</version>
  </dependency>
...
</dependencies>

```

### Parse, compile and evaluate Explang expressions from Java code


```java

import io.opsit.explang.ASTNList;
import io.opsit.explang.Compiler;
import io.opsit.explang.ICompiled;
import io.opsit.explang.IParser;
import io.opsit.explang.ParseCtx;
import io.opsit.explang.parser.lisp.LispParser;
import java.util.HashMap;
import java.util.Map;

...

// code: add two variables
String code = "(+ a b)";
// map with variable values
Map<String,Object> vars = new HashMap<String,Object>();
vars.put("a", 1);
vars.put("b", 2.5);

// Create compiler
Compiler compiler = new Compiler();
// Create a parser and associate it with the compiler
IParser parser = new LispParser();
ParseCtx pctx = new ParseCtx("mycode");
compiler.setParser(parser);
    
// parse code into Abstract Syntax Tree
ASTNList exprs = parser.parse(pctx, code);

// Check that an expression was parsed without errors.
if (exprs.hasProblems()) {
  System.err.println("Parse errors: " + exprs.getProblem());
} else if (exprs.isEmpty()) {
  System.out.println("No expressions were parsed");
} else {
  // Compile an expression into reusable form that can be executed
  ICompiled exp = compiler.compile(exprs.get(0));
  // Create context with user data
  Compiler.ICtx ctx = compiler.newCtx(vars);
  // execute compiled code in given context;
  Object expVal = exp.evaluate(compiler.newBacktrace(), ctx);
  System.out.println("Result: " + expVal);
}

```

Evaluating Explang expressions via the Java Scripting API (JSR223)
------------------------------------------------------------------

A simpler, but less flexible way of executing Explang is to use it via the
[Java Scripting API](https://jcp.org/aboutJava/communityprocess/final/jsr223/index.html)


```java
package io.opsit.explang.examples;

import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import io.opsit.explang.jsr223.ExplangScriptEngineFactory;

....
ScriptEngineManager mgr = new ScriptEngineManager();
mgr.registerEngineName("explang", new ExplangScriptEngineFactory());

ScriptEngine engine = mgr.getEngineByName("explang");
// code: add two variables
String code = "(+ a b)";
// map with variable values
engine.put("a", 2);
engine.put("b", 1.5);

Object result = engine.eval("(+ a b)");
System.out.println("eval Result: " + result);

engine.eval(""
+ "(DEFUN fact(x) "
+ "  (IF x (* x (fact (- x 1)))"
+ "        1))"
+ ");
result = ((Invocable) engine).invokeFunction("fact", 5);
System.out.println("invoke function result: " + result);
```
