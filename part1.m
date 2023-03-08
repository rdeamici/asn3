function [frames_on_object1, frames_on_object2] = part1(image1, image2, mask1, mask2, sift_features1, sift_features2)
    frames1 = sift_features1{1};
    descriptors1 = sift_features1{2};
    
    frames2 = sift_features2{1};
    descriptors2 = sift_features2{2};

    % compute matches
    [matches, scores] = vl_ubcmatch(descriptors1, descriptors2, 2);

    % sort matches based on the associated scores
    [scores_sorted, idx_in_orig] = sort(scores);
    matches_sorted = matches(:, idx_in_orig);
    whos matches
    whos matches_sorted
    whos frames1
    whos frames2
    
    % remove matches with very low scores
    % below_thresh = scores_sorted < 1000;
    % matches_sorted = matches_sorted(:, below_thresh);
    
    % get all frames from f1 and f2 that are associated with a match
    matches1 = matches_sorted(1,:);
    matches2 = matches_sorted(2,:);

    f1_matches = frames1(:, matches1);
    f2_matches = frames2(:, matches2);
    
    % remove SIFT features which are not on the object
    f1_mask = mask1(sub2ind(size(mask1), round(f1_matches(2,:)), round(f1_matches(1,:))));
    frames_on_object1 = f1_matches(:,f1_mask);
    f2_mask = mask2(sub2ind(size(mask2), round(f2_matches(2,:)), round(f2_matches(1,:))));
    frames_on_object2 = f2_matches(:,f2_mask);

    % display both images side-by-side
    figure;
    imshowpair(image1, image2, 'montage');
    x1 = frames_on_object1(1,1:10);
    y1 = frames_on_object1(2,1:10);
    x2 = frames_on_object2(1,1:10);
    y2 = frames_on_object2(2,1:10);
    
    % plot matching features on both images
    hold on;
    vl_plotframe(frames_on_object1(:,1:10));
    frames_on_object2(1,:) = frames_on_object2(1,:) + size(image1, 2); % adjust x-coordinates
    vl_plotframe(frames_on_object2(:,1:10));
    
    % draw lines connecting matching features
    for i = 1:length(x1)
        x = [x1(i), x2(i) + size(image1, 2)];
        y = [y1(i), y2(i)];
        plot(x, y, 'b-', 'LineWidth',1);
    end
    hold off;
%     figure, imshow(image1);
%     whos frames_on_object1
%     whos frames_on_object2
%     vl_plotframe(frames_on_object1(:,1:10));
%     figure, imshow(image2);
%     vl_plotframe(frames_on_object2(:,1:10));
end