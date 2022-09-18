### Frequency Table
### prints sorted frequency table for a sequence

function  freqcount(seq)
    ## create map of counters
    m := hashmap();
    ## for each  word in text that matches pattern
    for  word in  seq
        m[word] := m[word] + 1;
    end;
    ## sort list of Map Entries by their values
    sort((a, b) -> b.value - a.value,  append([], m));
end;

txt:= "If in this heart a hope be dear,
       ⁠That sound shall charm it forth again:
       If in these eyes there lurk a tear,
       ⁠'Twill flow, and cease to burn my brain";

wordlist := map(f"lowercase", append([], re_seq(r"\w+", txt)));
wordfreq := freqcount(wordlist);

print(i"Word frequency table for text
        $(txt)
$(wordfreq)\n\n");

charfreq := freqcount(txt);
print (i"Character frequency table for text
        $(txt)
$(charfreq)\n\n");


## make array of random integers
numbers := map( x -> random(10), make_array(size:=20));
numbersfreq := freqcount( numbers );
print (i"Frequency table for array of numbers
        $(numbers)
$(numbersfreq)\n\n");



