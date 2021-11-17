path_input = './SC_A/SC_design_A_3-5.csv';
path_output = './SC_A/SC_design_A_3-5_full';
n_recordsPerOutput = 20;

% end of configuration specification

veh = VehicleObj;

X_table = readtable(path_input, 'PreserveVariableNames', true);
X = table2struct(X_table);

[n_X, ~] = size(X);

for i_X = n_X:-1:1
	Y(i_X).trialNum = i_X;
	Y(i_X).trialName = sprintf('%sx%sx%gx%sx%gx%gx%s' ...
					, X(i_X).ModalityCondition ...
					, X(i_X).TTCv_s_ ...
					, X(i_X).TTCa_s_ ...
					, X(i_X).vV_km_h_ ...
					, X(i_X).vA_km_h_ ...
					, X(i_X).SoundLevel_dB_ ...
					, veh.objType(X(i_X).vehicleSize));
	Y(i_X).corrAns = 0;
	Y(i_X).playSound = false;
	object.objNum = 2;
	object.objType = 'Audio';
	object.gain = X(i_X).SoundLevel_dB_;
	object.customMot = false;
	object.customFile = "";
	object.customDur = 0;
	object.objScale = [1, 1, 1];
	object.objRot = [0, 90, 0];
	object.startPos = [-(X(i_X).TTCa_s_)*X(i_X).vA_km_h_*0.277778, 0, 2.8288];
	object.endPos = [0, 0, 2.8288];
	object.velocity = X(i_X).vA_km_h_*0.277778;
	object.timeVisible = X(i_X).TTCa_s_;
	object.rotationSpeedX = 0;
	object.rotationSpeedY = 0;
	object.rotationSpeedZ = 0;
	object.offsetX = -1;
	object.offsetY = 0;
	object.offsetZ = 0;
	Y(i_X).objects = {object};
end


write_rperm_json_div(Y, n_recordsPerOutput, path_output);



