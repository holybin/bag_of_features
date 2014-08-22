% Q1.6: Assign each test image to one of the possible classes by comparing 
%       its cluster histogram to histograms of all the classes.

clearvars -except N;
close all;

global N;

% reload
load('class_bin.mat');
load('class_bin_test.mat');
load('test_img_names.mat');

class_names = {'022.buddha-101', '024.butterfly', '251.airplanes'};

test_res = []; % all the classifiction results for test images
for i = 1:size(class_bin_test,2)
    % histograms per class
    hist_perclass = class_bin_test{i};
    
    % knn search for per class
    [IDX, D] = knnsearch(class_bin, hist_perclass);

    % summary
    test_res = [test_res; IDX];
end

for i = 1:size(test_img_names,1)
    name = char(test_img_names{i});
    [PATH,NAME,EXT] = fileparts(name);
    name_short = [NAME,EXT];
    
    class_name = char(class_names{test_res(i)});
    
    % display results
    disp(sprintf('Image name: %s, Classfication result: %s', name_short, class_name));
end
