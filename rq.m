function [R,Q] = rq(M)

    M = M';
    [Q,R] = qr(M(end:-1:1,end:-1:1));
    Q = Q';
    Q = Q(end:-1:1,end:-1:1);
    R = R';
    R = R(end:-1:1,end:-1:1);
    
    if det(Q)<0
      R(:,1) = -R(:,1);
      Q(1,:) = -Q(1,:);
    end

end