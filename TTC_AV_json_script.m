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
	Y(i_X).trialNum = i_X;
	Y(i_X).trialName = sprintf('%sx%gx%gx%dx%dx%gx%s' ...
							, X(i_X).ModalityCondition ...
							, X(i_X).TTCv_s_ ...
							, X(i_X).TTCa_s_ ...
							, X(i_X).vV_km_h_ ...
							, X(i_X).vA_km_h_ ...
							, X(i_X).SoundLevel_dB_ ...
							, veh.objType(X(i_X).vehicleSize));
	Y(i_X).corrAns = 0;
	Y(i_X).playSound = false;
	object_1.objNum = 1;
	object_1.objType = veh.objType(X(i_X).vehicleSize);
	object_1.gain = 'NA';
	object_1.customMot = false;
	object_1.customFile = "";
	object_1.customDur = 0;
	object_1.objScale = veh.objScale(X(i_X).vehicleSize);
	object_1.objRot = veh.objRot(X(i_X).vehicleSize);
	object_1.startPos = [-(X(i_X).TTCv_s_+3)*X(i_X).vV_km_h_*0.277778, 0, 2.8288];
	object_1.endPos = [-X(i_X).TTCv_s_*X(i_X).vV_km_h_*0.277778, 0, 2.8288];
	object_1.velocity = X(i_X).vV_km_h_*0.277778;
	object_1.timeVisible = 3;
	object_1.rotationSpeedX = 0;
	object_1.rotationSpeedY = 0;
	object_1.rotationSpeedZ = 0;
	object_1.offsetX = -1;
	object_1.offsetY = 0;
	object_1.offsetZ = 0;

	object_2.objNum = 2;
	object_2.objType = 'Audio';
	object_2.gain = X(i_X).SoundLevel_dB_;
	object_2.customMot = false;
	object_2.customFile = "";
	object_2.customDur = 0;
	object_2.objScale = [1, 1, 1];
	object_2.objRot = [0, 90, 0];
	object_2.startPos = [-(X(i_X).TTCa_s_+3)*X(i_X).vA_km_h_*0.277778, 0, 2.8288];
	object_2.endPos = [-X(i_X).TTCa_s_*X(i_X).vA_km_h_*0.277778, 0, 2.8288];
	object_2.velocity = X(i_X).vA_km_h_*0.277778;
	object_2.timeVisible = 3;
	object_2.rotationSpeedX = 0;
	object_2.rotationSpeedY = 0;
	object_2.rotationSpeedZ = 0;
	object_2.offsetX = -1;
	object_2.offsetY = 0;
	object_2.offsetZ = 0;

	Y(i_X).objects = [object_1, object_2];
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
	output_js.trials = Y_perm(i_Y_seg_start:i_Y_seg_end);
	Y_json = jsonencode(output_js, 'PrettyPrint', true);
	path_output_i = sprintf("%s_%d.json", path_output, i_output);
	f_out = fopen(path_output_i, 'w');
	fprintf(f_out, Y_json);
	fclose(f_out);
end