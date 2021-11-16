function write_rperm_csv_div(Y, n_recordsPerOutput, path_output)
	n_Y = length(Y);

	I_perm = randperm(n_Y);
	Y_perm = Y;

	for i_I_perm = 1:n_Y
		i_Y = I_perm(i_I_perm);
		Y_perm(i_I_perm) = Y(i_Y);
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
		Y_table_i = struct2table(Y_perm(i_Y_seg_start:i_Y_seg_end));
		% fixme: an empty string can not be expressed correctly in the output table
		path_output_i = sprintf("%s_%d.csv", path_output, i_output);
		writetable(Y_table_i, path_output_i);
	end

end