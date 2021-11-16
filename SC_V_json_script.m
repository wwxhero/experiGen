path_input = './SC_V/SC_design_V_3-5.csv';
path_output = './SC_V/SC_design_V_3-5_full.csv';
n_recordsPerOutput = 20;

% end of configuration specification

veh = VehicleObj;

X_table = readtable(path_input, 'PreserveVariableNames', true);
X = table2struct(X_table);



[n_X, ~] = size(X);

for i_X = n_X:-1:1
	Y(i_X).trialNum = i_X;
	Y(i_X).trialName = sprintf('%sx%gx%sx%dx%sx%sx%s' ...
					, X(i_X).ModalityCondition ...
					, X(i_X).TTCv_s_ ...
					, X(i_X).TTCa_s_ ...
					, X(i_X).vV_km_h_ ...
					, X(i_X).SoundLevel_dB_ ...
					, X(i_X).TTCa_s_ ...
					, veh.objType(X(i_X).vehicleSize));
	Y(i_X).corrAns = 0;
	Y(i_X).playSound = 'FALSE';
	Y(i_X).objNum = 1;
	Y(i_X).objType = veh.objType(X(i_X).vehicleSize);
	Y(i_X).gain = 'NA';
	Y(i_X).customMot = 'FALSE';
	Y(i_X).customFile = '""';
	Y(i_X).customDur = 0;
	Y(i_X).objScale = veh.objScale_csv(X(i_X).vehicleSize);
	Y(i_X).objRot = veh.objRot_csv(X(i_X).vehicleSize);
	Y(i_X).startPos = sprintf('"%g,0,2.8288"', -(X(i_X).TTCv_s_)*X(i_X).vV_km_h_*0.277778);
	Y(i_X).endPos = '"0,0,2.8288"';
	Y(i_X).velocity = X(i_X).vV_km_h_*0.277778;
	Y(i_X).timeVisible = X(i_X).TTCv_s_;
	Y(i_X).rotationSpeedX = 0;
	Y(i_X).rotationSpeedY = 0;
	Y(i_X).rotationSpeedZ = 0;
	Y(i_X).offsetX = -1;
	Y(i_X).offsetY = 0;
	Y(i_X).offsetZ = 0;
end

I_perm = randperm(n_X);
Y_perm = Y;

for i_I_perm = 1:n_X
	i_Y = I_perm(i_I_perm);
	Y_perm(i_I_perm) = Y(i_Y);
	Y_perm(i_I_perm).trialNum = i_I_perm; % comment this line to verify the permuation
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