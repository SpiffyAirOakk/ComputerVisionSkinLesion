function colour_Hist = colour_measure(Resized_Filtered_Lesions)
imgs = readall(Resized_Filtered_Lesions);
colour_Hist = zeros(numel(Resized_Filtered_Lesions),512);
noBins = 8; % 8 bins (along each dimension)
Hist = zeros(noBins, noBins, noBins); % empty histogram to start with
for a = 1:numel(Resized_Filtered_Lesions.Files)
% colour Histogram
img_hsv = rgb2hsv(imgs{a});
% Create a 3D histogram
for i = 1:size(img_hsv, 1)
for j = 1:size(img_hsv, 2)
h = round(img_hsv(i, j, 1) * 7) + 1;
s = round(img_hsv(i, j, 2) * 7) + 1;
v = round(img_hsv(i, j, 3) * 7) + 1;
Hist(h, s, v) = Hist(h, s, v) + 1;
end
end
    colour=reshape(Hist,[1 512]);
    colour_Hist(a,:)=colour;
    
end
colour_Hist = normalize(colour_Hist);  % Normalise
colour_Hist(isnan(colour_Hist)) = 0;   % Remove NaNs and Infs
colour_Hist(isinf(colour_Hist)) = 0;
colour_Hist = abs(colour_Hist);
end