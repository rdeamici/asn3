function mask = create_binary_mask(maskfilename)
    % create binary mask from mask file
    mask = rgb2gray(imread(maskfilename));
    mask = mask>0;
end