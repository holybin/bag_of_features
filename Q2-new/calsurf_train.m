% calsurf_train.m: calculate SURF feature descriptors for training samples.

clearvars -except train_root;
close all;

global train_root;

train_dir = dir(fullfile(train_root, '*'));
train_folders = {train_dir.name}';   % N*1 cell
% delete '.' and '..' directory
train_folders(1) = [];
train_folders(1) = [];

K = 64; % surf descriptor dimension
all_des = [];   % all the surf descriptors: M*64
all_des_sample = {};    % all the surf descriptors per sample: 1*N cell
class_label = [];   % class label for each surf descriptor: M*1
count_label = 0;    % for labeling classes
class_names = {};   % class names
for i = 1:size(train_folders,1)
    % class
    train_folder = train_folders{i,:};
    sample_dir = dir(fullfile(train_root, train_folder, '*.jpg'));
    sample_names = {sample_dir.name}';  % M*1 cell
    
    class_names = cat(1,class_names,train_folder);
    
    count_label = count_label + 1;
    
    % samples
    for j = 1:size(sample_names, 1)
        sample_name = sample_names{j,:};
        img = fullfile(train_root, train_folder, sample_name);
        % surf feature
        I = imread(img);
        Options.upright = false; % rotation invariant
        Options.tresh = 0.0002; % Hessian response threshold
        img_surf = OpenSurf(I, Options);
        
        % put the landmark descriptors in a matrix
        D = (reshape([img_surf.descriptor],K,[]))';

        all_des_sample = cat(2, all_des_sample, D);
        all_des = cat(1, all_des, D);
        
        tmp0 = ones(size(D, 1), 1).*count_label;
        class_label = cat(1, class_label, tmp0);
    end
end
% save surf descriptors
save('all_des.mat', 'all_des');
save('all_des_sample.mat', 'all_des_sample');
save('class_label.mat', 'class_label');
save('class_names.mat', 'class_names');
