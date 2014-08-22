% Question 2: Algorithm Implementation Revisited
% main.m: entrance of the whole program.

% BEFORE RUNNING THE PROGRAM, YOU MUST:
% 1.PUT DATA FOLDER 'midterm_data' IN PARENT DIRECTORY (i.e., '..').
% 2.PUT SURF CALCULATION CODE FOLDER 'SubFunctions' IN CURRENT DIRECTORY.

clc;clear all;close all;

% training set's root path(parent directory)
global train_root;
train_root = '..\midterm_data\midterm_data_expanded\TrainingDataset';

disp('Step1 - Calculate SURF feature descriptors for training samples.')
calsurf_train;
disp('Step1 - End...Press ENTER to continue...')
pause;

% number of clusters
global N;
N = 1000;

disp('Step2 - Cluster training set according to feature descriptors.')
cluster;        % cluster training set according to feature descriptors
disp('Step2 - End...Press ENTER to continue...')
pause;

% threshold of clustering distance: training set
global THRESH_train;
THRESH_train = 0.7;

disp('Step3 - Build normalized histogram for training classes.')
buildhist_train;      % build histograms for classes
disp('Step3 - End...Press ENTER to continue...')
pause;

% testing set's root path(parent directory)
global test_root;
test_root = '..\midterm_data\midterm_data_expanded\TestDataset';

disp('Step4 - Find the SURF feature descriptors within each test image.')
calsurf_test;   % surf feature extraction of testing set
disp('Step4 - End...Press ENTER to continue...')
pause;

% threshold of clustering distance: testing set
global THRESH_test;
THRESH_test = 0.7;

disp('Step5 - Build normalized histogram for testing samples.')
buildhist_test; % build histograms for testing images
disp('Step5 - End...Press ENTER to continue...')
pause;

disp('Step6 - Classification using class hist and testing image hist.')
classification; % classification using class hist and testing image hist
disp('Step6 - End...Press ENTER to continue...')
pause;

disp('Finally plot results.')
plot_res;
