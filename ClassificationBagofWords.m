clear all;close all;clc
%% Image Classification
digitDatasetPath = fullfile('D:\OneDrive - University of Warwick\Warwick\1. ENGINEERING\4. YEAR3PROJECT\FRAMES\frames\Pieces\AllAllSamples');
imds = imageDatastore(digitDatasetPath,'IncludeSubfolders', true, 'LabelSource','foldernames');
%% Display Class Names and Counts
tbl = countEachLabel(imds)
categories = tbl.Label;
%% Display Sampling of Image Data
% sample = splitEachLabel(imds, 8);
% montage(sample.Files(1:8));
% title(char(tbl.Label(1)));

%% Partition 300 images for training and 75 for testing
image_location = fileparts(imds.Files{1});
imset = imageSet(strcat(image_location,'\..'),'recursive');
[tr_set,test_set] = imset.partition(140);
test_set = test_set.partition(49);

%% Create Visual Vocabulary
tic
bag = bagOfFeatures(tr_set,...
    'VocabularySize',7,'PointSelection','Detector');
scenedata = double(encode(bag, tr_set));
toc
return;
%% Visualize Feature Vectors 
img = read(tr_set(1), randi(tr_set(1).Count));
featureVector = encode(bag, img);

subplot(3,2,1); imshow(img);
subplot(3,2,2); 
bar(featureVector);title('Visual Word Occurrences');xlabel('Visual Word Index');ylabel('Frequency');

img = read(tr_set(2), randi(tr_set(2).Count));
featureVector = encode(bag, img);
subplot(3,2,3); imshow(img);
subplot(3,2,4); 
bar(featureVector);title('Visual Word Occurrences');xlabel('Visual Word Index');ylabel('Frequency');

img = read(tr_set(3), randi(tr_set(3).Count));
featureVector = encode(bag, img);
subplot(3,2,5); imshow(img);
subplot(3,2,6); 
bar(featureVector);title('Visual Word Occurrences');xlabel('Visual Word Index');ylabel('Frequency');

%% Create a Table using the encoded features
SceneImageData = array2table(scenedata);
sceneType = categorical(repelem({tr_set.Description}', [tr_set.Count], 1));
SceneImageData.sceneType = sceneType;
%% Use the new features to train a model and assess its performance using 
classificationLearner
%% Test out accuracy on test set!

testSceneData = double(encode(bag, test_set));
testSceneData = array2table(testSceneData,'VariableNames',trainedModel12.RequiredVariables);
actualSceneType = categorical(repelem({test_set.Description}', [test_set.Count], 1));

predictedOutcome = trainedModel12.predictFcn(testSceneData);

correctPredictions = (predictedOutcome == actualSceneType);
validationAccuracy = sum(correctPredictions)/length(predictedOutcome) 

%% Visualize how the classifier works
ii = randi(size(test_set,2));
jj = randi(test_set(ii).Count);
img = read(test_set(ii),jj);

imshow(img)
% Add code here to invoke the trained classifier
imagefeatures = double(encode(bag, img));
% Find two closest matches for each feature
[bestGuess, score] = predict(trainedModel4.ClassificationSVM,imagefeatures);
% Display the string label for img
if strcmp(char(bestGuess),test_set(ii).Description)
	titleColor = [0 0.8 0];
else
	titleColor = 'r';
end
title(sprintf('Best Guess: %s; Actual: %s',...
	char(bestGuess),test_set(ii).Description),...
	'color',titleColor)
