function groundtruth = grt_to_vec(Lesion_label)
% Open the file containing the groundtruth labels
fid = fopen(Lesion_label, 'r');
% Initialize an empty cell array to store the labels
groundtruth = cell(200, 1);
% Read the file line by line and extract the label from each line
for i = 1:200
    line = fgetl(fid);
    comma_idx = strfind(line, ',');
    label = line(comma_idx+1:end);
    groundtruth{i} = label;
end
% Close the file
fclose(fid);
groundtruth=groundtruth(:);
end