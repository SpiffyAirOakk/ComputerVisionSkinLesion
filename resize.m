function [Resized_Lesions,Resized_Masks] = resize(Lesion_DS, Masked_DS)
imgs = readall(Lesion_DS); % read in all Lesion images
imgsm = readall(Masked_DS); % read in all masked images
resized_L_DS="Resiz_legions";
resized_M_DS="Resiz_mask";
outputSize = [350, 450];
for i=1:length(imgs)
    Resized_Lesions = imresize(imgs{i}, outputSize);
    Resized_Masks = imresize(imgsm{i}, outputSize);
    [~, filename, ext] = fileparts(Lesion_DS.Files{i});
    % Save the resized image with the same filename to the new datastore
    imwrite(Resized_Lesions, fullfile(resized_L_DS, [filename, ext]));
    imwrite(Resized_Masks, fullfile(resized_M_DS, [filename, ext]));
end
Resized_Lesions=imageDatastore(resized_L_DS);
Resized_Masks=imageDatastore(resized_M_DS);
end