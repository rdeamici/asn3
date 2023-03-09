function decomposed_Cs = decompose_Cs(Cs, verbose)
    decomposed_Cs = {};
    for i = 1: size(Cs,1)
        C = Cs{i};
        [M,Q,R,T] = decompose_c(C,verbose);
        decomposed_Cs{end+1} = {M,Q,R,T};
    end
end