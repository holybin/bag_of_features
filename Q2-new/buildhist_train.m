% buildhist_train.m: build normalized histogram for training classes.

clearvars -except N THRESH_train;
close all;

global THRESH_train;

%% step1: build a histogram of N bins
load('centres.mat');
load('all_des.mat');

[IDX, D] = knnsearch(centres, double(all_des));

% statistics bin count for each class
load('class_label.mat');
class_num = size(unique(class_label),1);    % class number
class_bin = double(zeros(class_num, N));
for i=1:size(IDX)
    if D(i) > THRESH_train
        continue;
    end
    label = class_label(i);
    class_bin(label, IDX(i)) = class_bin(label, IDX(i)) + 1;
end

%% step2: normalize
for j=1:class_num
    sum_bin = sum(class_bin(j,:));
    class_bin(j,:) = class_bin(j,:)/sum_bin;
end
% save
save('class_bin.mat', 'class_bin');