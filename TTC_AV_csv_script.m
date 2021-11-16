% start of the specifications

path_input = './TTC_AV/TTC_design_AV_3-5.csv';
path_output = './TTC_AV/TTC_design_AV_3-5_full.csv';
n_recordsPerOutput = 20;

% end of the changable specifications

veh = VehicleObj;

X_table = readtable(path_input, 'PreserveVariableNames', true);
X = table2struct(X_table);

[n_X, ~] = size(X);

for i_X = n_X:-1:1
	Y(i_X).trialNum_A = i_X;
	Y(i_X).trialName_B = sprintf('%sx%gx%gx%dx%dx%gx%s' ...
					, X(i_X).ModalityCondition ...
					, X(i_X).TTCv_s_ ...
					, X(i_X).TTCa_s_ ...
					, X(i_X).vV_km_h_ ...
					, X(i_X).vA_km_h_ ...
					, X(i_X).SoundLevel_dB_ ...
					, veh.objType(X(i_X).vehicleSize));
	Y(i_X).corrAns_C = 0;
	Y(i_X).playSound_D = 'FALSE';
	Y(i_X).objNum_E = 1;
	Y(i_X).objType_F = veh.objType(X(i_X).vehicleSize);
	Y(i_X).gain_G = 'NA';
	Y(i_X).customMot_H = 'FALSE';
	Y(i_X).customFile_I = '""';
	Y(i_X).customDur_J = 0;
	Y(i_X).objScale_K = veh.objScale_csv(X(i_X).vehicleSize);
	Y(i_X).objRot_L = veh.objRot_csv(X(i_X).vehicleSize);
	Y(i_X).startPos_M = sprintf('"%g,0,2.8288"', -(X(i_X).TTCv_s_+3)*X(i_X).vV_km_h_*0.277778);
	Y(i_X).endPos_N = sprintf('"%g,0,2.8288"', -X(i_X).TTCv_s_*X(i_X).vV_km_h_*0.277778);
	Y(i_X).velocity_O = X(i_X).vV_km_h_*0.277778;
	Y(i_X).timeVisible_P = 3;
	Y(i_X).rotationSpeedX_Q = 0;
	Y(i_X).rotationSpeedY_R = 0;
	Y(i_X).rotationSpeedZ_S = 0;
	Y(i_X).offsetX_T = -1;
	Y(i_X).offsetY_U = 0;
	Y(i_X).offsetZ_V = 0;

	Y(i_X).objNum_W = 2;
	Y(i_X).objType_X = 'Audio';
	Y(i_X).gain_Y = X(i_X).SoundLevel_dB_;
	Y(i_X).customMot_Z = 'FALSE';
	Y(i_X).customFile_AA = '""';
	Y(i_X).customDur_AB = 0;
	Y(i_X).objScale_AC = '"1, 1, 1"';
	Y(i_X).objRot_AD = '"0, 90, 0"';
	Y(i_X).startPos_AE = sprintf('"%g,0,2.8288"', -(X(i_X).TTCa_s_+3)*X(i_X).vA_km_h_*0.277778);
	Y(i_X).endPos_AF = sprintf('"%g,0,2.8288"', -X(i_X).TTCa_s_*X(i_X).vA_km_h_*0.277778);
	Y(i_X).velocity_AG = X(i_X).vA_km_h_*0.277778;
	Y(i_X).timeVisible_AH = 3;
	Y(i_X).rotationSpeedX_AI = 0;
	Y(i_X).rotationSpeedY_AJ = 0;
	Y(i_X).rotationSpeedZ_AK = 0;
	Y(i_X).offsetX_AL = -1;
	Y(i_X).offsetY_AM = 0;
	Y(i_X).offsetZ_AN = 0;
end

I_perm = randperm(n_X);
Y_perm = Y;

for i_I_perm = 1:n_X
	i_Y = I_perm(i_I_perm);
	Y_perm(i_I_perm) = Y(i_Y);
	Y_perm(i_I_perm).trialNum_A = i_I_perm; % comment this line to verify the permuation
end

n_outputs = floor(n_X/n_recordsPerOutput);
n_outputs = max(1, n_outputs);
for i_output = 1:n_outputs
	i_Y_seg_start = (i_output-1) * n_recordsPerOutput + 1;
	i_Y_seg_end = i_Y_seg_start + n_recordsPerOutput - 1;
	appending_leftover = (n_X - i_Y_seg_end < n_recordsPerOutput); % (n_X - (i_Y_seg_start + n_recordsPerOutput)) < n_recordsPerOutput
	if (appending_leftover)
		i_Y_seg_end = n_X;
	end
	Y_table_i = struct2table(Y_perm(i_Y_seg_start:i_Y_seg_end));
	% fixme: an empty string can not be expressed correctly in the output table
	path_output_i = sprintf("%s_%d.csv", path_output, i_output);
	writetable(Y_table_i, path_output_i);
end
