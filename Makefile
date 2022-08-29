
EXPLANG=./opsit-explang-alg-parser-0.0.3-SNAPSHOT-runnable.jar
FORMATTER=printref.l

build: $(EXPLANG) docs/funcs-by-package.md docs/funcs-by-name.md 
	mkdocs build

clean:
	rm -rf site/
	rm -f docs/funcs-by-package.md docs/funcs-by-name.md 

realclean: clean
	rm -f $(EXPLANG)


docs/funcs-by-package.md: $(EXPLANG) $(FORMATTER)
	java -jar $(EXPLANG) -r lisp -f uc $(FORMATTER) by-package > $@

docs/funcs-by-name.md: $(EXPLANG) $(FORMATTER)
	java -jar $(EXPLANG) -r lisp -f uc $(FORMATTER) by-name > $@


$(EXPLANG):
	mvn org.apache.maven.plugins:maven-dependency-plugin:2.8:get -Dartifact=io.opsit:opsit-explang-alg-parser:0.0.3-SNAPSHOT:jar:runnable   -Dtransitive=false -Ddest=$(EXPLANG)

.PHONY: clean realclean build 
