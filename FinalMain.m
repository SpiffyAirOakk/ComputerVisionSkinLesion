%% Welcome to the Program %%
% Made By Abdullah Khalid %
% F220102 %
%% Step 1 %%
% First off we will import all the necessary given data and store them in datastores %
Lesion_images = "lesionimages";
Lesion_DS = imageDatastore(Lesion_images);
Mask_images = "masks";
Mask_DS = imageDatastore(Mask_images);
Lesion_label = "groundtruth.txt";
%% Step 2 %%
% Mask and resize all the images %
Masked_DS=maskim(Lesion_DS,Mask_DS);
[Resized_Lesions,Resized_Masks]=resize(Lesion_DS, Masked_DS);
%% Step 3 %%
% Apply Gaussian Filter & laplacian Filter to all the images %
% CC_DS = applyCC(Resized_Lesions);
[Resized_Filtered_Lesions,Resized_Filtered_Masks]=meanFilterImages(Resized_Lesions, Resized_Masks, [20 20] );
[Resized_Filtered_Lesions1,Resized_Filtered_Masks1]=GaussianFilter(Resized_Filtered_Lesions,Resized_Filtered_Masks,1);
[Resized_Filtered_Lesions_2,Resized_Filtered_Masks_2]=gammaImages(Resized_Filtered_Lesions1, Resized_Filtered_Masks,0.9);

%% Step 4 %%
% Start working on imfeature Matrix %
% Calculate Asymmetry %
asymmetry = asymmetry_measure(Resized_Filtered_Masks_2);
% Calculate circularity %
circularity = circularity_measure(Resized_Filtered_Masks_2);
% Colour Values using 3d histogram %
colour_Hist = colour_measure(Resized_Filtered_Lesions1);
imfeature = [asymmetry,circularity,colour_Hist];
%% Step 5 %%
groundtruth = grt_to_vec(Lesion_label);
%% Step 6 %%
rng(1);% let's all use the same seed for the random number generator
svm = fitcsvm(imfeature, groundtruth);
cvsvm = crossval(svm);
pred = kfoldPredict(cvsvm);
[cm, order] = confusionmat(groundtruth, pred);
Sensitivity=(cm(1,1)/(cm(1,1)+cm(1,2)))*100;
