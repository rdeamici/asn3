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
    C1 = find_c(P_4177,Pc1_4177);
    % compute the RQ decomposition of C1
    M = C1(:,1:3);
    C4 = C1(:,4);

    [Q, R] = rq(M);
    T = compute_T(M,C4);
    % compute the reconstructed matrix C1
    C1_recon = [Q*R Q*R*T];

    % print the results
    %disp('Matrix C1:');
    %disp(C1);
    %disp('Matrix R:');
    %disp(R);
    %disp('Matrix Q:');
    %disp(Q);
    %disp('Matrix T:');
    %disp(T);
    %disp('Reconstructed matrix C:');
    %disp(C1_recon);
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