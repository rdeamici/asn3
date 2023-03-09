% computes calibration matrix from 3D to 2D correspondences
% each set of files use the same single P consisting of location of 3D
% points
function calibrations = part2(imagefilenames, Pcs, P, verbose)
    calibrations = {};
    for i = 1:length(Pcs)
        Pc = Pcs{i};
        C = find_c(P,Pc);
        calibrations{i} = C;
        
        if verbose == 1
            % these 2 lines are used to see camera calibration matrix
            disp(['camera calibration matrix for ' imagefilenames{i} ':'])
            disp(C)

            % these 2 lines are used to visualize results.
            [Projected_2D_Pts, Residual] = evaluate_points( C, Pc, P);
            visualize_points(Residual, Pc, Projected_2D_Pts);
        end
    end
end