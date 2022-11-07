### Factorial (lazy sequence)

function fact(n)
    "Compute factorial";
    apply(f"*", range(1, n + 1));
end;
        
print(i"5! = $(fact(5))\n");
