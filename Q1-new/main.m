% Question 1: Bag of Features Classification with SIFT Descriptors
% 
% main.m: entrance of the whole program

clc;clear all;close all;

global N;
N = 1000;    % number of clusters

setup;       % setup vl_feat toolbox for SIFT

disp('Q1_1 - Use SIFT to find features and descriptors of training set images.');
Q1_1;        % sift feature extraction of training set
getall;      % transform feature and descriptors to matrix form
disp('Q1_1 - End...Press ENTER to continue...');
pause;

disp('Q1_2 - Cluster according to feature descriptors.');
Q1_2;        % cluster according to feature descriptors
disp('Q1_2 - End...Press ENTER to continue...');
pause;

disp('Q1_3 - Build normalized histogram as descriptor for the training classes.')
Q1_3;        % build histograms for classes
disp('Q1_3 - End...Press ENTER to continue...');
pause;

disp('Q1_4 - Find the SIFT feature descriptors within each test image.') 
Q1_4;        % sift feature extraction of testing set
disp('Q1_4 - End...Press ENTER to continue...');
pause;

disp('Q1_5 - Create test image descriptors and calculate normalized histogram.') 
Q1_5;         % build histograms for test images
disp('Q1_5 - End...Press ENTER to continue...');
pause;

disp('Q1_6 - Classification using class histograms and test image histograms.') 
Q1_6;        % classification using class hist and image hist
disp('Q1_6 - End...Press ENTER to continue...');
pause;
