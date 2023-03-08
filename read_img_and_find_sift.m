function [color_img, frames, descriptors] = read_img_and_find_sift(filename)
    color_img = imread(filename);
    gray_img_single = rgb2gray(im2single(color_img));
    
    % compute SIFT features
    [frames, descriptors] = vl_sift(gray_img_single);
end       