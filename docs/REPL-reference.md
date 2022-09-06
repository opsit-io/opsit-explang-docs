Explang REPL reference
======================


```shell
Explang REPL usage:
explang  [ option .. ] [ file | -- ] [ arg ..]
  -d            Enable verbose diagnostics
  -p  packages  Comma separated list of enabled packages
                By default all the packages are enabled.
                The available packages:
                  base.arithmetics
                  base.beans
                  base.bindings
                  base.coercion
                  base.control
                  base.docs
                  base.funcs
                  base.lang
                  base.logic
                  base.math
                  base.regex
                  base.seq
                  base.text
                  base.types
                  base.version
                  dwim
                  ffi
                  io
                  loops
                  runtime
                  threads
  -r  parser    Specify parser. The default is alg, available parsers are:
                  alg
                  lisp
                  sexp
  -f  converter Specify function name converter. The default is  alg, available converters are:
                  alg
                  nop
                  uc
  -l            Enable line mode
  -h            Print help message
  -v            Print software version
```


