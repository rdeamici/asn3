% from page 183 in Intro to Visual Computing
% epipolar line l2 = Fp1
% epipolar line l1 = trans(F)p2
function [features_on_epipole1, features_on_epipole2] = part3(F, s, image1, image2, features_on_1, features_on_2)
    length(features_on_1)
    features_on_epipole1 = [];
    features_on_epipole2 = [];
    for i = 1:size(features_on_1,2)
        feat1 = features_on_1(:,i);
        feat2 = features_on_2(:,i);
        
        x1 = feat1(1);
        y1 = feat1(2);
        p1 = [x1;y1;1];
    
        x2 = feat2(1);
        y2 = feat2(2);
        p2 = [x2;y2;1];

        [l1,l2] = epipolar_lines(F,p1,p2);
        
        % Convert the epipolar lines to slope-intercept form
        m1 = -l1(1)/l1(2);
        b1 = -l1(3)/l1(2);
        
        m2 = -l2(1)/l2(2);
        b2 = -l2(3)/l2(2);
        
        % Define the range of x-coordinates
        % x = 1:size(im,2);
        x = 1:s(2);
        
        % Calculate the corresponding y-coordinates for each line
        y1 = m1 * x + b1;
        y2 = m2 * x + b2;
        
        % Draw the epipolar lines on top of the image
        if i == 1
            figure, imshow(image1);
            hold on;
            line(x, y1, 'Color', 'r');
            hold off;
            figure, imshow(image2);
            hold on;
            line(x, y2, 'Color', 'g');
            hold off;
        end

        thresh = .015;
        dist1 = abs(p2'*F*p1);
        dist2 = abs(p1'*F'*p2);
    
        % determine if p2 lies on epipolar line l1
        if dist1 < thresh
            i
            disp("p2 and p1 are on the epipolar line of the corresponding feature")
            p1
            p2
            dist1
            features_on_epipole1 = [features_on_epipole1 feat1]; 
            features_on_epipole2 = [features_on_epipole2 feat2]; 
        end

end