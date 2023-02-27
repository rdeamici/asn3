% Define the directory path
dirpath = 'data';

% List all files in the directory
set1files = {'data\DSCF4177.jpg', 'data\DSCF4178.jpg', 'data\DSCF4179.jpg',...
            'data\DSCF4180.jpg','data\DSCF4186.jpg', 'data\DSCF4187.jpg'};
set1fileMasks = {'data\DSCF4177Mask.jpg', 'data\DSCF4178Mask.jpg', 'data\DSCF4179Mask.jpg', ...
            'data\DSCF4180Mask.jpg','data\DSCF4186Mask.jpg', 'data\DSCF4187Mask.jpg'};

% Loop over the filenames and filter out those containing "MASK"
images = {};
masks = {};

% Read in the images using imread and create binary masks using imbinarize
for i = 1:numel(set1files)
    images{i} = single(rgb2gray(imread(set1files{i})));
    masks{i} = imbinarize(imread(set1fileMasks{i}), 0.5);
end

for i=1:numel(images)-1
    image1 = images{i};
    mask1 = masks{i};
    image2 = images{i+1};
    mask2 = masks{i+1};

    %compute SIFT features
    [f1, d1] = vl_sift(image1);
    [f2, d2] = vl_sift(image2);

    % compute matches
    [matches, scores] = vl_ubcmatch(d1, d2);
    
    % sort matches based on the associated scores
    [scores_sorted,idx_in_orig] = sort(scores);
    scores_sorted
    matches_sorted = matches(:, idx_in_orig);
    
    % get all frames from f1 and f2 that are associated with a match
    matches1 = matches(1,:);
    matches2 = matches(2,:);
    f1_matches = f1(:,matches1);
    f2_matches = f2(:,matches2);

    % find all possible pixels that lie on a frame
    for i = 1:size(f1)
    valid_frames, valid_descriptors = find_valids(f2,d2,mask2);
end

function (top, left), (bottom, right) = pixel_indices_within_range_of_frame(frame, s)
    row = frame(1);
    col = frame(2);
    rad = frame(3);
    % Determine edges of the box
    left = col - r;
    right = col + r;
    top = row - r;
    bottom = row + r;
    
    % Adjust edges to image boundaries
    [rows, cols] = s;
    left = max(1, left);
    right = min(cols, right);
    top = max(1, top);
    bottom = min(rows, bottom);
    
    % Calculate width and height of the box
    width = right - left + 1;
    height = bottom - top + 1;
    
    % Return coordinates of top-left and bottom-right corners
    x1 = left;
    y1 = top;
    x2 = left + width - 1;
    y2 = top + height - 1;
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