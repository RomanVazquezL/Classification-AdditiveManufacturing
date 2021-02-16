clear all; close all; clc;
%% Display video using depVideoPlayer
%Create deployable video player and video writer
VR = vision.VideoFileReader('fullvideo24fps.avi');
depVideoPlayer = vision.DeployableVideoPlayer;
% while loop to play video frame by  frame
count = ~isDone(VR); %check if v is not done, returns logical where 0 if not done
  while count
    videoFrame = VR(); % matrix of data from video
    depVideoPlayer(videoFrame);
    count = ~isDone(VR) && isOpen(depVideoPlayer); %update count to close when 0 
  end  
%% Display video using Video Reader and hasFrames loop
v = VideoReader('fullvideo24fps.avi');
while hasFrame(v)
    frame = readFrame(v);
    image(frame)
end

%% Read and Write File with vision.VideoFileWriter
%Create deployable video player and video writer
VVR = vision.VideoFileReader('fullvideo24fps.avi','VideoOutputDataType', 'uint8' )
% depVideoPlayer = vision.DeployableVideoPlayer;
VVW = vision.VideoFileWriter('7minVideo.avi','FrameRate', 24);
% Write the first i frames
for i = 1:10080
    videoFrame = VVR();
    VVW(videoFrame);
end
release (VVR);
release(VVW);
