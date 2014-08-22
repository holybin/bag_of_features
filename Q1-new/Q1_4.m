% Q1.4: Find the SIFT feature descriptors within each test image

clearvars -except N;
close all;

test_root = '..\midterm_data\midterm_data_reduced';
class_root = 'TestDataset';
class_num = 3;
class_name = cell(1,class_num);
for i = 1:class_num
    class_name{1,i} = sprintf('%s_%d',class_root, i);
end

fea_des_test = struct('class',{class_name{1,1},class_name{1,2},class_name{1,3}}, 'descriptor', {{} {} {}}, 'feature', {{} {} {}});
all_des_test = [];
all_label_test = [];
all_fea_test = [];
total_sample_des = {};  % 1*N cell, each cell is an sample
count_img = 0;

for i = 1:class_num
    dir_out = dir(fullfile(test_root, class_name{1,i}, '*.jpg'));
    file_names = {dir_out.name}';   % N*1 cell
    
    for j=1:size(file_names,1)
        img_name = fullfile(test_root, class_name{1,i}, file_names{j,:});
        count_img = count_img + 1;
        test_img_names{count_img, 1} = img_name;
        I = imread(img_name);
        [F, D] = sift(I);
        fea_des_test(1,i).descriptor = cat(2,fea_des_test(1,i).descriptor, D');
        fea_des_test(1,i).feature = cat(2,fea_des_test(1,i).feature, F');

        all_des_test = [all_des_test; D'];
        all_fea_test = [all_fea_test; F'];
        all_label_test = [all_label_test; i];

        total_sample_des = cat(2,total_sample_des, D');
    end
end
% save results
save('fea_des_test.mat','fea_des_test');
save('test_img_names.mat', 'test_img_names');
