function [l1,l2] = epipolar_lines(p1,e1,p2,e2)
    u = e1(1);
    v = e1(2);
    w = e1(3);
    e1x = [0 w -v; -w 0 u; v -u 0];
    l1 = e1x*p1;

    u = e2(1);
    v = e2(2);
    w = e2(3);
    e2x = [0 w -v; -w 0 u; v -u 0];
    l2 = e2x*p2;
end