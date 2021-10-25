path_input = './TTC_V/TTC_design_V_3-5.csv';
path_output = './TTC_V/TTC_design_V_3-5_full.csv';

VehicleType(1).vehicleSize = 'small';
VehicleType(1).objType = '01-Golf Variant';
VehicleType(1).objScale = '"1, 1, 1"';
VehicleType(1).objRot = '"-90,0,90"';
VehicleType(2).vehicleSize = 'large';
VehicleType(2).objType = 'PickUp_3A Variant';
VehicleType(2).objScale = '"0.826,0.878,1"';
VehicleType(2).objRot = '"0,90,0"';


X_table = readtable(path_input, 'PreserveVariableNames', true);
X = table2struct(X_table);



[n_X, ~] = size(X);

for (i_X = 1:n_X)
    Y(i_X).trialNum = i_X;
    Y(i_X).trialName = sprintf('%sx%gx%dx%sx%s' ...
					, X(i_X).ModalityCondition ...
					, X(i_X).TTCv_s_ ...
					, X(i_X).vV_km_h_ ...
					, X(i_X).TTCa_s_ ...
					, objType(X(i_X).vehicleSize, VehicleType));
    Y(i_X).corrAns = 0;
    Y(i_X).playSound = 'FALSE';
    Y(i_X).objNum = 1;
    Y(i_X).objType = objType(X(i_X).vehicleSize, VehicleType);
    Y(i_X).gain = 'NA';
    Y(i_X).customMot = 'FALSE';
    Y(i_X).customFile = '""';
    Y(i_X).customDir = 0;
    Y(i_X).objScale = objScale(X(i_X).vehicleSize, VehicleType);
    Y(i_X).objRot = objRot(X(i_X).vehicleSize, VehicleType);
    Y(i_X).startPos = sprintf('"%g,0,2.8288"', -X(i_X).TTCv_s_*3*X(i_X).vV_km_h_*0.277778);
    Y(i_X).endPos = sprintf('"%g,0,2.8288"', -X(i_X).TTCv_s_*X(i_X).vV_km_h_*0.277778);
    Y(i_X).velocity = X(i_X).vV_km_h_*0.277778;
    Y(i_X).timeVisible = 3;
    Y(i_X).rotationSpeedX = 0;
    Y(i_X).rotationSpeedY = 0;
    Y(i_X).rotationSpeedZ = 0;
    Y(i_X).offsetX = -1;
    Y(i_X).offsetY = 0;
    Y(i_X).offsetZ = 0;
end



Y_table = struct2table(Y);

writetable(Y_table, path_output);

               

function v_type = objType(v_size, VehicleType)
    [~, n_VehicleType] = size(VehicleType); 
	for i_vt = 1:n_VehicleType
		if (v_size == VehicleType(i_vt).vehicleSize)
			v_type = VehicleType(i_vt).objType;
			return;
        end
	end
	v_type = "undefined";
end

function v_scale = objScale(v_size, VehicleType)
	[~, n_VehicleType] = size(VehicleType);
	for i_vt = 1:n_VehicleType
		if (v_size == VehicleType(i_vt).vehicleSize)
			v_scale = VehicleType(i_vt).objScale;
			return;
        end
	end
	v_scale = "undefined";
end

function v_rot = objRot(v_size, VehicleType)
	[~, n_VehicleType] = size(VehicleType);
	for i_vt = 1:n_VehicleType
		if (v_size == VehicleType(i_vt).vehicleSize)
			v_rot = VehicleType(i_vt).objRot;
			return;
        end
	end
	v_rot = "undefined";
end