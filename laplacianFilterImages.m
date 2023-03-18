function [Resized_Filtered_Lesions_3,Resized_Filtered_Masks_3]=laplacianFilterImages(Resized_Filtered_Lesions_2,Resized_Filtered_Masks_2)
imgs = readall(Resized_Filtered_Lesions_2); % read in all Lesion images
imgsm = readall(Resized_Filtered_Masks_2); % read in all mask images
% Applies Gaussian filter to all images in the input datastores
resized_L_DS="Filtered_Lesion";
resized_M_DS="Filtered_Masks";
laplacian_filter = fspecial('laplacian',0.9);
for i=1:length(imgs)
 filtered_image = imfilter(imgs{i}, laplacian_filter);
 subtracted_image = imsubtract(imgs{i}, filtered_image);
 % Replace original image with filtered image
 [~, filename, ext] = fileparts(Resized_Filtered_Lesions_2.Files{i});
 % Save the resized image with the same filename to the new datastore
 imwrite(subtracted_image, fullfile(resized_L_DS, [filename, ext]));
 filtered_image = imfilter(imgsm{i}, laplacian_filter);
 subtracted_image = imsubtract(imgsm{i}, filtered_image);
 % Save the resized image with the same filename to the new datastore
 imwrite(subtracted_image, fullfile(resized_M_DS, [filename, ext]));
end
Resized_Filtered_Lesions_3=imageDatastore(resized_L_DS);
Resized_Filtered_Masks_3=imageDatastore(resized_M_DS);
end