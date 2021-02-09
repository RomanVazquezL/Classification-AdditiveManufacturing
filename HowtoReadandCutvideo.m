clear all; close all; clc;
%% Display video using depVideoPlayer
%Create deployable video player and video writer
VR = vision.VideoFileReader('Until2ndSpark24fps.avi');
depVideoPlayer = vision.DeployableVideoPlayer;
% while loop to play video frame by  frame
count = ~isDone(VR); %check if v is not done, returns logical where 0 if not done
  while count
    videoFrame = VR(); % matrix of data from video
    depVideoPlayer(videoFrame);
    count = ~isDone(VR) && isOpen(depVideoPlayer); %update count to close when 0 
  end  
%% Display video using Video Reader and hasFrames loop
v = VideoReader('fullvideoweihao.avi');
while hasFrame(v)
    frame = readFrame(v);
    image(frame)
end
% Read and Write File with vision.VideoFileWriter

% Create deployable video player and video writer
VVR = vision.VideoFileReader('fullvideoweihao.avi','VideoOutputDataType', 'uint8' )
% depVideoPlayer = vision.DeployableVideoPlayer;
VVW = vision.VideoFileWriter('AccidentalFile.avi','FrameRate', 55.0001);
% Write the first 50 frames
for i = 1:10
    videoFrame = VVR();
    VVW(videoFrame);
end
release (VVR);
release(VVW);
