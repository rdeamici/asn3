% formula is Pci = Ci*P
% 2D image points Pci = [u;v;w] = [u/w,v/w]
% Ci = [r1;r2;r3] 3x4 matrix
% u(r3.P) - r1.P = 0
% v(r3.P) - r2.P = 0

% many feature points exist on each image
% a single calibration matrix corresponds to a single image
% given a collection of 2D points from all the images
% mapped to the same single 3D point
% loop over all 2D point/Calibration matrix pairs, and solve for P
% C will have n matrices
% points2d will have n (u,v) points
% A will then have 2n rows and 4 columns
% therefore, b must also have 2n rows.
% multiplying a 2nx4 matrix by a 4x1 matrix
% will yield a 2nx1 matrix
function [X,Y,Z,W] = estimate_depth(points2d, Cs)
%     whos points2d
%     whos Cs
    A = [];
    b = reshape(points2d',[],1);
    for i = 1:size(Cs,2)
        C = Cs{i};
        r1 = C(1,:);
        r2 = C(2,:);
        r3 = C(3,:);
        
        point = points2d(i,:);
        u = point(1);
        v = point(2);

        row1 = u*r3 - r1;
        row2 = v*r3 - r2;
        A = [A;row1;row2];
    end
    point3d = A\b;
    whos point3d;
    X = point3d(1);
    Y = point3d(2);
    Z = point3d(3);
    W = point3d(4);
end