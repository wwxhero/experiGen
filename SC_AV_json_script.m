% start of the specifications

path_input = './SC_AV/SC_design_AV_3-5.csv';
path_output = './SC_AV/SC_design_AV_3-5_full';
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
	object_1.startPos = [-(X(i_X).TTCv_s_)*X(i_X).vV_km_h_*0.277778,0,2.8288];
	object_1.endPos = [0,0,2.8288];
	object_1.velocity = X(i_X).vV_km_h_*0.277778;
	object_1.timeVisible = X(i_X).TTCv_s_;
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
	object_2.startPos = [-(X(i_X).TTCa_s_)*X(i_X).vA_km_h_*0.277778,0,2.8288];
	object_2.endPos = [0,0,2.8288];
	object_2.velocity = X(i_X).vA_km_h_*0.277778;
	object_2.timeVisible = X(i_X).TTCa_s_;
	object_2.rotationSpeedX = 0;
	object_2.rotationSpeedY = 0;
	object_2.rotationSpeedZ = 0;
	object_2.offsetX = -1;
	object_2.offsetY = 0;
	object_2.offsetZ = 0;

	Y(i_X).objects = [object_1, object_2];
end


write_rperm_json_div(Y, n_recordsPerOutput, path_output);



