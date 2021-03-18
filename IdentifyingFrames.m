clear all; close all; clc
%% Read video and initialise variables

% Reading video 
v = VideoReader('FullVideo.avi'); 
% Obtain number of frames in video
NumOfFrames = v.NumFrames; 
% Set Up matrices 
meanB = zeros(NumOfFrames, 1); % Matrix containing mean b* values
mean50B = zeros(50,1); % Matrix containing mean b* values of past 50 frames
minimum = zeros(NumOfFrames-50, 1); % Matrix containing minium values of past 50 frames
%% Identifying frames based on mean b* values

% Initial for loop to obtain Mean b* of all frames
for frame = 1:NumOfFrames
    thisFrame = read(v,frame); 
    cform = makecform('srgb2lab'); % Change frame from rgb to lab colour space
    LabFrame = applycform(im2double(thisFrame),cform); 
    meanB(frame) = mean2(LabFrame(:,:,3)); % Obtain mean b* value 
end

% For loop to obtain array of minimum values
for i = 1:(NumOfFrames - 50)
    mean50B = meanB(i:i+50);
    minimum(i) = min(mean50B); % Minimum value os past 50 frames mean b* 
end

% For loop to write and compare mininum
for j = 7:(NumOfFrames-50)
    if minimum(j) < (minimum(j-6)/2) % Compare minimum values of current frame and 6th frame prior
      outputBaseFileName = sprintf('Frame %4.4d.png', (j+44)); % File name based on frame number
      outputFullFileName = fullfile('D:\', 'frames', outputBaseFileName); % Folder to save frames in
      Frame = read(v,j+44); % Read frame
      imwrite(Frame, outputFullFileName); % Save frame in folder indicated above
    end 
end

%% Delete Files from same cycle that are unnecesary 

d = dir('D:\frames\Not valuable frames'); % Access folder 
filenames = {d.name};% Access all filenames
Pnum = 00; % Define variable for previous file number

for i = 1:numel(filenames)
  fn = filenames{i}; % Access file name of specific file
  % Find all files that contain space and find first 2 digits of frame
  [num, cnt] = sscanf(fn(find(fn == ' ', 1, 'last')+1:end-6), '%d');
  % If statement to delete files with the same first 2 digits
  if cnt == 1 && isequal(num,Pnum)
    delete(fullfile('D:\frames\Not valuable frames', fn));
  end
  Pnum = num;
end

%% Crop Images to desired values

% Specify Coordinates of Pieces Manually
h = imshow('Frame 0431.png'); % Show first frame saved
hp = impixelinfo; % Show location of pointer in frame
set(hp,'Position',[5 1 300 20]); % Position of information of location
%% Save Cropped images

d2 = dir('D:\frames') % Establis folder to analyse
filenames = {d2.name}; % Find all filenames in the folder

% For loop to save cropped images
for i = 3: numel(filenames) % For all files 
    fn = filenames{i}; % Get current file number
    I = imread(fn); % Read frame of current file
    P1 = imcrop(I,[435 342 760 60]); % Crop frame for Sample 1 coordinates
    P2 = imcrop(I,[435 465 760 60]); % Crop frame for Sample 2 coordinates
    P3 = imcrop(I,[411 663 760 60]); % Crop frame for Sample 3 coordinates
    
    % Save cropped images to desired folder and with desired name, S1,S2,S3
    outputBaseFileName = sprintf('P1 %12s.png', fn);
    outputFullFileName = fullfile('D:\S1', outputBaseFileName);
    imwrite(P1, outputFullFileName); 
    outputBaseFileName = sprintf('P2 %12s.png', fn);
    outputFullFileName = fullfile('D:\S2',outputBaseFileName);
    imwrite(P2, outputFullFileName); 
    outputBaseFileName = sprintf('P3 %12s.png', fn);
    outputFullFileName = fullfile('D:\S3', outputBaseFileName);
    imwrite(P3, outputFullFileName); 
end
 
