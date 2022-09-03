
EXPLANG=./opsit-explang-alg-parser-0.0.3-SNAPSHOT-runnable.jar
FORMATTER=printref

build: $(EXPLANG) docs/explang-lisp-funcs-by-package.md docs/explang-lisp-funcs-by-name.md  docs/explang-alg-funcs-by-package.md docs/explang-alg-funcs-by-name.md 
	mkdocs build

clean:
	rm -rf site/
	rm -f docs/explang-*-funcs-by-*.md

realclean: clean
	rm -f $(EXPLANG)


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

.PHONY: clean realclean build 
