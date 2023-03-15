% from page 183 in Intro to Visual Computing
% epipolar line l2 = Fp1
% epipolar line l1 = trans(F)p2
function [features_on_the_poles_pairs] = part3(images, setFiles, Pcs_homog, matching_sift_pairs, s)
    features_on_the_poles_pairs = cell(nchoosek(length(images),2),2);
    matches_idx = 1;
    for i = 1: length(Pcs_homog) - 1
        Pc1_homog = Pcs_homog{i};
        image1 = images{i};
        imFilename1 = setFiles{i};

        for j = i+1: length(Pcs_homog)
            Pc2_homog = Pcs_homog{j};
            image2 = images{j};
            imFilename2 = setFiles{j};
            
            f1 = matching_sift_pairs{matches_idx, 1};
            f2 = matching_sift_pairs{matches_idx, 2};
                        
            [fundMat,e1,e2] = fundmatrix(Pc1_homog, Pc2_homog);
            [features_on_epipole1, features_on_epipole2] = find_features_on_poles(s, f1, f2, fundMat, e1, e2, image1, image2, imFilename1, imFilename2);
            features_on_the_poles_pairs{matches_idx, 1} = features_on_epipole1;
            features_on_the_poles_pairs{matches_idx, 2} = features_on_epipole2;
            matches_idx = matches_idx + 1;
        end
    end
end