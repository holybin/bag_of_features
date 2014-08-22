% calsurf_test.m: find the SURF feature descriptors within each test image

clearvars -except N test_root;
close all;

global test_root;

K = 64; % surf descriptor dimension

all_des_sample_test = {};   % all the surf descriptors per sample: 1*N cell
test_img_names = {};  % testing image names

test_dir = dir(fullfile(test_root, '*.jpg'));
test_files = {test_dir.name}';   % N*1 cell
for i = 1:size(test_files,1)
    test_file = test_files{i,:};
    
    test_img_names = cat(1,test_img_names,test_file);
    
    img = fullfile(test_root, test_file);
    % surf feature
    I = imread(img);
    Options.upright = false; % rotation invariant
    Options.tresh = 0.0002; % Hessian response threshold
    img_surf = OpenSurf(I, Options);

    % put the landmark descriptors in a matrix
    D = (reshape([img_surf.descriptor],K,[]))';

    all_des_sample_test = cat(1, all_des_sample_test, D);
end

% save results
save('all_des_sample_test.mat', 'all_des_sample_test');
save('test_img_names.mat', 'test_img_names');
