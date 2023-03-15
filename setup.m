function [s, images, masks, sift_features] = setup(imagefiles, maskfiles)
    images = cell(length(imagefiles), 1);
    masks = cell(length(imagefiles), 1);
    sift_features = cell(length(imagefiles),2);
    for i = 1:length(imagefiles)
        imagefilename = imagefiles{i};
        maskfilename = maskfiles{i};

        [color_img, single_img] = read_img(imagefilename);
        s = size(color_img);

        images{i} = color_img;
        
        % create binary mask
        mask = create_binary_mask(maskfilename);
        masks{i} = mask;
        
        % find sift features
        [f, d] = vl_sift(single_img);
        sift_features{i,1} = f;
        sift_features{i,2} = d;
    end
end
