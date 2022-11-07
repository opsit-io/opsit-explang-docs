### The 8 Queens Problem

N := 8;
solutions := [];

function print_solution(s)
    for i in range(0, N)
	    for  j in  range(0, N)
            print(if s[i] == j "♕"; else "-"; end);
        end;
	    println();
    end;
    println();
end;

function check_placement(a, n, c)
    "Check if placement (n c) is free from attacks from queens in board a.";
    for i in range(0, n) result true  # loop returns true unless 
	    pos:=a[i];                    # return is called inside
	    if pos = c                  # same column?
		    or  pos - i = c - n     # same diagonal
		    or  pos + i = c + n     # same diagonal		     
		    return(false);
        end;
    end;
end;

function add_queen(a, n)
    "Add to board a all queens from n up to N";
    if n >= N
        push!(solutions, copy(a)); # all queens have been placed,
    else
        for c in range(0,N)    # try to place next queen
	        if (check_placement(a, n, c))
		        a[n] := c;
		        add_queen(a, n + 1);
            end;
        end;
    end;
end;

# # position: list of integers that represent queen position in a row
add_queen([], 0);

println(i"Found $(length(solutions)) solutions");
println("First solution:");
print_solution(first(solutions));

