clear all; close all; clc;
%% Edge Detection
I = imread('Frame 0431.png'); 
GI = rgb2gray(I);
sensitivity = 0.09;

BW1 = edge(GI,'Sobel', sensitivity);
BW2 = edge(GI,'Prewitt', sensitivity);
BW3 = edge(GI,'Canny', sensitivity);
BW4 = edge(GI,'Roberts', sensitivity);
size(BW1)


subplot('Position',[0.02 0.15 0.3 0.35])
imshow(BW1);
subplot('Position',[0.32 0.15 0.3 0.35])
imshow(BW2);
subplot('Position',[0.02 0.60 0.3 0.35])
imshow(BW3);
subplot('Position',[0.32 0.60 0.3 0.35])
imshow(BW4);