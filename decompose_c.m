function [M,Q,R,T] = decompose_c(C, verbose)
    M = C(:,1:3);
    C4 = C(:,4);
    [Q, R] = rq(M);
    T = compute_T(M,C4);
    
    % print the results to verify its working correctly
    if verbose == 1
        % compute the reconstructed matrix C1
        C_recon = [Q*R Q*R*T];
        disp('Matrix C:');
        disp(C);
        disp('Matrix R:');
        disp(R);
        disp('Matrix Q:');
        disp(Q);
        disp('Matrix T:');
        disp(T);
        disp('Reconstructed matrix C:');
        disp(C_recon);
    end
end