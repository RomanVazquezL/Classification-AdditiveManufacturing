clear all;close all;clc
%% Video to 24fps
VR = VideoReader('191111-152950-Lab 1 11.11.avi');
VW = VideoWriter('D:\fullvideotwo24fps.avi');
VW.FrameRate = 24;
open(VW);
while hasFrame(VR)
    frame = readFrame(VR);
    writeVideo(VW,frame); 
end
% close(VR);
close(VW);