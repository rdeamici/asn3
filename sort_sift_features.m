function sift_features_sorted = sort_sift_features(images, sift_features)
    sift_features_sorted = cell(length(images),2);
    
    f1 = sift_features{1, 1};
    d1 = sift_features{1,2};
    whos f1
    whos d1
    
    f2 = sift_features{2, 1};
    d2 = sift_features{2, 2};
    
    f3 = sift_features{3, 1};
    d3 = sift_features{3, 2};
    
    f4 = sift_features{4, 1};
    d4 = sift_features{4, 2};

    % Compute pairwise matches between the SIFT features of each pair of images
    [matches1_2, scores1_2] = vl_ubcmatch(d1, d2);
    [matches1_3, scores1_3] = vl_ubcmatch(d1, d3);
    [matches1_4, scores1_4] = vl_ubcmatch(d1, d4);
    [matches2_3, scores2_3] = vl_ubcmatch(d2, d3);
    [matches2_4, scores2_4] = vl_ubcmatch(d2, d4);
    [matches3_4, scores3_4] = vl_ubcmatch(d3, d4);
    
%     [matches2_1, scores1_2] = vl_ubcmatch(d2, d1);
%     [matches3_1, scores1_3] = vl_ubcmatch(d3, d1);
%     [matches4_1, scores1_4] = vl_ubcmatch(d4, d1);
%     [matches3_2, scores2_3] = vl_ubcmatch(d3, d2);
%     [matches4_2, scores2_4] = vl_ubcmatch(d4, d2);
%     [matches4_3, scores3_4] = vl_ubcmatch(d4, d3);
    whos matches1_2
    whos matches1_3
    whos matches1_4
    whos matches2_3
    whos matches2_4
    whos matches3_4

%     whos matches2_1
%     whos matches3_1
%     whos matches4_1
%     whos matches3_2
%     whos matches4_2
%     whos matches4_3

    % Find the common matches across all pairs of images
    idx_in_1 = matches1_2(1,:);
    idx_in_2 = matches1_2(2,:);
    idx_in_2_2 = matches2_3(1,:);
    
   [matches_between_pair1_pair2, idx1, idx2] = intersect(matches1_2(2,:), matches2_3(1,:));
   match2_3_subset = matches2_3(idx2);
   whos matches_between_pair1_pair2;
   whos match2_3_subset;
   match2_3_subset
   matches_between_all_4 = intersect(match2_3_subset', matches3_4(1,:));
   whos matches_between_all_4;
    
%     whos matches_between_pair1_pair2
%     whos matches_between_pair2_pair3
    common_matches = intersect(intersect(intersect(matches1_2(1,:), matches1_2(2,:)), intersect(matches1_3(1,:), matches1_3(2,:))), intersect(matches1_4(1,:), intersect(matches2_3(2,:), intersect(matches2_4(2,:), matches3_4(1,:)))));
    whos common_matches
end