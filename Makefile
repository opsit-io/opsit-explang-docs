
EXPLANG=./opsit-explang-alg-parser-0.0.2-runnable.jar


build: $(EXPLANG) docs/functions.md
	mkdocs build

clean:
	rm -rf site/

realclean: clean
	rm -f $(EXPLANG)

docs/functions.md: $(EXPLANG)
	java -jar $(EXPLANG) -r lisp -f uc printref.l > $@


$(EXPLANG):
	mvn org.apache.maven.plugins:maven-dependency-plugin:2.8:get -Dartifact=io.opsit:opsit-explang-alg-parser:0.0.2:jar:runnable   -Dtransitive=false -Ddest=$(EXPLANG)

.PHONY: clean realclean build 
