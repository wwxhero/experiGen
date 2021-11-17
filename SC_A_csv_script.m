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
	Y(i_X).playSound = 'FALSE';
	Y(i_X).objNum = 2;
	Y(i_X).objType = 'Audio';
	Y(i_X).gain = X(i_X).SoundLevel_dB_;
	Y(i_X).customMot = 'FALSE';
	Y(i_X).customFile = '""';
	Y(i_X).customDur = 0;
	Y(i_X).objScale = '"1, 1, 1"';
	Y(i_X).objRot = '"0, 90, 0"';
	Y(i_X).startPos = sprintf('"%g,0,2.8288"', -(X(i_X).TTCa_s_)*X(i_X).vA_km_h_*0.277778);
	Y(i_X).endPos = '"0,0,2.8288"';
	Y(i_X).velocity = X(i_X).vA_km_h_*0.277778;
	Y(i_X).timeVisible = X(i_X).TTCa_s_;
	Y(i_X).rotationSpeedX = 0;
	Y(i_X).rotationSpeedY = 0;
	Y(i_X).rotationSpeedZ = 0;
	Y(i_X).offsetX = -1;
	Y(i_X).offsetY = 0;
	Y(i_X).offsetZ = 0;
end


write_rperm_csv_div(Y, n_recordsPerOutput, path_output);



