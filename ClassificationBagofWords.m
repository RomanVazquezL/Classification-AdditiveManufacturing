clear all;close all;clc
%% Establish datasets using ImageDataStore function
File = fullfile('C:\Training and Test Set');
DB = imageDatastore(File,'IncludeSubfolders', true, 'LabelSource','foldernames');
%% Display class names and counts
Table = countEachLabel(DB)
Categories = tbl.Label;

%% Partition 336 images for training and 228 for testing
Ilocation = fileparts(DB.Files{1});
imgSet = imageSet(strcat(Ilocation,'\..'),'recursive'); % Recursively scan entire image set folder
[training_set,test_set] = imgSet.partition(113); % Create training and test set
test_set = test_set.partition(76);

%% Create Visual Vocabulary
tic % Start timer
% Use bagOfFeatures function to create vocabulary
% Set vocabulary size, type of feature point selection 
% and amount of features to select from (Final was 7, grid, 80%)
BoVW = bagOfFeatures(training_set, 'VocabularySize',7,'PointSelection','Grid','StrongestFeatures', 0.8);
% Create array of presence of visual words on each image
imgdata = double(encode(BoVW, tr_set)); 
toc % Stop timer
return; % Stop running code
%% Visualise/Plot histograms of feature vectors

% Plot histogram of random S1 image
img = read(training_set(1), randi(training_set(1).Count));
featureVector = encode(BoVW, img); % Encode data from BoVW
subplot(1,3,1); % Establish 1x3 image
bS1 = bar(featureVector, 'FaceColor', [0 0.7 0]);
titS1 = title({'Visual Word Occurrences of','Image in S1 Training Set'});
xlabS1 = xlabel('Visual Word Index');
ylabS1 = ylabel('Frequency ()');

% Set font and size
set(gca, 'FontName', 'Times New Roman')
set([xlabS1,ylabS1], 'FontSize', 13)
set([titS1], 'FontSize', 15)

% Plot histogram of random S2 image
img = read(tr_set(2), randi(tr_set(2).Count));
featureVector = encode(BoVW, img);
subplot(1,3,2); 
bS2 = bar(featureVector, 'FaceColor', [0 0.5 0]);
titS2 = title({'Visual Word Occurrences of','Image in S2 Training Set'});
xlabS2 = xlabel('Visual Word Index');
ylabS2 = ylabel('Frequency (%)');

% Set font and size
set(gca, 'FontName', 'Times New Roman')
set([xlabS2,ylabS2], 'FontSize', 13)
set([titS2], 'FontSize', 15)

% Plot histogram of random S3 image
img = read(tr_set(3), randi(tr_set(3).Count));
featureVector = encode(BoVW, img);
subplot(1,3,3); 
bS3 = bar(featureVector, 'FaceColor', [0 0.3 0]);
titS3 = title({'Visual Word Occurrences of','Image in S3 Training Set'});
xlabS3 = xlabel('Visual Word Index');
ylabS3 = ylabel('Frequency (%)');

% Set font and size
set(gca, 'FontName', 'Times New Roman')
set([xlabS3,ylabS3], 'FontSize', 13)
set([titS3], 'FontSize', 15)
%% Create a 339x8 table using the encoded features
ImageData = array2table(imgdata); % Convert array created earlier to table
% Link each category with each feature vector
Type = categorical(repelem({training_set.Description}', [training_set.Count], 1)); 
ImageData.Type = Type;
%% Use the Image Data to train a model and assess its performance using Classification learner
% Open Classification Learner and import trained model
classificationLearner
%% Test out accuracy on testing set
tic % Start timer
testImData = double(encode(BoVW, test_set));
testImData = array2table(testImData,'VariableNames',M0780.RequiredVariables); % Implement imported model
actualImType = categorical(repelem({test_set.Description}', [test_set.Count], 1)); % Obtain actual category

predictedOutcome = M0780.predictFcn(testImData); % Implement imported model M0780 to test

% Count correct predictions by comparing obtained classification and actual category
correctPredictions = (predictedOutcome == actualImType); 
validationAccuracy = sum(correctPredictions)/length(predictedOutcome) % Calculate validation accuracy
toc % Stop timer
