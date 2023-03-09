% from page 183 in Intro to Visual Computing
% epipolar line l2 = Fp1
% epipolar line l1 = trans(F)p2
function [features_on_epipole1, features_on_epipole2] = part3(F, e1, e2, s, image1, image2, frames_on_1, frames_on_2)
    whos frames_on_1
    whos frames_on_2
    features_on_epipole1 = [];
    features_on_epipole2 = [];
    lines_on_2 = [];
    points_on_1 = [];
    distances = [];
    % Define the range of x-coordinates
    % x = 1:size(im,2);
    x = 1:s(2);
%     whos x;
    for i = 1:size(frames_on_2,2)
        feat1 = frames_on_1(:,i);
        feat2 = frames_on_2(:,i);
        
        x1 = feat1(1);
        y1 = feat1(2);
        p1 = [x1;y1;1];
    
        x2 = feat2(1);
        y2 = feat2(2);
        p2 = [x2;y2;1];
        
        [l1,l2] = epipolar_lines(p1, e1, p2, e2);
        % determine if p2 lies on epipolar line l1
        thresh = 5.5;
        dist1 = abs(p2'*F*p1);
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
    end        % Draw the epipolar lines on top of the image
    
%     whos points_on_1
%     whos lines_on_2
%     whos distances
    % sort points and lines based on distances
    [distances_sorted, idx_in_orig] = sort(distances);
    points_on_1 = points_on_1(idx_in_orig,:);
    lines_on_2 = lines_on_2(idx_in_orig,:);
    figure;
    imshow(image1);
    title('image 4177 with feature points')
    hold on;
    for i = 76:76
        x1 = points_on_1(i,1);
        y1 = points_on_1(i,2);
        plot(x1, y1, 'r.', 'MarkerSize',10);
    end
    hold off;

    figure;
    imshow(image2);
    title('image 4180 with epipolar lines')
    hold on;
    for i = 76:76
        y = lines_on_2(i,:);
        line(x, y, 'Color', 'g');
    end
    hold off;
end