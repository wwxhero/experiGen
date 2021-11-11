path_input = './TTC_A/TTC_design_A_3-5.csv';
path_output = './TTC_A/TTC_design_A_3-5_full.csv';

veh = VehicleObj;

X_table = readtable(path_input, 'PreserveVariableNames', true);
X = table2struct(X_table);



[n_X, ~] = size(X);

for i_X = n_X:-1:1
    Y(i_X).trialNum = i_X;
    Y(i_X).trialName = sprintf('%sx%gx%dx%gx%s' ...
					, X(i_X).ModalityCondition ...
					, X(i_X).TTCa_s_ ...
					, X(i_X).vA_km_h_ ...
					, X(i_X).SoundLevel_dB_ ...
					, veh.objType(X(i_X).vehicleSize));
    Y(i_X).corrAns = 0;
    Y(i_X).playSound = 'FALSE';
    Y(i_X).objNum = 2;
    Y(i_X).objType = veh.objType(X(i_X).vehicleSize);
    Y(i_X).gain = X(i_X).SoundLevel_dB_;
    Y(i_X).customMot = 'FALSE';
    Y(i_X).customFile = '""';
    Y(i_X).customDur = 0;
    Y(i_X).objScale = veh.objScale_csv(X(i_X).vehicleSize);
    Y(i_X).objRot = veh.objRot_csv(X(i_X).vehicleSize);
    Y(i_X).startPos = sprintf('"%g,0,2.8288"', -(X(i_X).TTCa_s_+3)*X(i_X).vA_km_h_*0.277778);
    Y(i_X).endPos = sprintf('"%g,0,2.8288"', -X(i_X).TTCa_s_*X(i_X).vA_km_h_*0.277778);
    Y(i_X).velocity = X(i_X).vA_km_h_*0.277778;
    Y(i_X).timeVisible = 3;
    Y(i_X).rotationSpeedX = 0;
    Y(i_X).rotationSpeedY = 0;
    Y(i_X).rotationSpeedZ = 0;
    Y(i_X).offsetX = -1;
    Y(i_X).offsetY = 0;
    Y(i_X).offsetZ = 0;
end

I_perm = randperm(n_X);
Y_perm = Y;

for i_I_perm = n_X:-1:1
    i_Y = I_perm(i_I_perm);
    Y_perm(i_I_perm) = Y(i_Y);
end

Y_table = struct2table(Y_perm);

% fixme: an empty string can not be expressed correctly in the output table
writetable(Y_table, path_output);



