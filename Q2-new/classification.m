% classification.m: assign each test image to one of the possible classes 
%                  by comparing its histogram to histograms of all classes.

clearvars -except N;
close all;

global N;

% reload
load('class_bin.mat');
load('class_bin_test.mat');
load('test_img_names.mat');
load('class_names.mat');

test_img_num = size(class_bin_test,1);      % test image number
class_num = size(class_names,1);            % class number
conf_matrix = double(zeros(class_num, class_num));  % confusion matrix

for i = 1:test_img_num
    % knn search for all test images
%     [IDX, D] = knnsearch(class_bin, class_bin_test);
    [IDX, D] = knnsearch(class_bin, class_bin_test, 'Distance', 'cosine');
    
    % display results
    img_name = char(test_img_names{i});
    class_name = char(class_names(IDX(i))); % classify class label
    disp(sprintf('Image name: %s, Classfication result: %s', img_name, class_name));
    
    % statistics
    img_name_list = regexp(img_name, '_', 'split');    % split by '_'
    % 1.find which class the test image really belongs to
    j = 0;
    for j = 1:class_num
        class_name_list = regexp(char(class_names(j)), '\.', 'split');      % split by '.'
        % the real class label found
        if char(img_name_list{1})==char(class_name_list{1})
            break;  % real class label is: j
        end
    end
    % 2.sum and display
    conf_matrix(j,IDX(i)) = conf_matrix(j,IDX(i)) + 1;
end

% transform to ratio confusion matrix
for i = 1:size(conf_matrix,1)
    total_per_class = sum(conf_matrix(i,:));
    conf_matrix(i,:) = conf_matrix(i,:)./total_per_class;
end
% save confusion matrix
save('conf_matrix.mat','conf_matrix');
