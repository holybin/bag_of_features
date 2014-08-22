% buildhist_test.m: build normalized histogram for testing samples.

clearvars -except N THRESH_test;
close all;

global THRESH_test;

% reload
load('all_des_sample_test.mat');
load('centres.mat');

class_bin_test = [];
for i = 1:size(all_des_sample_test,1)
    % des of each test image
    sample_des = all_des_sample_test{i};
    % knn search
    [IDX, D] = knnsearch(centres, double(sample_des));
    % statistics
    hist = double(zeros(1,N));
    for k = 1:size(IDX,1)
        if D(k) > THRESH_test
            continue;
        end
        hist(IDX(k)) = hist(IDX(k)) + 1;
    end
    % summary and normalization
    hist = hist./sum(hist);
    
    class_bin_test = [class_bin_test;hist];
end

% save
save('class_bin_test.mat', 'class_bin_test');
