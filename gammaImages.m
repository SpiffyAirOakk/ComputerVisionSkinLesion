function [Resized_Filtered_Lesions_2,Resized_Filtered_Masks_2]=gammaImages(Resized_Filtered_Lesions, Resized_Filtered_Masks,gamma)
imgs = readall(Resized_Filtered_Lesions); % read in all Lesion images
imgsm = readall(Resized_Filtered_Masks); % read in all mask images
% Applies Gaussian filter to all images in the input datastores
resized_L_DS="Filtered_Lesion";
resized_M_DS="Filtered_Masks";


% Apply filter to each image in Resized_Lesions
reset(Resized_Filtered_Lesions);
reset(Resized_Filtered_Masks);
for i=1:length(imgs)
    % Apply filter
    filteredImg = imadjust(imgs{i},[],[],gamma);
    % Replace original image with filtered image
    [~, filename, ext] = fileparts(Resized_Filtered_Lesions.Files{i});
    % Save the resized image with the same filename to the new datastore
    imwrite(filteredImg, fullfile(resized_L_DS, [filename, ext]));
    % Apply filter
    filteredImg = imadjust(imgsm{i},[],[],gamma);
    % Save the resized image with the same filename to the new datastore
    imwrite(filteredImg, fullfile(resized_M_DS, [filename, ext]));
end
Resized_Filtered_Lesions_2=imageDatastore(resized_L_DS);
Resized_Filtered_Masks_2=imageDatastore(resized_M_DS);
end
