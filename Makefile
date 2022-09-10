
EXPLANG=./opsit-explang-alg-parser-0.0.3-SNAPSHOT-runnable.jar
FORMATTER=printref
GENERATED=docs/explang-lisp-funcs-by-name.md docs/explang-lisp-funcs-by-package.md docs/explang-alg-funcs-by-package.md docs/explang-alg-funcs-by-name.md

build: $(EXPLANG) $(GENERATED) docs/*.md
	mkdocs build

clean:
	rm -rvf site/
	rm -vf $(GENERATED)

realclean: clean
	rm -f $(EXPLANG)
	rm -rf examples/


docs/explang-lisp-funcs-by-package.md: $(EXPLANG) $(FORMATTER).l
	java -jar $(EXPLANG) -r lisp -f uc $(FORMATTER).l by-package > $@

docs/explang-lisp-funcs-by-name.md: $(EXPLANG) $(FORMATTER).l
	java -jar $(EXPLANG) -r lisp -f uc $(FORMATTER).l by-name > $@

docs/explang-alg-funcs-by-package.md: $(EXPLANG) $(FORMATTER).jl
	java -jar $(EXPLANG) -r alg $(FORMATTER).jl by-package > $@

docs/explang-alg-funcs-by-name.md: $(EXPLANG) $(FORMATTER).jl
	java -jar $(EXPLANG) -r alg  $(FORMATTER).jl by-name > $@


$(EXPLANG):
	mvn org.apache.maven.plugins:maven-dependency-plugin:2.8:get -Dartifact=io.opsit:opsit-explang-alg-parser:0.0.3-SNAPSHOT:jar:runnable   -Dtransitive=false -Ddest=$(EXPLANG)

make_examples: make_examples_lisp make_examples_alg

make_examples_lisp: $(EXPLANG) examples/lisp/*.l
	./make_examples.sh $(EXPLANG) lisp "Examples with Lisp Syntax" examples/lisp/*.l > docs/explang-examples-lisp.md

make_examples_alg: $(EXPLANG) examples/alg/*.jl
	./make_examples.sh $(EXPLANG) alg "Examples with Algebraic Syntax" examples/alg/*.jl > docs/explang-examples-alg.md


update_examples:
	mkdir -vp examples/lisp
	cp -v ../opsit-explang-core/examples/*.l examples/lisp/
	mkdir -vp examples/alg
	cp -v ../opsit-explang-alg-parser/examples/*.jl examples/alg/

.PHONY: clean realclean build update_examples make_examples_lisp make_examples_alg make_examples
