### Quicksort

function swap(a, i, j) 
    "swap two elements in an indexable sequence";
    tmp := a[i];
    a[i] := a[j];
    a[j] := tmp;
end;


function random_list(size, maxr)
    "make list of length size of random number from 0 upto maxr";
    map( x -> random(maxr), range(0, size));
end;

function partition(a, lo, hi)
    "partition part of an indexable sequence a";
    pivot := a[hi];
    i := lo;
    j := lo;
    while j < hi
        if a[j] < pivot 
            swap(a, i, j);
            i := i + 1;
        end;
        j := j + 1;
    end;
    swap(a, i, hi);
    i;
end;

function quick_sort (a, lo, hi)    
    "quick sort an indexable sequence or part of it if lo and hi parameters are set";
    if lo < hi
        p := partition(a, lo, hi);
        quick_sort(a, lo,    p - 1);
        quick_sort(a, p + 1, hi);
    end;
    a;
end;

# create list of lists/arrays/character sequences to be sorted
samples := [
    ## list of random integers
    random_list(32, 100), 
    ## Array of objects
    append(make_array(0), random_list(32,100)),                
    ## list of Characters
    append([], "pack my box with five dozen liquor jugs"), 
    ## list of versions
    [v"0.1.2",  v"0.1.2-pre1", v"0.1.2-pre2", v"0.1.3", v"0.1.2-pre1+10", v"1.2.3"] 
];

for data in  samples
    print(i"Using quick sort on:  $(type_of(data))\n");
    print(i"input=$(data)\n");
    quick_sort(data, 0, length(data) - 1);
    print(i"output=$(data)\n\n");
end;
           
