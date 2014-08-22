% getall.m: transform feature descriptors to matrix form.

% If have saved as below, then ignore 'getall' module:
%   save('all_des.mat', 'all_des');

% If have not saved as above, then use 'getall' module:
%   getall;

load('fea_des.mat');

all_des = [];

m = size(fea_des, 2);
for i = 1:m
    % each class
    class_des = fea_des(1, i).descriptor;
    class_fea = fea_des(1, i).feature;
    n = size(class_des, 2);
    % each sample
    for j = 1:n
        sample_des = class_des{1, j};
        sample_fea = class_fea{1, j};
        p = size(sample_des,1);
        % each descriptor and feature
        for k = 1:p
            all_des = [all_des; sample_des(k,:)];
        end
    end
end

% save results
save('all_des.mat', 'all_des');
