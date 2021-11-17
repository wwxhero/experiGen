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
	Y(i_X).startPos_M = sprintf('"%g,0,2.8288"', -(X(i_X).TTCv_s_)*X(i_X).vV_km_h_*0.277778);
	Y(i_X).endPos_N = '"0,0,2.8288"';
	Y(i_X).velocity_O = X(i_X).vV_km_h_*0.277778;
	Y(i_X).timeVisible_P = X(i_X).TTCv_s_;
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
	Y(i_X).endPos_AF = '"0,0,2.8288"';
	Y(i_X).velocity_AG = X(i_X).vA_km_h_*0.277778;
	Y(i_X).timeVisible_AH = X(i_X).TTCa_s_;
	Y(i_X).rotationSpeedX_AI = 0;
	Y(i_X).rotationSpeedY_AJ = 0;
	Y(i_X).rotationSpeedZ_AK = 0;
	Y(i_X).offsetX_AL = -1;
	Y(i_X).offsetY_AM = 0;
	Y(i_X).offsetZ_AN = 0;
end


write_rperm_csv_div(Y, n_recordsPerOutput, path_output);



