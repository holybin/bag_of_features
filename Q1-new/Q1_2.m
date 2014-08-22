% Q1.2: Cluster all the SIFT feature descriptors

close all;clearvars -except N;

global N;

load('all_des.mat');
[des_num, des_dim] = size(all_des);

% initialize centres
centres = (zeros(N, des_dim));
perm = randperm(des_num);
perm = perm(1:N);
centres = double(all_des(perm, :));
old_centres = centres;
clear all_des;

% reload
load('fea_des.mat');
class_num = size(fea_des,2);
sample_num = size(fea_des(1,1).descriptor, 2);
nimages = class_num*sample_num; % number of images

% K-means clustering
display('Begin to run kmeans...');
total_num_per_bin = zeros(1, N);
niters = 200;   % maximum iterations
ThrError = 0.1;     % error threshold
for n = 1:niters
    % centre errors
    e2 = max(max(abs(centres - old_centres)));
    % save old centres to check for termination
    old_centres = centres;
    % temporary centres
    tempc = zeros(N, des_dim);
    total_num_per_bin = zeros(1, N);

    for f = 1:nimages
        % get sample descriptor
        class = ceil(f/sample_num);
        sample = f-(class-1)*sample_num;
        data = fea_des(1,class).descriptor{1,sample};

        id = eye(N);
        d2 = EuclideanDistance(double(data),double(centres));
        % assign each descriptor to nearest centre
        [minvals, index] = min(d2', [], 1);
        % matrix, if descriptor i is in cluster j, post(i,j)=1, else 0;
        post = id(index,:);

        total_num_per_bin = total_num_per_bin + sum(post, 1);

        for j = 1:N
            tempc(j,:) =  double(tempc(j,:)+sum(data(find(post(:,j)),:), 1));
        end
    end
    fprintf('The %d th interation finished: eCenter=%f \n',n,e2);
    
    % calculate new centres
    for j = 1:N
        if total_num_per_bin(j)>0
            centres(j,:) =  double(tempc(j,:)/total_num_per_bin(j));
        end
    end
    
    % termination condition
    if n >= 1

        % centres is stable
        diff = max(max(abs(centres - old_centres)));
        fprintf('The centre error is %f.\n',diff);
        if  diff < ThrError
            disp('Clustering finished.');
            save('centres.mat', 'centres');
            break;
        end
    end
end



