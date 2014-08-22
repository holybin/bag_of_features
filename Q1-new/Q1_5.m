% Q1.5: create image descriptors by assigning features to clusters,
%       and use assignments to calculate a normalized cluster histogram
%       for each test image.

clearvars -except N;
close all;

global N;

% reload
load('fea_des_test.mat');
load('centres.mat');

class_bin_test = {};   % cluster histograms for all test images
for i = 1:size(fea_des_test,2)
    img_des_list = fea_des_test(1,i).descriptor;
    
    % cluster histograms for test images of one class
    class_bin_perclass = [];
    for j = 1:size(img_des_list,2)
        % des for each image
        img_des = img_des_list{j};
        % knn search
        [IDX, D] = knnsearch(centres, double(img_des));
        % statistics
        hist = double(zeros(1,N));
        des_num = size(IDX,1);
        for k = 1:des_num
            hist(IDX(k)) = hist(IDX(k)) + 1;
        end
        % summary and normalization
        hist = hist./des_num;
        class_bin_perclass = [class_bin_perclass; hist];
    end
    
    % all histograms
    class_bin_test{i} = class_bin_perclass;
end

% save
save('class_bin_test.mat', 'class_bin_test');
