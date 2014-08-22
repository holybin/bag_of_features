%plot_res.m: plot classifiction accuracy vs. class label

load('conf_matrix.mat');
conf = diag(conf_matrix)';

load('class_names.mat');
% class label
x = [];
for i = 1:size(class_names,1)
    x(i) = i;
end

figure;
plot(x,conf,'r-',x,conf,'b*');
xlabel('class');ylabel('accuracy');
% legend('COS','Location','North');
title('cosine')

% title('euclidean')
% legend('EUC','Location','North');
