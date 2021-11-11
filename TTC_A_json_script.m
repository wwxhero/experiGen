path_input = './TTC_A/TTC_design_A_3-5.csv';
path_output = './TTC_A/TTC_design_A_3-5_full.json';

veh = VehicleObj;

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
					, veh.objType(X(i_X).vehicleSize));
    Y(i_X).corrAns = 0;
    Y(i_X).playSound = false;
    object.objNum = 2;
    object.objType = veh.objType(X(i_X).vehicleSize);
    object.gain = X(i_X).SoundLevel_dB_;
    object.customMot = false;
    object.customFile = "";
    object.customDur = 0;
    object.objScale = veh.objScale(X(i_X).vehicleSize);
    object.objRot = veh.objRot(X(i_X).vehicleSize);
    object.startPos = [-(X(i_X).TTCa_s_+3)*X(i_X).vA_km_h_*0.277778, 0, 2.8288];
    object.endPos = [-X(i_X).TTCa_s_*X(i_X).vA_km_h_*0.277778,0,2.8288];
    object.velocity = X(i_X).vA_km_h_*0.277778;
    object.timeVisible = 3;
    object.rotationSpeedX = 0;
    object.rotationSpeedY = 0;
    object.rotationSpeedZ = 0;
    object.offsetX = -1;
    object.offsetY = 0;
    object.offsetZ = 0;
    Y(i_X).objects = {object};
end

output_js.trials = Y;

Y_json = jsonencode(output_js, 'PrettyPrint', true);

f_out = fopen(path_output, 'w');
fprintf(f_out, Y_json);
fclose(f_out);





