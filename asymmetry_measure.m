function asymmetry= asymmetry_measure(Resized_Filtered_Masks)
imgs = readall(Resized_Filtered_Masks);
asymmetry = zeros(numel(Resized_Filtered_Masks),1);
for i = 1:numel(Resized_Filtered_Masks.Files)
    % Calculate the asymmetry
    img_rotated = imrotate(imgs{i}, 180,'crop'); % Rotate the image
    img_flipped = flip(img_rotated, 2);  % Flip it
    diff = abs(double(imgs{i}) - double(img_flipped));  % calculate the difference
    asymmetry(i,:) = sum(diff(:)) / (numel(imgs{i}) * 255); % Put in matrix
end 
asymmetry_norm = (asymmetry - min(asymmetry)) / (max(asymmetry) - min(asymmetry));
asymmetry = asymmetry_norm;