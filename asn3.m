
P =        [0,48,48; 32,48,48; 32,80,48; 0,48,67; 32,48,67; 32,80,67];
Pc1_4177 = [424,912;  661,994;  841,823; 383,771;  634,848;  815,680];

U=[];
S=[];
V=[];
C=[];
C = find_c(P,Pc1_4177);
disp('camera calibration matrix:')
disp(C)

[Projected_2D_Pts, Residual] = evaluate_points( C, Pc1_4177, P);
fprintf('\nThe total residual is: <%.4f>\n\n',Residual);

visualize_points(Pc1_4177,Projected_2D_Pts);

function calibration = find_c(P,Pc1)
    % convert 6x2 matrix into 12x1 single column matrix
    b = reshape(Pc1',[],1);
    
    % Build the linear system
    A = [];
    for i = 1:size(P,1)
        X = P(i,1);
        Y = P(i,2);
        Z = P(i,3);
        u = Pc1(i,1);
        v = Pc1(i,2);
        A = [A; X, Y, Z, 1, 0, 0, 0, 0, -u*X, -u*Y, -u*Z;
                0, 0, 0, 0, X, Y, Z, 1, -v*X, -v*Y, -v*Z];
    end
    A
    % Solve for the camera calibration matrix
    % formula is A*x = b, where 
    % A is system of linear equations
    % x is unknown matrix
    % b is input 2D points
    C = A\b;
    C = [C;1];
    calibration = reshape(C,[],3)
    size(calibration)
    calibration = calibration'
    size(calibration)
end

% PART 1
function s = part1_setup
    set1files = {'data\DSCF4177.jpg', 'data\DSCF4178.jpg', 'data\DSCF4179.jpg',...
                'data\DSCF4180.jpg','data\DSCF4186.jpg', 'data\DSCF4187.jpg'};
    set1fileMasks = {'data\DSCF4177Mask.jpg', 'data\DSCF4178Mask.jpg', 'data\DSCF4179Mask.jpg', ...
               'data\DSCF4180Mask.jpg','data\DSCF4186Mask.jpg', 'data\DSCF4187Mask.jpg'};
    
    masks = cell(length(set1files), 1);
    images = cell(length(set1files), 1);
    sift_features = cell(length(set1files), 2);
    
    % Read in the images using imread and create binary masks using imbinarize
    for i = 1:numel(set1files)
        img = imread(set1files{i});
        images{i} = rgb2gray(img);
        single_gray_image = single(rgb2gray(img));
        
        % compute SIFT features
        [frames, descriptors] = vl_sift(single_gray_image, 'PeakThresh',0);
        sift_features{i, 1} = frames;
        sift_features{i, 2} = descriptors;
        
        % create binary mask from mask file
        mask = rgb2gray(imread(set1fileMasks{i}));
        mask = mask>0;
        masks{i} = mask;
    end
    
    s = size(images{1});    
end

function [frames_on_object1, frames_on_object2] = part1(images, sift_features, masks)
    for i=1:numel(images)-1
        image1 = images{i};
        mask1 = masks{i};
        image2 = images{i+1};
        mask2 = masks{i+1};
    
        frames1 = sift_features{i,1};
        frames2 = sift_features{i+1,1};
        descriptors1 = sift_features{i,2};
        descriptors2 = sift_features{i+1,2};
    
    
        % compute matches
        [matches, scores] = vl_ubcmatch(descriptors1, descriptors2);
        % sort matches based on the associated scores
        [scores_sorted, idx_in_orig] = sort(scores);
        matches_sorted = matches(:, idx_in_orig);
        
        % remove matches with very low scores
    %     below_thresh = scores_sorted < 1000;
    %     matches_sorted = matches_sorted(:, below_thresh);
        
        % get all frames from f1 and f2 that are associated with a match
        matches1 = matches_sorted(1,:);
        matches2 = matches_sorted(2,:);
        f1_matches = frames1(:, matches1);
        f2_matches = frames2(:, matches2);
    %     whos f2_matches
        figure, imshow(image1);
        vl_plotframe(f1_matches);
        figure, imshow(image2);
        vl_plotframe(f2_matches);
    
        % remove SIFT features which are not on the object
        f1_mask = mask1(sub2ind(size(mask1), round(f1_matches(2,:)), round(f1_matches(1,:))));
        frames_on_object1 = f1_matches(:,f1_mask);
        f2_mask = mask2(sub2ind(size(mask2), round(f2_matches(2,:)), round(f2_matches(1,:))));
        frames_on_object2 = f2_matches(:,f2_mask);
        figure, imshow(image1);
        vl_plotframe(frames_on_object1);
        figure, imshow(image2);
        vl_plotframe(frames_on_object2);
    end
end

function [top, left, bottom, right] = pixel_indices_within_range_of_feature(frame, s)
    row = frame(1);
    col = frame(2);
    rad = frame(3);

    % Determine edges of the box
    left = floor(col - rad);
    right = ceil(col + rad);
    top = floor(row - rad);
    bottom = ceil(row + rad);
    
    % Adjust edges to image boundaries
    rows = s(1);
    cols = s(2);
    left = max(1, left);
    right = min(cols, right);
    top = max(1, top);
    bottom = min(rows, bottom);
end

function [valid_frames, valid_descriptors] = find_valids(frames, descriptors, mask1, mask2)
    valid_frames = [];
    valid_descriptors = [];
    for i = 1:size(frames, 2)
        row = round(frames(2,i));
        col = round(frames(1,i));
        if mask1(row,col) == 1 || mask2(row,col) == 1
            valid_frames = [valid_frames, frames(:,i)];
            valid_descriptors = [valid_descriptors, descriptors(:,i)];
        end
    end
end