function [F, D] = sift(I);
% DESCRIPTION:
%   [F, D] = sift(I) computes the SIFT frames (keypoints) F of the image I. 
% PARAMETERS:
%   I:
%       it is a gray-scale image in single precision. 
% RETURN:
%   F:
%       Each column of F is a feature frame and has the format [X;Y;S;TH], 
%       where X,Y is the (fractional) center of the frame, S is the scale 
%       and TH is the orientation (in radians).
%   D:
%       Each column of D is the descriptor of the corresponding frame in F.
%       A descriptor is a 128-dimensional vector of class UINT8.
%

[m, n, k] = size(I);
if (k == 3)
    gray = rgb2gray(I);
else
    gray = I;
end

gray_single = im2single(gray);
[F, D] = vl_sift(gray_single);
