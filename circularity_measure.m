function circularity = circularity_measure(Resized_Filtered_Masks)
imgs = readall(Resized_Filtered_Masks);
circularity = zeros(numel(Resized_Filtered_Masks),1);
for i = 1:numel(Resized_Filtered_Masks.Files)
    % Calculate the circularity
    % Convert the image to grayscale
    gray_img = rgb2gray(imgs{i});
    % Threshold the image using Otsu's method
    threshold = graythresh(gray_img);
    binary_img = imbinarize(gray_img, threshold);
    % Get the properties of the binary image regions
    stats = regionprops(binary_img, 'Area', 'Perimeter');   
    % Calculate the circularity using the area and perimeter
    circs=(4 * pi * [stats.Area] ./ ([stats.Perimeter].^2));
    circs(isinf(circs)) = 1;
    % Calculate the mean circularity of all the regions
    circularity(i,:) = mean(circs);
end
circularity_norm = (circularity - min(circularity)) / (max(circularity) - min(circularity));
circularity = circularity_norm;