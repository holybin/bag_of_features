% Q1.3: build normalized histogram as descriptor for the training classes.

clearvars -except N;
close all;

global N;

% reload
load('fea_des.mat');

% calculate descriptor number
class_num = size(fea_des,2);
des_num = double(zeros(1,class_num));
for i=1:class_num
    class_des = fea_des(1, i).descriptor;
    count_des = 0; 
    for j=1:size(class_des, 2)
       count_des = count_des + size(class_des{1, j}, 1);
    end
    des_num(1,i) = count_des;
end

%% step1: build a histogram of N bins
load('centres.mat');
load('all_des.mat');
% thresh = 10;
[IDX, D] = knnsearch(centres, double(all_des));
% statistics bin count for each class
class_bin = double(zeros(class_num, N));
% class label of each des
all_des_label = [];
% interval of one sample
count1 = 1;
count2 = 0;
for i=1:class_num
    interval_size = des_num(1,i);
    count2 = count1 + interval_size;
    all_des_label(count1:count2-1,:) = i;
    count1 = count2;
end
for i=1:size(IDX)
    class_label = all_des_label(i);
    class_bin(class_label, IDX(i)) = class_bin(class_label, IDX(i)) + 1;
end

%% step2: normalize
for j=1:class_num
    sum_bin = sum(class_bin(j,:));
    class_bin(j,:) = class_bin(j,:)/sum_bin;
end
% save
save('class_bin.mat', 'class_bin');
