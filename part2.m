function calibrations = part2()
    % allows access to variables in constants.m in this file
    run('constants.m');
    Pcs = {Pc1_4177};%, Pc1_4178, Pc1_4179, Pc1_4180, Pc1_4186, Pc1_4187};
    calibrations = {};
    for i = 1:length(Pcs)
        Pc1 = Pcs{i};
        C = find_c(P,Pc1);
        disp(['camera calibration matrix for ' set1files{i} ':'])
        disp(C)
    
        [Projected_2D_Pts, Residual] = evaluate_points( C, Pc1_4177, P);
        % fprintf('\nThe total residual is: <%.4f>\n\n',Residual);
        visualize_points(Residual, Pc1_4177, Projected_2D_Pts);
        calibrations{i} = C;
    end
end