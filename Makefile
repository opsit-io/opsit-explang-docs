
EXPLANG_VERSION=0.0.8
EXPLANG=./opsit-explang-alg-parser-$(EXPLANG_VERSION)-runnable.jar
EXPLANG_JAVADOC=./opsit-explang-core-$(EXPLANG_VERSION)-javadoc.jar
FORMATTER=printref
JAVADOC_URL=https://javadocs.dev/io.opsit/opsit-explang-core/$(EXPLANG_VERSION)


GENERATED=docs/explang-lisp-funcs-by-name.md docs/explang-lisp-funcs-by-package.md docs/explang-alg-funcs-by-package.md docs/explang-alg-funcs-by-name.md


build: $(EXPLANG) $(GENERATED) docs/*.md make_examples
	env EXPLANG_VERSION=$(EXPLANG_VERSION) mkdocs build


clean:
	rm -rvf site/
	rm -vf $(GENERATED)

realclean: clean
	rm -f $(EXPLANG)
	rm -f $(EXPLANG_JAVADOC)	
	rm -rf examples/


docs/explang-lisp-funcs-by-package.md: $(EXPLANG) $(FORMATTER).l
	java -jar $(EXPLANG) -r lisp -f uc $(FORMATTER).l by-package "$(JAVADOC_URL)" > $@

docs/explang-lisp-funcs-by-name.md: $(EXPLANG) $(FORMATTER).l
	java -jar $(EXPLANG) -r lisp -f uc $(FORMATTER).l by-name "$(JAVADOC_URL)" > $@

docs/explang-alg-funcs-by-package.md: $(EXPLANG) $(FORMATTER).jl
	java -jar $(EXPLANG) -r alg $(FORMATTER).jl by-package "$(JAVADOC_URL)" > $@

docs/explang-alg-funcs-by-name.md: $(EXPLANG) $(FORMATTER).jl
	java -jar $(EXPLANG) -r alg  $(FORMATTER).jl by-name "$(JAVADOC_URL)" > $@


$(EXPLANG):
	mvn org.apache.maven.plugins:maven-dependency-plugin:2.8:get -Dartifact=io.opsit:opsit-explang-alg-parser:$(EXPLANG_VERSION):jar:runnable   -Dtransitive=false -Ddest=$(EXPLANG)

$(EXPLANG_JAVADOC):
	mvn org.apache.maven.plugins:maven-dependency-plugin:2.8:get -Dartifact=io.opsit:opsit-explang-core:$(EXPLANG_VERSION):jar:javadoc   -Dtransitive=false -Ddest=$(EXPLANG_JAVADOC)

make_examples: make_examples_lisp make_examples_alg

make_examples_lisp: $(EXPLANG)  examples/lisp
	./make_examples.sh $(EXPLANG) lisp "Examples with Lisp Syntax" examples/lisp/*.l > docs/explang-examples-lisp.md

make_examples_alg: $(EXPLANG)  examples/alg
	./make_examples.sh $(EXPLANG) alg "Examples with Algebraic Syntax" examples/alg/*.jl > docs/explang-examples-alg.md


examples/lisp:
	mkdir -vp examples/lisp
	cp -v ../opsit-explang-core/examples/*.l examples/lisp/

examples/alg:
	mkdir -vp examples/alg
	cp -v ../opsit-explang-alg-parser/examples/*.jl examples/alg/

gh-deploy:
	mkdir -p gh-pages
	env EXPLANG_VERSION=$(EXPLANG_VERSION)  mkdocs gh-deploy -d gh-pages

.PHONY: clean realclean build update_examples make_examples_lisp make_examples_alg make_examples gh-deploy
