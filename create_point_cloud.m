% Solve for many 3D points P by using many Cs and many Pcs
function point_cloud = create_point_cloud(Cs, frames_pairs, images)
    % pairs: 
    % (im1,im2), (im1,im3), (im1,im4),
    %            (im2,im3), (im2,im4),
    %                       (im3,im4)
    point_cloud = [];
    match_idx = 1;
    for i = 1:size(Cs,2)-1
        C1 = Cs{i};
        for j = i+1:size(Cs,2)
            C2 = Cs{j};
            frames1 = frames_pairs{match_idx,1};
            frames2 = frames_pairs{match_idx,2};
            pt_cloud = estimate_depth(frames1, C1, frames2, C2);
            point_cloud = [point_cloud; pt_cloud];
            match_idx = match_idx + 1;
        end
    end
end