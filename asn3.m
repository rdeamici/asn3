clc;
close all;

run('vlfeat/toolbox/vl_setup');
run('constants.m');
addpath('code');
calibration_matricess = {};

point_cloud_sets = {};
trs = {};
for sf_idx = 1: 2
    verbose = 0; % change to 0 to turn off debug printing
    img_idx = 2;
    
    if sf_idx == 1
        setFiles = set1files;
        setfileMasks = set1fileMasks;
        Pc1 = Pc1_4177;
        Pc1_homog = Pc1_4177_homog;
        Pc2 = Pc1_4178;
        Pc2_homog = Pc1_4178_homog;
        Pcs = {Pc1_4177; Pc1_4178; Pc1_4179; Pc1_4180; Pc1_4181};
        P_set = P_set1;    
    else
        setFiles = set2files;
        setfileMasks = set2fileMasks;
        Pc1 = Pc1_4195;
        Pc1_homog = Pc1_4195_homog;
        Pc2 = Pc1_4196;
        Pc2_homog = Pc1_4196_homog;
        Pcs = {Pc1_4195; Pc1_4196; Pc1_4197; Pc1_4198; Pc1_4199};
        P_set = P_set2;
    end

    [s, masks, images, sift_features] = part1_setup(setFiles, setfileMasks);
    sift_features1 = sift_features(1,:);
    sift_features2 = sift_features(img_idx,:);
    [frames_on_1, frames_on_2] = part1(images{1}, images{img_idx}, masks{1}, masks{img_idx}, sift_features1, sift_features2, sf_idx);
    
    calibration_matrices = part2(setFiles, Pcs, P_set, verbose);
    C1 = calibration_matrices{1};
    decomposed_Cs = decompose_Cs(calibration_matrices, verbose);
    decomp_C1 = decomposed_Cs{1};
    M = decomp_C1{1};
    Q = decomp_C1{2};
    R = decomp_C1{3};
    T = decomp_C1{4};
    trs{end+1} = {T,R};
    point_cloud_homog = create_point_cloud(calibration_matrices,sift_features, images, masks, sf_idx);
    point_cloud_cart = point_cloud_homog(:,1:3) ./ point_cloud_homog(:,4);
    point_cloud_sets{end+1} = point_cloud_cart;
%     point_cloud_cart    
    [F, e1, e2] = fundmatrix(Pc1_4177_homog, Pc2_homog);
    % [features_on_epipole1, features_on_epipole2] = part3(F, e1, e2, s, images{1}, images{img_idx}, frames_on_1, frames_on_2);
end

% plot camera position and orientation for C1
figure;
t1 = trs{1}{1};
r1 = trs{1}{2};
ptCl1 = point_cloud_sets{1};

t2 = trs{2}{1};
r2 = trs{2}{2};
ptCl2 = point_cloud_sets{2};

plot3(t1(1), t1(2), t1(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
hold on;
plot3(ptCl1(:,1), ptCl1(:,2), ptCl1(:,3),'o', 'MarkerSize',8, 'LineWidth',2);
% plot camera orientation
quiver3(t1(1), t1(2), t1(3), r1(1,1), r1(2,1), r1(3,1),100, 'r', 'LineWidth', 2);
quiver3(t1(1), t1(2), t1(3), r1(1,2), r1(2,2), r1(3,2),100, 'g', 'LineWidth', 2);
quiver3(t1(1), t1(2), t1(3), r1(1,3), r1(2,3), r1(3,3),100, 'b', 'LineWidth', 2);

axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('results from image set 1');
grid on;
hold off;

% plot camera position and orientation for C1

figure;
plot3(t1(1), t1(2), t1(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
hold on;
plot3(ptCl1(:,1), ptCl1(:,2), ptCl1(:,3),'ro', 'MarkerSize',8, 'LineWidth',2);
% plot camera orientation
quiver3(t1(1), t1(2), t1(3), r1(1,1), r1(2,1), r1(3,1),1000, 'r', 'LineWidth', 2);
quiver3(t1(1), t1(2), t1(3), r1(1,2), r1(2,2), r1(3,2),1000, 'r', 'LineWidth', 2);
quiver3(t1(1), t1(2), t1(3), r1(1,3), r1(2,3), r1(3,3),1000, 'r', 'LineWidth', 2);

plot3(t2(1), t2(2), t2(3), 'bo', 'MarkerSize', 10, 'LineWidth', 2);
plot3(ptCl2(:,1), ptCl2(:,2), ptCl2(:,3),'bo', 'MarkerSize',8, 'LineWidth',2);
% plot camera orientation
quiver3(t2(1), t2(2), t2(3), r2(1,1), r2(2,1), r2(3,1),1000, 'b', 'LineWidth', 2);
quiver3(t2(1), t2(2), t2(3), r2(1,2), r2(2,2), r2(3,2),1000, 'b', 'LineWidth', 2);
quiver3(t2(1), t2(2), t2(3), r2(1,3), r2(2,3), r2(3,3),1000, 'b', 'LineWidth', 2);

% axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('results from both sets of images');
grid on;


    