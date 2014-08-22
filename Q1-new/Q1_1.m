% Q1.1: Use SIFT to find features and descriptors of training set images

% training set's root path(parent directory)
train_path = '..\midterm_data\midterm_data_reduced\TrainingDataset\';
% number of classes
class_num = 3;
% class names
class_name1 = '022.buddha-101';
class_name2 = '024.butterfly';
class_name3 = '251.airplanes';
% number of samples per class
sample_num = 50;

% feature and descriptor
fea_des = struct('class',{class_name1,class_name2,class_name3}, 'descriptor', {{} {} {}}, 'feature', {{} {} {}});

for i = 1:sample_num
    fullpath = [train_path, class_name1, '\022_', sprintf('%.4d.jpg', i)];
    I = imread(fullpath);
    [F, D] = sift(I);
    fea_des(1,1).descriptor{1, i} = D';
    fea_des(1,1).feature{1, i} = F';
end

for i = 1:sample_num
    fullpath = [train_path, class_name2, '\024_', sprintf('%.4d.jpg', i)];
    I = imread(fullpath);
    [F, D] = sift(I);
    fea_des(1,2).descriptor{1, i} = D';
    fea_des(1,2).feature{1, i} = F';
end

for i = 1:sample_num
    fullpath = [train_path, class_name3, '\251_', sprintf('%.4d.jpg', i)];
    I = imread(fullpath);
    [F, D] = sift(I);
    fea_des(1,3).descriptor{1, i} = D';
    fea_des(1,3).feature{1, i} = F';
end
% save results
save('fea_des.mat', 'fea_des');
