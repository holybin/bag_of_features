% cluster.m: cluster training set descriptors

clearvars -except N;
close all;

global N;

% reload
load('all_des.mat');
load('all_des_sample.mat');
nimages = size(all_des_sample, 2);  % number of images
[des_num, des_dim] = size(all_des);

% initialize centres
centres = (zeros(N, des_dim));
perm = randperm(des_num);
perm = perm(1:N);
centres = double(all_des(perm, :));
old_centres = centres;

clear all_des;

% K-means clustering
display('Begin to do clustering...');
total_num_per_bin = zeros(1, N);

niters = 200; % maximum iterations
ThrError = 0.01;    % error threshold

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
        data = all_des_sample{1,f};

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
            disp('Clustering finished...');
            save('centres.mat', 'centres');
            break;
        end
    end
end