javadoc_url ::= argv(1);

function format_funcall(funcname,args)
   str(funcname, "(", args, ")");
end;


function format_details(details)
   replace(details, "\n", "\n\n");
end;

function format_toc (items)
    foreach([item, items],
      	    print( "[", item, "](#",
		           replace(lowercase(string(item)), ".", ""),
		           ") "));
    println();
end;

function format_location (loc)
    loc_match:= re_matches( r"^(class) +(.*)$",  loc);
    if loc_match
	    str("[", loc,  "]", "(", javadoc_url, "/", loc_match[2] | replace (".","/") | replace("$", "."), ".html)");
    else
	    str("**", loc, "**");
    end;
end;

function printfunc(descr)
    matches := re_matches(re_matcher(r"(?s)^(.*?\.)[ \n\t\r]+(.*)$", descr.docstring));
    summary := if matches str("**", get(matches, 1), "**") else  "" end;
    details := if matches get(matches,2) else  descr.docstring end;
    funcType := if descr.builtIn "builtin" else "compiled" end;
    print(i"
### `$(descr.name)`

$(summary)

**$(format_funcall(descr.name, descr.argDescr))**

$(format_details(details))


**$(funcType) $(descr.codeType)** in package **$(descr.packageName)** defined at  **$(format_location(descr.defLocation))** 
"
          );
end;


fnames := functions_names();
descrs := map( f"describe_function", fnames); 

if argv(0) == "by-package"
    packages := append(hashset(),
                       map( descr -> descr.packageName, descrs));
    print("# Explang/Alg Built-in Functions by Package\n\n");
    format_toc(packages);
    foreach([package, append(list(), packages)],
            begin
                if not (package == "user" )
                    print(str(i"\n## $(package)\n\n"));
                    foreach([descr,  filter(dsc -> package == dsc.packageName, descrs)],
                            printfunc(descr));
                end;
            end);
else
    letters := append(hashset(), map ( fname -> fname[0], fnames));
 	print("# Explang/Alg Built-in Functions by Name\n\n");
    format_toc(letters);
    foreach([letter,append(list(), letters)],
            begin
                print(i"\n## $(letter)\n\n");
                foreach([descr, filter(dsc -> letter == dsc.name[0], descrs)],
                        if not (descr.packageName == "user" )
                            printfunc(descr);
                        end
                        );
            end);
end;            