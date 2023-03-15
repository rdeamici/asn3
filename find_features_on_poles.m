function [features_on_epipole1, features_on_epipole2] = find_features_on_poles(s, f1, f2, fundMat, e1, e2, image1, image2, imFilename1, imFilename2)
    features_on_epipole1 = [];
    features_on_epipole2 = [];
    lines_on_2 = [];
    points_on_1 = [];
    distances = [];
    % Define the range of x-coordinates
    x = 1:s(2);
    
    for i = 1:size(f1,2)
        feat1 = f1(:,i);
        p1 = [feat1(1);feat1(2);1];
    
        feat2 = f2(:,i);
        p2 = [feat2(1);feat2(2);1];
        
        [l1,l2] = epipolar_lines(p1, e1, p2, e2);
        
        % determine if p2 lies on epipolar line l1
        thresh = 0.35;
        dist1 = abs(p2'*fundMat*p1);
        if dist1 < thresh
            % Convert the epipolar lines to slope-intercept form
            m1 = -l1(1)/l1(2);
            b1 = -l1(3)/l1(2);
        
            m2 = -l2(1)/l2(2);
            b2 = -l2(3)/l2(2);
            % Calculate the corresponding y-coordinates for each line
            y1 = m1 * x + b1;
            y2 = m2 * x + b2;
                
            points_on_1 = [points_on_1; p1'];
            lines_on_2 = [lines_on_2; y2];
            distances = [distances; dist1];

            features_on_epipole1 = [features_on_epipole1 feat1]; 
            features_on_epipole2 = [features_on_epipole2 feat2]; 
        end
    end  
    [distances_sorted, idx_in_orig] = sort(distances);
    
%     points_on_1 = points_on_1(idx_in_orig,:);
%     lines_on_2 = lines_on_2(idx_in_orig,:);
%     figure;
%     imshow(image1);
%     title(strrep(imFilename1, '\', '\\'));
%     hold on;
% %     for i = 76:76
%      x1 = points_on_1(1,1);
%      y1 = points_on_1(1,2);
%      plot(x1, y1, 'ro', 'MarkerSize',10, 'LineWidth',3);
% %     end
%     hold off;
% 
%     figure;
%     imshow(image2);
%     title(strrep(imFilename2, '\', '\\'));
%     hold on;
% %     for i = 76:76
%     y = lines_on_2(1,:);
%     line(x, y, 'Color', 'g', 'LineWidth',2);
% %     end
%     hold off;
            
end