function Masked_DS = maskim(Lesion_DS, Mask_DS)
imgs = readall(Lesion_DS); % read in all Lesion images
imgsm = readall(Mask_DS); % read in all mask images
newDatastore = "Outputds";
%outputSize = [224, 334];
for i=1:length(imgs)
    img=imgs{i}-(255-imgsm{i});
    % Resize the image
    %img = imresize(filimg, outputSize);
    % Get the filename of the current image
    [~, filename, ext] = fileparts(Lesion_DS.Files{i});
    % Save the resized image with the same filename to the new datastore
    imwrite(img, fullfile(newDatastore, [filename, ext])) 
end
Masked_DS=imageDatastore(newDatastore);
end