function [color_img, gray_img_single] = read_img(filename)
    color_img = imread(filename);
    gray_img_single = singe(rgb2gray(color_img));
end       