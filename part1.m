% features not on the horse have already been removed
function matching_pairs = part1(imagefiles, images, masks, sift_features)
    matching_pairs = cell(nchoosek(length(images),2),2);
    matches_idx = 1;
    for i = 1:numel(imagefiles)-1
        imfilename1 = imagefiles{i};
        im1 = images{i};
        mask1 = masks{i};
        f1 = sift_features{i,1};
        d1 = sift_features{i,2};

        for j = i+1:numel(imagefiles)
            imfilename2 = imagefiles{j};
            im2 = images{j};
            mask2 = masks{j};
            f2 = sift_features{j,1};
            d2 = sift_features{j,2};

            % remove SIFT features which are not on the object
            mask1_values = mask1(sub2ind(size(mask1), round(f1(2,:)), round(f1(1,:))));
            mask1_idx = find(mask1_values);
            f1_onhorse = f1(:,mask1_idx);
            d1_onhorse = d1(:,mask1_idx);
%             imshow(im1);
%             hold on;
%             vl_plotframe(f1_onhorse);
            
            mask2_values = mask2(sub2ind(size(mask2), round(f2(2,:)), round(f2(1,:))));
            mask2_idx = find(mask2_values);
            f2_onhorse = f2(:,mask2_idx);
            d2_onhorse = d2(:,mask2_idx);
            
            [f1_onhorse, d1_onhorse, f2_onhorse, d2_onhorse] = find_strong_matches(f1_onhorse, d1_onhorse, f2_onhorse, d2_onhorse);
            whos f1_onhorse
            
            matching_pairs{matches_idx,1} = f1_onhorse;
            matching_pairs{matches_idx,2} = f2_onhorse;
            matches_idx = matches_idx+1;
    
            % display both images side-by-side
            figure;
            imshowpair(im1, im2, 'montage');
            x1 = f1_onhorse(1,:);
            y1 = f1_onhorse(2,:);
            x2 = f2_onhorse(1,:);
            y2 = f2_onhorse(2,:);
            
%             plot matching features on both images
            vl_plotframe(f1_onhorse);
            hold on;
            % adjust x-coordinates for second image
            f2_copy = f2_onhorse(:,:);
            f2_copy(1,:) = f2_copy(1,:) + size(im1, 2);
            vl_plotframe(f2_copy);
            
            % draw lines connecting matching features
            for i = 1:length(x1)
                x = [x1(i), x2(i) + size(im1, 2)];
                y = [y1(i), y2(i)];
                plot(x, y, 'b-', 'LineWidth',1);
            end
            hold off;
        end
    end
end