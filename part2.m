% computes calibration matrix from 3D to 2D correspondences
function calibrations = part2(imagefilenames, Pcs, Ps)
    % allows access to variables in constants.m in this file
    run('constants.m');
    calibrations = {};
    for i = 1:length(Pcs)
        Pc = Pcs{i};
        P = Ps{i};
        C = find_c(P,Pc);
        calibrations{i} = C;

        % everything below here used for debug/verbose/info purposes
        % uncomment thes 2 lines to see camera calibration matrix
        % disp(['camera calibration matrix for ' imagefilenames{i} ':'])
        % disp(C)

        % uncomment these 2 lines to visualize results. See corresponding
        % files for more info on what these functions do.
        % [Projected_2D_Pts, Residual] = evaluate_points( C, Pc, P);
        % visualize_points(Residual, Pc, Projected_2D_Pts);
    end
end