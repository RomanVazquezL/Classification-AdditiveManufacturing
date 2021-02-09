clear all; close all; clc
%% Minimum values attempt
% reading video 
v = VideoReader('fullvideo24fps.avi');
% setting up frame number and matrices for analysis
NumOfFrames = v.NumFrames;
meanB = zeros(NumOfFrames, 1);
mean50B = zeros(50,1);
minimum = zeros(NumOfFrames-50, 1);
%% Initial for loop to obtain MeanL of all frames
for frame = 1:NumOfFrames   
    thisFrame = read(v,frame); 
    cform = makecform('srgb2lab');
    LabFrame = applycform(im2double(thisFrame),cform);
    meanB(frame) = mean2(LabFrame(:,:,3));
end
%% For loop to obtain array of minimum values
for i = 1:(NumOfFrames - 50)
    mean50B = meanB(i:i+50);
    minimum(i) = min(mean50B);
end
%% For loop to write and compare min
for j = 7:(NumOfFrames-50)
    if minimum(j) < (minimum(j-6)/1.6)
      outputBaseFileName = sprintf('Frame %4.4d.png', (j+44));
      outputFullFileName = fullfile('D:\', 'frames', outputBaseFileName);
      Frame = read(v,j+44);
      imwrite(Frame, outputFullFileName);
    end 
end
%% Delete Files from same cycle 
d = dir('D:\frames'); % access folder 
filenames = {d.name};% access all filenames
Pnum = 00; % Define variable for previous file number
for i = 1:numel(filenames)
  fn = filenames{i}; % Access file name of specific file
  % Find all files that contain space and find first 2 numbers of frame
  [num, cnt] = sscanf(fn(find(fn == ' ', 1, 'last')+1:end-6), '%d');
  % If statement to delete files with the same first 2 digits
  if cnt == 1 && isequal(num,Pnum)
    delete(fullfile('D:\', 'frames', fn));
  end
  Pnum = num;
end
%% Specify Coordinates of Pieces Manually
h = imshow('Frame 0431.png');
hp = impixelinfo; 
set(hp,'Position',[5 1 300 20]);
%% Save Cropped images
d2 = dir('D:\frames\fullvideo1frames')
filenames = {d2.name};
for i = 3:numel(filenames)
    fn = filenames{i};
    I = imread(fn);
    P1 = imcrop(I,[510 279 739 20]);
    P2 = imcrop(I,[510 402 739 20]);
    P3 = imcrop(I,[510 525 739 20]);
    outputBaseFileName = sprintf('P1 %12s.png', fn);
    outputFullFileName = fullfile('D:\', 'frames','\Pieces','\P1', outputBaseFileName);
    imwrite(P1, outputFullFileName); 
    outputBaseFileName = sprintf('P2 %12s.png', fn);
    outputFullFileName = fullfile('D:\', 'frames','\Pieces','\P2', outputBaseFileName);
    imwrite(P2, outputFullFileName); 
    outputBaseFileName = sprintf('P3 %12s.png', fn);
    outputFullFileName = fullfile('D:\', 'frames','\Pieces','\P3', outputBaseFileName);
    imwrite(P3, outputFullFileName); 
end
 
