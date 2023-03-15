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
function threeDpts = estimate_depth(f1_matched,C1, f2_matched,C2)
%     whos points2d
%     whos Cs
    threeDpts = [];
    A = [];
    r11 = C1(1,:);
    r21 = C1(2,:);
    r31 = C1(3,:);
    r12 = C2(1,:);
    r22 = C2(2,:);
    r32 = C2(3,:);

    for i = 1:size(f1_matched,2)
        u1 = f1_matched(1,i);
        v1 = f1_matched(2,i);
        u2 = f2_matched(1,i);
        v2 = f2_matched(2,i);
        
        % derived from left camera
        row1 = u1*r31 - r11;
        row2 = v1*r31 - r21;

        % derived from right camera
        row3 = u2*r32 - r12;
        row4 = v2*r32 - r22;
        A = [row1;row2;row3;row4];
        b = [u1;v1;u2;v2];
        pt3d = A\b;
        
        X = pt3d(1);
        Y = pt3d(2);
        Z = pt3d(3);
        W = pt3d(4);
        x = abs(X/W);
        y = abs(Y/W);
        z = abs(Z/W);
        max_val = max([x,y,z]);
        if max_val < 250
            threeDpts = [threeDpts;[X,Y,Z,W]];
        end
    end
end