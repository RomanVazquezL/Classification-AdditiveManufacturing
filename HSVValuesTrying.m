%% HSV Values
clear all; close all; clc
%% Read mean values experiment
v = VideoReader('Until2ndSpark.avi');
% % ThresholdingFrame = read(v, 200);
% % hsv1Frame = rgb2hsv(ThresholdingFrame);
% % image(hsv1Frame);
%% All H values
NumOfFrames = v.NumFrames;
vidHeight = v.Height;
vidWidth = v.Width;
%Setup values for hsv plot
meanH = zeros(NumOfFrames, 1);
meanS = zeros(NumOfFrames, 1);
meanV = zeros(NumOfFrames, 1);
% for frame = 1:NumOfFrames
%     thisFrame = read(v,frame);
%     hsvFrame = rgb2hsv(thisFrame);
%     meanH(frame) = mean(mean(hsvFrame(:,:,1)));
% end
% meanmean = mean(meanH)
%% file write
for frame = 1:NumOfFrames
    thisFrame = read(v,frame);
    hsvFrame = rgb2hsv(thisFrame);
    image(thisFrame)
    meanH(frame) = mean(mean(hsvFrame(:,:,1)));
%     figure; 
%     plot(meanH, 'g-');
%     hold on 
    meanS(frame) = mean(mean(hsvFrame(:,:,2)));
    meanV(frame) = mean(mean(hsvFrame(:,:,3)));
%     if (meanH(frame) > 0.98*meanmean) && (meanH(frame) < 0.9946*meanmean)
%         outputBaseFileName = sprintf('Frame %4.4d.png', frame);
%         outputFullFileName = fullfile('D:\', 'frames', outputBaseFileName);
%         imwrite(thisFrame, outputFullFileName);
%     end

end
%% plot hsv values
meanmean = mean(meanH)
figure; 
thisFrame = read(v,390);
image(thisFrame)
figure; 
plot(meanH, 'g-');
hold on 

plot(meanS, 'k-');
hold on 
plot(meanV, 'r-');
 %% If statement to write frames
% for frame = 1:NumOfFrames
%     thisFrame = read(v,frame);
%     if meanBL(frame) > 0.98*totalmeanBL || meanBL(frame) < 1.02*totalmeanBL
%          % Construct an output image file name.
%          outputBaseFileName = sprintf('Frame %4.4d.png', frame);
%          outputFullFileName = fullfile('D:\', 'frames', outputBaseFileName);
%          imwrite(thisFrame, outputFullFileName);
%     end
% end