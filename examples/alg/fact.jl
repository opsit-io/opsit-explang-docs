function fact(n)
    "Compute factorial";
    if n  fact(n - 1) * n  else  1;  end;
end;
        
print(i"5! = $(fact(5))\n");
