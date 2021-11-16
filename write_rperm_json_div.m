function write_rperm_json_div(Y, n_recordsPerOutput, path_output)
	n_Y = length(Y);
	I_perm = randperm(n_Y);
	Y_perm = Y;

	for i_I_perm = 1:n_Y
		i_Y = I_perm(i_I_perm);
		Y_perm(i_I_perm) = Y(i_Y);
		Y_perm(i_I_perm).trialNum = i_I_perm; % comment this line to verify the permuation
	end

	n_outputs = floor(n_Y/n_recordsPerOutput);
	n_outputs = max(1, n_outputs);
	for i_output = 1:n_outputs
		i_Y_seg_start = (i_output-1) * n_recordsPerOutput + 1;
		i_Y_seg_end = i_Y_seg_start + n_recordsPerOutput - 1;
		appending_leftover = (n_Y - i_Y_seg_end < n_recordsPerOutput); % (n_Y - (i_Y_seg_start + n_recordsPerOutput)) < n_recordsPerOutput
		if (appending_leftover)
			i_Y_seg_end = n_Y;
		end
		output_js.trials = Y_perm(i_Y_seg_start:i_Y_seg_end);
		Y_json = jsonencode(output_js, 'PrettyPrint', true);
		path_output_i = sprintf("%s_%d.json", path_output, i_output);
		f_out = fopen(path_output_i, 'w');
		fprintf(f_out, Y_json);
		fclose(f_out);
	end
end