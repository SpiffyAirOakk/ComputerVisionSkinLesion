function [Resized_Filtered_Lesions,Resized_Filtered_Masks]=GaussianFilter(Resized_Lesions_DS, Resized_Masks_DS,A)
imgs = readall(Resized_Lesions_DS); % read in all Lesion images
imgsm = readall(Resized_Masks_DS); % read in all mask images
% Applies Gaussian filter to all images in the input datastores
resized_L_DS="Filtered_Lesion";
resized_M_DS="Filtered_Masks";

% Apply filter to each image in Resized_Lesions
reset(Resized_Lesions_DS);
reset(Resized_Masks_DS);
for i=1:length(imgs)
    % Apply filter
    filteredImg = imgaussfilt(imgs{i},A);
    % Replace original image with filtered image
    [~, filename, ext] = fileparts(Resized_Lesions_DS.Files{i});
    % Save the resized image with the same filename to the new datastore
    imwrite(filteredImg, fullfile(resized_L_DS, [filename, ext]));
    % Apply filter
    filteredImg = imgaussfilt(imgsm{i},A);
    % Save the resized image with the same filename to the new datastore
    imwrite(filteredImg, fullfile(resized_M_DS, [filename, ext]));
end
Resized_Filtered_Lesions=imageDatastore(resized_L_DS);
Resized_Filtered_Masks=imageDatastore(resized_M_DS);
end
