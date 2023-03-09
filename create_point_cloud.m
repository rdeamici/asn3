% Solve for many 3D points P by using many Cs and many Pcs
function point_cloud = create_point_cloud(Cs, sift_features, images, masks, setNum)
    point_cloud = [];
    sift1 = sift_features(1, :);
    frames1 = sift1{1};
    img1 = images{1};
    mask1 = masks{1};
    % get all matching frames for each image
    matching_frames = {frames1};
    smallest = 500;
    for i = 2:size(Cs,2)
        img2 = images{i};
        mask2 = masks{i};
        sift2 = sift_features(i,:);
        % img1 mask1 will always be the first image in the list aka 4177
        % that way all the matching features should match to the same
        % 3D points in the real world
        [frames_on_1, frames_on_2] = part1(img1, img2, mask1, mask2, sift1, sift2, setNum);
%         whos frames_on_1
%         whos frames_on_2
        matching_frames{end+1} = frames_on_2;
        smallest = min([smallest, size(frames_on_2,2)]);
    end
    whos smallest
    for i = 1:smallest % for each frame
        disp(i)
        points2d = [];
        for idx = 1:size(matching_frames,2) % grab each images corresponding frames
            curFrames = matching_frames{idx};
            curFrame = curFrames(:,i);
            u = curFrame(1);
            v = curFrame(2);
            points2d = [points2d; [u,v]];
        end
        % now we have all 2d points that match to same 3d point
        [X,Y,Z,W] = estimate_depth(points2d, Cs);
        point_cloud = [point_cloud; [X,Y,Z,W]];
    end
end