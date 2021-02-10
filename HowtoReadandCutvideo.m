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

%% Access RGB24 matrices in frames
%Create Video Reader and Writer
% v = VideoReader('6601FramesAVI.avi')
% while hasFrame(v)
%     frame = readFrame(v);
% end
% 
% frame = read(v,1);
% % Calculate the mean gray level.
% % grayImage = rgb2gray(frame)
% % meanGrayLevels(frame) = mean(grayImage(:));
% for frame = 1 : numberOfFrames
% 		% Extract the frame from the movie structure.
% 		thisFrame = read(videoObject, frame);
% 		
% 		% Display it
% 		hImage = subplot(2, 2, 1);
% 		image(thisFrame);
% 		caption = sprintf('Frame %4d of %d.', frame, numberOfFrames);
% 		title(caption, 'FontSize', fontSize);
% 		drawnow; % Force it to refresh the window.
% 		
% 		% Write the image array to the output file, if requested.
% 		if writeToDisk
% 			% Construct an output image file name.
% 			outputBaseFileName = sprintf('Frame %4.4d.png', frame);
% 			outputFullFileName = fullfile(outputFolder, outputBaseFileName);
% 			
% 			% Stamp the name and frame number onto the image.
% 			% At this point it's just going into the overlay,
% 			% not actually getting written into the pixel values.
% 			text(5, 15, outputBaseFileName, 'FontSize', 20);
% 			
% 			% Extract the image with the text "burned into" it.
% 			frameWithText = getframe(gca);
% 			% frameWithText.cdata is the image with the text
% 			% actually written into the pixel values.
% 			% Write it out to disk.
% 			imwrite(frameWithText.cdata, outputFullFileName, 'png');
% 		end
% 		
% 		% Calculate the mean gray level.
% 		grayImage = rgb2gray(thisFrame);
% 		meanGrayLevels(frame) = mean(grayImage(:));
% 		
% 		% Calculate the mean R, G, and B levels.
% 		meanRedLevels(frame) = mean(mean(thisFrame(:, :, 1)));
% 		meanGreenLevels(frame) = mean(mean(thisFrame(:, :, 2)));
% 		meanBlueLevels(frame) = mean(mean(thisFrame(:, :, 3)));
% 		
% 		% Plot the mean gray levels.
% 		hPlot = subplot(2, 2, 2);
% 		hold off;
% 		plot(meanGrayLevels, 'k-', 'LineWidth', 3);
% 		hold on;
% 		plot(meanRedLevels, 'r-', 'LineWidth', 2);
% 		plot(meanGreenLevels, 'g-', 'LineWidth', 2);
% 		plot(meanBlueLevels, 'b-', 'LineWidth', 2);
% 		grid on;
% 		
% 		% Put title back because plot() erases the existing title.
% 		title('Mean Gray Levels', 'FontSize', fontSize);
% 		if frame == 1
% 			xlabel('Frame Number');
% 			ylabel('Gray Level');
% 			% Get size data later for preallocation if we read
% 			% the movie back in from disk.
% 			[rows, columns, numberOfColorChannels] = size(thisFrame);
% 		end
% 		
% 		% Update user with the progress.  Display in the command window.
% 		if writeToDisk
% 			progressIndication = sprintf('Wrote frame %4d of %d.', frame, numberOfFrames);
% 		else
% 			progressIndication = sprintf('Processed frame %4d of %d.', frame, numberOfFrames);
% 		end
% 		disp(progressIndication);
% 		% Increment frame count (should eventually = numberOfFrames
% 		% unless an error happens).
% 		numberOfFramesWritten = numberOfFramesWritten + 1;
% 		
% 		% Now let's do the differencing
% 		alpha = 0.5;
% 		if frame == 1
% 			Background = thisFrame;
% 		else
% 			% Change background slightly at each frame
% 			% 			Background(t+1)=(1-alpha)*I+alpha*Background
% 			Background = (1-alpha)* thisFrame + alpha * Background;
% 		end
% 		% Display the changing/adapting background.
% 		subplot(2, 2, 3);
% 		imshow(Background);
% 		title('Adaptive Background', 'FontSize', fontSize);
% 		% Calculate a difference between this frame and the background.
% 		differenceImage = thisFrame - uint8(Background);
% 		% Threshold with Otsu method.
% 		grayImage = rgb2gray(differenceImage); % Convert to gray level
% 		thresholdLevel = graythresh(grayImage); % Get threshold.
% 		binaryImage = im2bw( grayImage, thresholdLevel); % Do the binarization
% 		% Plot the binary image.
% 		subplot(2, 2, 4);
% 		imshow(binaryImage);
% 		title('Binarized Difference Image', 'FontSize', fontSize);
% 	end
% numberOfFrames = v.NumberOfFrames
% meanGrayLevels = zeros(numberOfFrames, 1);
% meanRedLevels = zeros(numberOfFrames, 1);
% meanGreenLevels = zeros(numberOfFrames, 1);
% meanBlueLevels = zeros(numberOfFrames, 1);
% 
% meanBlueLevels(1) = mean(mean(frame(:, :, 3)))
% % Calculate the mean R, G, and B levels.
% meanRedLevels = mean(mean(frame(:, :, 1)));
% meanGreenLevels = mean(mean(frame(:, :, 2)));
% meanBlueLevels = mean(mean(frame(:, :, 3)));

