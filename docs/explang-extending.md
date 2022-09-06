Extending and Customizing the Language
======================================

Adding Java-based builtin function to the language
--------------------------------------------------

This example will add builtin function "rect"

```java
import io.opsit.explang.Backtrace;
import io.opsit.explang.Funcs.FuncExp;
import io.opsit.explang.Docstring;
import io.opsit.explang.Arguments;
import io.opsit.explang.Package;
import io.opsit.explang.ArgSpec;
import io.opsit.explang.Compiler.Eargs;
...
@Arguments(spec = {"with", ArgSpec.ARG_OPTIONAL, "height"})
@Docstring(text = "make rectangle width x height. (If height not set return square)")
@Package(name = "user")
public static class Rect extends FuncExp {
  @Override
  public Object evalWithArgs(Backtrace backtrace, Eargs eargs) {
    final Object width = eargs.get(0, backtrace);
    final Object height = eargs.get(1, backtrace);
    return "Rectangle(" + width +", " + (null == height ? width : height) +")";
  }
}

...

compiler.usePackages("user");
compiler.addBuiltIn("rect", Rect.class);

```


Adding Custom Syntax Parsers
----------------------------




