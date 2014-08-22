% setup.m: setup vlfeat toolbox for SIFT

% vlfeat toolbox installation path (user-defined)
vlfeat_path = 'F:\Program Files\vlfeat-0.9.17-bin\vlfeat-0.9.17\toolbox';
% add path
addpath(vlfeat_path);
% setup
vl_setup;

% % current path
% current_path = fileparts(mfilename('fullpath'));
% 
% % add SIFT path (directory 'sift' is default in current path)
% addpath(fullfile(current_path,'sift'));
