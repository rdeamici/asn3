function [l1,l2] = epipolar_lines(F,p1,p2)
    l2 = F*p1;
    l1 = F'*p2;
end