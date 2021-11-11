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
    Y(i_X).objScale = veh.objScale(X(i_X).vehicleSize);
    Y(i_X).objRot = veh.objRot(X(i_X).vehicleSize);
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



Y_table = struct2table(Y);

% fixme: an empty string can not be expressed correctly in the output table
writetable(Y_table, path_output);

% writetable_emptystr(Y_table, path_output);

% function writetable_emptystr(table, path)
% 	[m, n] = size(table);
%     f_out = fopen(path, 'w');
%     row_str = table.Properties.VariableNames{1};
%     for i_c = 2 : n
%         row_str = row_str + "," + table.Properties.VariableNames{i_c};
%     end
%     fprintf(f_out, "%s", row_str);
%     for i_r = 1 : m
%         row_str = sprintf("%d, %s, %d, %s, %d, %s, %s" ...
%         				, Y_table{1} ...
%         				, Y_table{2} ...
%         				, Y_table{3} ...
%         				, Y_table{4} ...
%         				, Y_table{5} ...
%         				, Y_table{6} ...
%         				, Y_table{7});
%     end
%     fclose(f_out);
% end

