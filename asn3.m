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
        Pcs = {Pc1_4177; Pc1_4178; Pc1_4179; Pc1_4180};
        Pc_homogs = {Pc1_4177_homog; Pc1_4178_homog; Pc1_4179_homog; Pc1_4180_homog};
        P_set = P_set1;    
    else
        setFiles = set2files;
        setfileMasks = set2fileMasks;
        Pc1 = Pc1_4195;
        Pc1_homog = Pc1_4195_homog;
        Pc2 = Pc1_4196;
        Pc2_homog = Pc1_4196_homog;
        Pcs = {Pc1_4195; Pc1_4196; Pc1_4197; Pc1_4198};
        Pc_homogs = {Pc1_4195_homog; Pc1_4196_homog; Pc1_4197_homog; Pc1_4198_homog};
        P_set = P_set2;
    end

    [s, images, masks, sift_features] = setup(setFiles, setfileMasks);
    matching_pairs = part1(setFiles, images, masks, sift_features);
    
    calibration_matrices = part2(setFiles, Pcs, P_set, verbose);
    
    frames_pairs = part3(images, setFiles, Pc_homogs, matching_pairs, s, sf_idx);
    
    for i = 1:size(calibration_matrices,2)
        [M,Q,R,T] = decompose_c(calibration_matrices{i},verbose);
        trs{end+1} = {T,R};
    end

    point_cloud_homog = create_point_cloud(calibration_matrices, frames_pairs, images);
    point_cloud_cart = point_cloud_homog(:,1:3) ./ point_cloud_homog(:,4);
    point_cloud_sets{end+1} = point_cloud_cart;

end
% whos point_cloud_sets
% plot camera position and orientation for set1
t11 = trs{1}{1};
r11 = trs{1}{2};
ptCloud1 = point_cloud_sets{1};
whos ptCloud1;
disp(round(ptCloud1))
    
t21 = trs{2}{1};
r21 = trs{2}{2};
ptCloud2 = point_cloud_sets{2};
whos ptCloud2;
disp(round(ptCloud2))

t31 = trs{3}{1};
r31 = trs{3}{2};

t41 = trs{4}{1};
r41 = trs{4}{2};

