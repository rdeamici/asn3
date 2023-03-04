% run('vlfeat/toolbox/vl_setup');
run('constants.m');
% calibration_matricess = part2();
% size(calibrations)
% size(calibrations{1})

[s, masks, images, sift_features] = part1_setup(set1files, set1fileMasks);

part1(images, sift_features, masks)

% PART 1
function [s, masks, images, sift_features] = part1_setup(imagefiles, maskfiles)
    masks = cell(length(imagefiles), 1);
    images = cell(length(imagefiles), 1);
    sift_features = cell(length(imagefiles), 2);
    
    % Read in the images using imread and create binary masks using imbinarize
    for i = 1:length(imagefiles)
        i
        filename = imagefiles{i};
        img = imread(filename);
        images{i} = rgb2gray(img);
        single_gray_image = single(rgb2gray(img));
        
        % compute SIFT features
        [frames, descriptors] = vl_sift(single_gray_image);
        sift_features{i, 1} = frames;
        sift_features{i, 2} = descriptors;
        
        % create binary mask from mask file
        mask = rgb2gray(imread(maskfiles{i}));
        mask = mask>0;
        masks{i} = mask;
    end
    
    s = size(images{1});    
end

function [frames_on_object1, frames_on_object2] = part1(images, sift_features, masks)
    for i=1:numel(images)-1
        i
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
        imshow(image1);
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