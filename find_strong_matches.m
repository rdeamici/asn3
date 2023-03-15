function [f1_matches,d1_matches,f2_matches,d2_matches] = find_strong_matches(f1,d1,f2,d2)
    thresh = 30000;

    % compute matches
    [matches, scores] = vl_ubcmatch(d1, d2);

    % sort matches based on the associated scores
    [scores_sorted, idx_in_orig] = sort(scores);
    
    matches_sorted = matches(:, idx_in_orig);
    
    % remove matches with very low scores
    matches_sorted = matches_sorted(:,scores_sorted<thresh);
    
    % get all frames and descriptors that are associated with a match
    f1_matches = f1(:, matches_sorted(1,:));
    d1_matches = d1(:, matches_sorted(1,:));

    f2_matches = f2(:, matches_sorted(2,:));            
    d2_matches = d2(:, matches_sorted(2,:));
            