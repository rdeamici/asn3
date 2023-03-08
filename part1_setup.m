function [s, masks, images, sift_features] = part1_setup(imagefiles, maskfiles)
    masks = cell(length(imagefiles), 1);
    images = cell(length(imagefiles), 1);
    sift_features = cell(length(imagefiles), 2);
    
    % Read in the images using imread and create binary masks using imbinarize
    for i = 1:length(imagefiles)
        imagefilename = imagefiles{i};
        maskfilename = maskfiles{i};
        [color_img, frames, descriptors] = read_img_and_find_sift(imagefilename);
        images{i} = color_img;

        sift_features{i, 1} = frames;
        sift_features{i, 2} = descriptors;
        
        % create binary mask from mask file
        mask = create_binary_mask(maskfilename);
        masks{i} = mask;
    end
    
    s = size(images{1});    
end
