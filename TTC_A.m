path_input = './TTC_A/TTC_design_A_3-5.csv';
path_output = './TTC_A/TTC_design_A_3-5_full.csv';

VEHICLETYPE(1).vehicleSize = 'small';
VEHICLETYPE(1).objType = '01-Golf Variant';
VEHICLETYPE(1).objScale = '"1, 1, 1"';
VEHICLETYPE(1).objRot = '"-90,0,90"';

VEHICLETYPE(2).vehicleSize = 'large';
VEHICLETYPE(2).objType = 'PickUp_3A Variant';
VEHICLETYPE(2).objScale = '"0.826,0.878,1"';
VEHICLETYPE(2).objRot = '"0,90,0"';

VEHICLETYPE(3).vehicleSize = 'NA';
VEHICLETYPE(3).objType = 'Audio';
VEHICLETYPE(3).objScale = '"1,1,1"';
VEHICLETYPE(3).objRot = '"0,90,0"';

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
					, objType(X(i_X).vehicleSize, VEHICLETYPE));
    Y(i_X).corrAns = 0;
    Y(i_X).playSound = 'FALSE';
    Y(i_X).objNum = 2;
    Y(i_X).objType = objType(X(i_X).vehicleSize, VEHICLETYPE);
    Y(i_X).gain = X(i_X).SoundLevel_dB_;
    Y(i_X).customMot = 'FALSE';
    Y(i_X).customFile = '""';
    Y(i_X).customDur = 0;
    Y(i_X).objScale = objScale(X(i_X).vehicleSize, VEHICLETYPE);
    Y(i_X).objRot = objRot(X(i_X).vehicleSize, VEHICLETYPE);
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

               

function v_type = objType(v_size, VehicleType)
    [~, n_VehicleType] = size(VehicleType); 
	for i_vt = 1:n_VehicleType
		if (strcmp(v_size,VehicleType(i_vt).vehicleSize))
			v_type = VehicleType(i_vt).objType;
			return;
        end
	end
	v_type = "undefined";
end

function v_scale = objScale(v_size, VehicleType)
	[~, n_VehicleType] = size(VehicleType);
	for i_vt = 1:n_VehicleType
		if (strcmp(v_size,VehicleType(i_vt).vehicleSize))
			v_scale = VehicleType(i_vt).objScale;
			return;
        end
	end
	v_scale = "undefined";
end

function v_rot = objRot(v_size, VehicleType)
	[~, n_VehicleType] = size(VehicleType);
	for i_vt = 1:n_VehicleType
		if (strcmp(v_size,VehicleType(i_vt).vehicleSize))
			v_rot = VehicleType(i_vt).objRot;
			return;
        end
	end
	v_rot = "undefined";
end