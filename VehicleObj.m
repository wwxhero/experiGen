classdef VehicleObj
	properties ( Constant = true) %Access = private,
		VEHICLETYPE = [	...
			struct( ...
				'vehicleSize', 'small', ...
				'objType', '01-Golf Variant', ...
				'objScale', '"1, 1, 1"', ...
				'objRot', '"-90,0,90"' ...
				), ...
			struct( ...
				'vehicleSize', 'large', ...
				'objType', 'PickUp_3A Variant', ...
				'objScale', '"0.826,0.878,1"', ...
				'objRot', '"0,90,0"' ...
				), ...
			struct( ...
				'vehicleSize', 'NA', ...
				'objType', 'Audio', ...
				'objScale', '"1,1,1"', ...
				'objRot', '"0,90,0"' ...
				), ...
		];
  		% VEHICLETYPE(1).vehicleSize = 'small';
		% VEHICLETYPE(1).objType = '01-Golf Variant';
		% VEHICLETYPE(1).objScale = '"1, 1, 1"';
		% VEHICLETYPE(1).objRot = '"-90,0,90"';

		% VEHICLETYPE(2).vehicleSize = 'large';
		% VEHICLETYPE(2).objType = 'PickUp_3A Variant';
		% VEHICLETYPE(2).objScale = '"0.826,0.878,1"';
		% VEHICLETYPE(2).objRot = '"0,90,0"';

		% VEHICLETYPE(3).vehicleSize = 'NA';
		% VEHICLETYPE(3).objType = 'Audio';
		% VEHICLETYPE(3).objScale = '"1,1,1"';
		% VEHICLETYPE(3).objRot = '"0,90,0"';
	end

	methods
		function v_type = objType(obj, v_size)
    		[~, n_VehicleType] = size(obj.VEHICLETYPE);
			for i_vt = 1:n_VehicleType
				if (strcmp(v_size,obj.VEHICLETYPE(i_vt).vehicleSize))
					v_type = obj.VEHICLETYPE(i_vt).objType;
					return;
    		    end
			end
			v_type = "undefined";
		end

		function v_scale = objScale(obj, v_size)
			[~, n_VehicleType] = size(obj.VEHICLETYPE);
			for i_vt = 1:n_VehicleType
				if (strcmp(v_size,obj.VEHICLETYPE(i_vt).vehicleSize))
					v_scale = obj.VEHICLETYPE(i_vt).objScale;
					return;
		        end
			end
			v_scale = "undefined";
		end

		function v_rot = objRot(obj, v_size)
			[~, n_VehicleType] = size(obj.VEHICLETYPE);
			for i_vt = 1:n_VehicleType
				if (strcmp(v_size,obj.VEHICLETYPE(i_vt).vehicleSize))
					v_rot = obj.VEHICLETYPE(i_vt).objRot;
					return;
		        end
			end
			v_rot = "undefined";
		end
	end
end