% hold on;
figure;
plot3(ptCloud1(:,1), ptCloud1(:,2), ptCloud1(:,3),'o', 'MarkerSize',6, 'LineWidth',1);
hold on;
% plot camera orientation
plot3(t11(1), t11(2), t11(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
quiver3(t11(1), t11(2), t11(3), r11(1,1), r11(2,1), r11(3,1),100, 'b', 'LineWidth', 2);
quiver3(t11(1), t11(2), t11(3), r11(1,2), r11(2,2), r11(3,2),100, 'b', 'LineWidth', 2);
quiver3(t11(1), t11(2), t11(3), r11(1,3), r11(2,3), r11(3,3),100, 'b', 'LineWidth', 2);

plot3(t21(1), t21(2), t21(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
quiver3(t21(1), t21(2), t21(3), r21(1,1), r21(2,1), r21(3,1),100, 'b', 'LineWidth', 2);
quiver3(t21(1), t21(2), t21(3), r21(1,2), r21(2,2), r21(3,2),100, 'b', 'LineWidth', 2);
quiver3(t21(1), t21(2), t21(3), r21(1,3), r21(2,3), r21(3,3),100, 'b', 'LineWidth', 2);

plot3(t31(1), t31(2), t31(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
quiver3(t31(1), t31(2), t31(3), r31(1,1), r31(2,1), r31(3,1),100, 'b', 'LineWidth', 2);
quiver3(t31(1), t31(2), t31(3), r31(1,2), r31(2,2), r31(3,2),100, 'b', 'LineWidth', 2);
quiver3(t31(1), t31(2), t31(3), r31(1,3), r31(2,3), r31(3,3),100, 'b', 'LineWidth', 2);

plot3(t41(1), t41(2), t41(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
quiver3(t41(1), t41(2), t41(3), r41(1,1), r41(2,1), r41(3,1),100, 'b', 'LineWidth', 2);
quiver3(t41(1), t41(2), t41(3), r41(1,2), r41(2,2), r41(3,2),100, 'b', 'LineWidth', 2);
quiver3(t41(1), t41(2), t41(3), r41(1,3), r41(2,3), r41(3,3),100, 'b', 'LineWidth', 2);

axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
% xlim([-400,400]);
% ylim([-400,400]);
% zlim([-400,400]);
title('results from image set 1');
grid on;
% hold off;

t12 = trs{5}{1};
r12 = trs{5}{2};

t22 = trs{6}{1};
r22 = trs{6}{2};

t32 = trs{7}{1};
r32 = trs{7}{2};

t42 = trs{8}{1};
r42 = trs{8}{2};


figure;
plot3(ptCloud2(:,1), ptCloud2(:,2), ptCloud2(:,3),'o', 'MarkerSize',8, 'LineWidth',2);
hold on;
% plot camera orientation
plot3(t12(1), t12(2),t12(3), 'ro', 'MarkerSize',12, 'LineWidth', 4);
plot3(t22(1), t22(2),t22(3), 'ro', 'MarkerSize',12, 'LineWidth', 4);
plot3(t32(1), t32(2),t32(3), 'ro', 'MarkerSize',12, 'LineWidth', 4);
plot3(t42(1), t42(2),t42(3), 'ro', 'MarkerSize',12, 'LineWidth', 4);
quiver3(t12(1), t12(2), t12(3), r12(1,1), r12(2,1), r12(3,1),100, 'b', 'LineWidth', 2);
quiver3(t12(1), t12(2), t12(3), r12(1,2), r12(2,2), r12(3,2),100, 'b', 'LineWidth', 2);
quiver3(t12(1), t12(2), t12(3), r12(1,3), r12(2,3), r12(3,3),100, 'b', 'LineWidth', 2);

quiver3(t22(1), t22(2), t22(3), r22(1,1), r22(2,1), r22(3,1),100, 'b', 'LineWidth', 2);
quiver3(t22(1), t22(2), t22(3), r22(1,2), r22(2,2), r22(3,2),100, 'b', 'LineWidth', 2);
quiver3(t22(1), t22(2), t22(3), r22(1,3), r22(2,3), r22(3,3),100, 'b', 'LineWidth', 2);

quiver3(t32(1), t32(2), t32(3), r32(1,1), r32(2,1), r32(3,1),100, 'b', 'LineWidth', 2);
quiver3(t32(1), t32(2), t32(3), r32(1,2), r32(2,2), r32(3,2),100, 'b', 'LineWidth', 2);
quiver3(t32(1), t32(2), t32(3), r32(1,3), r32(2,3), r32(3,3),100, 'b', 'LineWidth', 2);

quiver3(t42(1), t42(2), t42(3), r42(1,1), r42(2,1), r42(3,1),100, 'b', 'LineWidth', 2);
quiver3(t42(1), t42(2), t42(3), r42(1,2), r42(2,2), r42(3,2),100, 'b', 'LineWidth', 2);
quiver3(t42(1), t42(2), t42(3), r42(1,3), r42(2,3), r42(3,3),100, 'b', 'LineWidth', 2);

axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('results from image set 2');
grid on;
hold off;

% plot camera position and orientation for C1

figure;
% plot3(t1(1), t1(2), t1(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
plot3(ptCloud1(:,1), ptCloud1(:,2), ptCloud1(:,3),'ro', 'MarkerSize',8, 'LineWidth',2);
hold on;
% plot camera orientation
% plot3(t11(1), t11(2), t11(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
% quiver3(t11(1), t11(2), t11(3), r11(1,1), r11(2,1), r11(3,1),100, 'b', 'LineWidth', 2);
% quiver3(t11(1), t11(2), t11(3), r11(1,2), r11(2,2), r11(3,2),100, 'b', 'LineWidth', 2);
% quiver3(t11(1), t11(2), t11(3), r11(1,3), r11(2,3), r11(3,3),100, 'b', 'LineWidth', 2);
% 
% plot3(t21(1), t21(2), t21(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
% quiver3(t21(1), t21(2), t21(3), r21(1,1), r21(2,1), r21(3,1),100, 'b', 'LineWidth', 2);
% quiver3(t21(1), t21(2), t21(3), r21(1,2), r21(2,2), r21(3,2),100, 'b', 'LineWidth', 2);
% quiver3(t21(1), t21(2), t21(3), r21(1,3), r21(2,3), r21(3,3),100, 'b', 'LineWidth', 2);
% 
% plot3(t31(1), t31(2), t31(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
% quiver3(t31(1), t31(2), t31(3), r31(1,1), r31(2,1), r31(3,1),100, 'b', 'LineWidth', 2);
% quiver3(t31(1), t31(2), t31(3), r31(1,2), r31(2,2), r31(3,2),100, 'b', 'LineWidth', 2);
% quiver3(t31(1), t31(2), t31(3), r31(1,3), r31(2,3), r31(3,3),100, 'b', 'LineWidth', 2);
% 
% plot3(t41(1), t41(2), t41(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
% quiver3(t41(1), t41(2), t41(3), r41(1,1), r41(2,1), r41(3,1),100, 'b', 'LineWidth', 2);
% quiver3(t41(1), t41(2), t41(3), r41(1,2), r41(2,2), r41(3,2),100, 'b', 'LineWidth', 2);
% quiver3(t41(1), t41(2), t41(3), r41(1,3), r41(2,3), r41(3,3),100, 'b', 'LineWidth', 2);

% plot3(t2(1), t2(2), t2(3), 'bo', 'MarkerSize', 10, 'LineWidth', 2);
plot3(ptCloud2(:,1), ptCloud2(:,2), ptCloud2(:,3),'bo', 'MarkerSize',8, 'LineWidth',2);
% plot camera orientation
% plot3(t12(1), t12(2),t12(3), 'ro', 'MarkerSize',12, 'LineWidth', 4);
% plot3(t22(1), t22(2),t22(3), 'ro', 'MarkerSize',12, 'LineWidth', 4);
% plot3(t32(1), t32(2),t32(3), 'ro', 'MarkerSize',12, 'LineWidth', 4);
% plot3(t42(1), t42(2),t42(3), 'ro', 'MarkerSize',12, 'LineWidth', 4);
% quiver3(t12(1), t12(2), t12(3), r12(1,1), r12(2,1), r12(3,1),100, 'b', 'LineWidth', 2);
% quiver3(t12(1), t12(2), t12(3), r12(1,2), r12(2,2), r12(3,2),100, 'b', 'LineWidth', 2);
% quiver3(t12(1), t12(2), t12(3), r12(1,3), r12(2,3), r12(3,3),100, 'b', 'LineWidth', 2);
% 
% quiver3(t22(1), t22(2), t22(3), r22(1,1), r22(2,1), r22(3,1),100, 'b', 'LineWidth', 2);
% quiver3(t22(1), t22(2), t22(3), r22(1,2), r22(2,2), r22(3,2),100, 'b', 'LineWidth', 2);
% quiver3(t22(1), t22(2), t22(3), r22(1,3), r22(2,3), r22(3,3),100, 'b', 'LineWidth', 2);
% 
% quiver3(t32(1), t32(2), t32(3), r32(1,1), r32(2,1), r32(3,1),100, 'b', 'LineWidth', 2);
% quiver3(t32(1), t32(2), t32(3), r32(1,2), r32(2,2), r32(3,2),100, 'b', 'LineWidth', 2);
% quiver3(t32(1), t32(2), t32(3), r32(1,3), r32(2,3), r32(3,3),100, 'b', 'LineWidth', 2);
% 
% quiver3(t42(1), t42(2), t42(3), r42(1,1), r42(2,1), r42(3,1),100, 'b', 'LineWidth', 2);
% quiver3(t42(1), t42(2), t42(3), r42(1,2), r42(2,2), r42(3,2),100, 'b', 'LineWidth', 2);
% quiver3(t42(1), t42(2), t42(3), r42(1,3), r42(2,3), r42(3,3),100, 'b', 'LineWidth', 2);
% 
% axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('results from both sets of images');
grid on;