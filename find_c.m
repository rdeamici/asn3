function calibration = find_c(P,Pc1)
    % convert nx2 matrix into 2nx1 single column matrix
    b = reshape(Pc1',[],1);
    
    % Build the linear system
    A = [];
    for i = 1:size(P,1)
        X = P(i,1);
        Y = P(i,2);
        Z = P(i,3);
        u = Pc1(i,1);
        v = Pc1(i,2);
        A = [A; X, Y, Z, 1, 0, 0, 0, 0, -u*X, -u*Y, -u*Z;
                0, 0, 0, 0, X, Y, Z, 1, -v*X, -v*Y, -v*Z];
    end
    % formula is A*x = b, where 
    % A is system of linear equations
    % x is unknown matrix
    % b is input 2D points
    C = A\b;
    C = [C;1]; % C(3,4) = 1
    % convert C from 12x1 to a 3x4 matrix
%     [c(1) c(2) c(3)
%      c(4) c(5) c(6) 
%      c(7) c(8) c(9)
%      c(10) c(11) 1]
    calibration = reshape(C,[],3)';
end
