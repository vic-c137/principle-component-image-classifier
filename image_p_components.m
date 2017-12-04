close all ; clear all ; clc ;

% Read all training images into a single matrix
% Each image is a column vector
% Each image is p x q
% There are n = 4 distinct characters in the training set
% There are m = 4 examples images for each training character
d = 4; % The number of characters/directories
c = 4; % The number of base examples of each

% The image vector matrix
X = [] ;
% for each character directory: .\sNN\
dirs=['c1'; 'c2'; 'c3' ; 'c4'] ;
for n=1:d
   % for each training image: N.png
   for m=1:c
      fname=[dirs(n,:), '\', num2str(m), '.png'] ;
	  % load png images into X as column vectors
	  x = imread(fname);
      X = [X x(:)] ;
   end ;
end ;

% Get the size of X
[pq,mn] = size(X) ;

% Get the covariance matrix and eigen decomposition
% using SVD (Singular Value Decomposition)
% X is (pq x mn)e
[U,S,V] = svd(X, 'econ') ;
s = diag(S) ;

% Plot the (normalized) eigenvalues
plot(s/norm(s)) ;
title([num2str(length(s)), 'singular values']) ;

% Retain k values, transform, and display.
% Save the truncated projection and singular values
% with a postfix that indicates the number retained.
% Note that P=U' is (k x pq) with a max of (mn x pq)
% mn = 16 as there are 4 subjects and 4 images each
k = input('how many would you like to retain?') ;
P = U(:, 1:k)' ;
% s = s(1:k)' ;
save('-binary', ['P',num2str(k)], 'P') ;
% save('-binary', ['s',num2str(k)], 's') ;

% Train a template for each class/character by
% projecting the training set for that character
% onto P for each character directory
dirs=['c1'; 'c2'; 'c3' ; 'c4'] ;
for n=1:d
   X = [] ;
   % for each training image
   for m=1:c
      fname=[dirs(n,:), '\', num2str(m), '.png'] ;
	  x = imread(fname);
      X = [X x(:)] ;
   end ;
   % Transform the set for this character
   % and save it as a TNN template file.
   % Note that the template is (k x 4), where k is
   % the number of Principal components retained
   % (Here the max template size is (36 x 9)
   T = (P * double(X)) ;
   save('-binary', ['T', dirs(n,:)], 'T') ;
end ;
