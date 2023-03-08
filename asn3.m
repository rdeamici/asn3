% run('vlfeat/toolbox/vl_setup');
run('vlfeat/toolbox/vl_setup');
run('constants.m');
addpath('code');
% calibration_matricess = part2();
% size(calibrations)
% size(calibrations{1})

[s, masks, images, sift_features] = part1_setup(set1files, set1fileMasks);
% for i = 1:length(images)
    sift_features1 = sift_features(1,:);
    sift_features2 = sift_features(2,:);

    [frames_on_1, frames_on_2] = part1(images{1}, images{2}, masks{1}, masks{2}, sift_features1, sift_features2);
    whos Pc1_4177
    Pc1_4177
    whos P_set1
    P_set1
    C1 = find_c(P_set1,Pc1_4177);
    
    verbose = 1; % change to 0 to turn off debug printing
    [M, Q, R, T] = decompose_c(C1, verbose);
    % Pcs and Ps needs to be defined in 'constants.m'
    % calibration_matrices = part2(set1files, Pcs, Ps);
    % C1 = calibration_matrices{1};
    % C2 = calibration_matrices{2};
    % camera calibration matrices

    % plot camera position and orientation for C
    figure;
%     imshow(images{1});
    hold on;
    % plot camera position
    plot3(T(1), T(2), T(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    % plot camera orientation
    quiver3(T(1), T(2), T(3), R(1,1), R(2,1), R(3,1), 0.2, 'r', 'LineWidth', 2);
    quiver3(T(1), T(2), T(3), R(1,2), R(2,2), R(3,2), 0.2, 'g', 'LineWidth', 2);
    quiver3(T(1), T(2), T(3), R(1,3), R(2,3), R(3,3), 0.2, 'b', 'LineWidth', 2);
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Camera position and orientation for Camera calibration matrix for image 4177');
    hold off;

    [F, e1, e2] = fundmatrix(Pc1_4177_homog, Pc1_4178_homog);
    [features_on_epipole1, features_on_epipole2] = part3(F, s, images{1}, images{2}, frames_on_1, frames_on_2);