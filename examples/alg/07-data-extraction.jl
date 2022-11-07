### Data Search and Extraction

# Examples of data extraction from nested data structures. The structure is
# based on examples in the book
# "Data Oriented Programming" by Yehonatan Sharvit.

function main()
    # Get input data, see it below at the end of file
    println("Input data: ", getData());

    
    println(i"\nGet entry by key (ISBN) and get one of its fields:");
    isbn:="978-1779501127";
    println(getData().booksByIsbn[isbn]["title"]);

    println("\nGet entry by key (ISBN) and make new object of several fields:");
    isbn:="978-1779501127";
    println( getData().booksByIsbn[isbn] | fields title, publicationYear );

    # define function to retrieve authors
    function authorIdsToDescr(data, authorIds)
        "retrieve and format list of authors as string";
        authorIds | map(x -> data.authorsById[x].name) | join(", ");
    end;

    println(i"\nGet entry by key (ISBN) and make of it new object:");
    isbn:="978-1779501127";
    getData().booksByIsbn[isbn]
    | apply(x -> { "title" : x.title,
                   "authors" : authorIdsToDescr(getData(), x.authorIds) })
    | println();


    # Convert map to list of keys - use the subscript operator [] 
    println("\nGet list of all book isbns");
    println( getData().booksByIsbn | []["key"] );

    # Convert map to list of values
    println("\nGet list of all book entries from the map");
    println( getData().booksByIsbn | []["value"] );


    # Convert map to list of entries and get specific field
    println("\nConvert map to list of titles");
    getData().booksByIsbn |
        []["value"]["title"] |
        println();


    # Convert map to list of entries and build new object of each entry
    println("\nConvert map to list of titles and autors");
    getData().booksByIsbn |
        []["value"] |
        map(x -> { "title" : x.title,
                   "authors" : authorIdsToDescr(getData(), x.authorIds) }) |
        println();


    # Build list of unique values of tags
    println("\nGet set of used tags");
    getData().booksByIsbn
    | []["value"]["tags"] | apply(f"append") | apply(f"hashset") | println();

    println("\nSearch full text of entries for ones that contains",
            " a string 'kernigan' and return book titles");
    getData().booksByIsbn[]["value"]
    | search "kernigan" | []["title"] | println();


    println("\nSearch entries for ones that have a title that contains a ",
            "string 'Programming Language'");
    getData().booksByIsbn[]["value"]
    | search title =~ "Programming Language" | []["title"]| println();


    println("\nSearch entries for ones that have title that match the regex ",
            "'^The ([A-Za-z0-9]+) Programming Language$'");
    getData().booksByIsbn[]["value"]
    | search title =~ r"^The ([A-Za-z0-9]+) Programming Language$"
    | []["title"]
    | println();

    println("\nSearch entries for ones that have tag 'Programming Language' ",
            "and published before year 1980");
    getData().booksByIsbn[]["value"]
    | search  publicationYear < 1980 and "programming languages" in tags
    | println();

    println("\nSearch entries for ones that have more than one author");
    getData().booksByIsbn[]["value"]
    | search  length(authorIds) >= 2 |  fields title, authorIds | println();

    println("\nSearch entries for ones that have available copies using ",
            "subsearch on array of book items");
    getData().booksByIsbn[]["value"]
    | search  (bookItems | search not isLent ) |  fields isbn,title | println();
end;



function getData () 
    return {
        "booksByIsbn": {
            "978-1779501127": {
                "isbn": "978-1779501127",
                "title": "Watchmen",
                "tags" : ["comics", "super hero", "alternate history"],
                "publicationYear": 1987,
                "authorIds": ["alan-moore", "dave-gibbons"],
                "bookItems": [
                    {
                        "id": "book-item-1",
                        "libId": "nyc-central-lib",
                        "isLent": true
                    },
                    {
                        "id": "book-item-2",
                        "libId": "nyc-central-lib",
                        "isLent": true
                    }
                ]
            },
            "979-8745274824": {
                "isbn": "979-8745274824",
                "title": "The Great Gatsby",
                "tags" : [ "american classics", "jazz age", "prohibition"],
                "publicationYear": 2021,
                "authorIds": ["scott-fitzgerald"],
                "bookItems": [
                    {
                        "id": "book-item-3",
                        "libId": "nyc-central-lib",
                        "isLent": true
                    },
                    {
                        "id": "book-item-4",
                        "libId": "nyc-central-lib",
                        "isLent": false
                    }
                ]
            },
            "978-0262510875": {
                "isbn": "978-0262510875",
                "title": "Structure and Interpretation of Computer Programs",
                "tags" : [ "programming languages",
                           "programming language design",
                           "lisp",
                           "scheme"],
                "publicationYear": 1996,
                "authorIds": ["harold-abelson", "jay-sussman"],
                "bookItems": [
                    {
                        "id": "book-item-5",
                        "libId": "nyc-central-lib",
                        "isLent": true
                    }
                ]
            },
            "978-0131103627": {
                "isbn": "978-0131103627",
                "title": "The C Programming Language",
                "publicationYear": 1978,
                "tags" : [ "programming languages", "C"],
                "authorIds": ["brian-kernigan", "dennis-ritchie"],
                "bookItems": [
                    {
                        "id": "book-item-6",
                        "libId": "nyc-central-lib",
                        "isLent": true
                    },
                    {
                        "id": "book-item-7",
                        "libId": "nyc-central-lib",
                        "isLent": true
                    }
                    
                ]
            },
            "The Go Programming Language": {
                "isbn": "978-0134190440",
                "title": "The Go Programming Language",
                "publicationYear": 2015,
                "tags" : [ "programming languages", "golang"],
                "authorIds": ["brian-kernigan", "alan-a-a-donovan"],
                "bookItems": [
                    {
                        "id": "book-item-8",
                        "libId": "nyc-central-lib",
                        "isLent": false
                    },
                    {
                        "id": "book-item-9",
                        "libId": "nyc-central-lib",
                        "isLent": false
                    }
                    
                ]
            }
        },
        "authorsById": {
            "jay-sussman": {
                "name": "Jay Sussman",
                "bookIsbns": ["978-0262510875"]
            },                        
            "harold-abelson": {
                "name": "Harold Abelson",
                "bookIsbns": ["978-0262510875"]
            },            
            "brian-kernigan": {
                "name": "Brian W. Kernigan",
                "bookIsbns": ["978-0131103627", "978-0134190440"]
            },
            "dennis-ritchie": {
                "name": "Dennis M. Ritchie",
                "bookIsbns": ["978-0131103627"]
            },            
            "scott-fitzgerald": {
                "name": "Scott Fitzgerald",
                "bookIsbns": ["979-8745274824"]
            },
            "alan-moore": {
                "name": "Alan Moore",
                "bookIsbns": ["978-1779501127"]
            },
            "dave-gibbons": {
                "name": "Dave Gibbons",
                "bookIsbns": ["978-1779501127"]
            },
            "alan-a-a-donovan": {
                "name" : "Alan A.A. Donovan",
                "bookIsbns": [ "978-0134190440" ]
            }
        }
    };
    
end;

main();
