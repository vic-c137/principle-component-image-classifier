clear all ; close all ;

% Load the projection matrix and singular values in case
% they are wanted for weighting principal axis scores.
% Filename format is Pkk, where kk is the number of
% principal components retained in the entire training set.
load -binary P15 ;
% load -binary s36 ;

dirs = ['c1' ; 'c2' ; 'c3' ; 'c4'] ;

% Show the training set for each character
for l=1:4
   for k=1:4
      fname=[dirs(l,:), '\', num2str(k), '.png'] ;
      X = imread(fname) ;
      subplot(2,2,k) ;
      imagesc(X) ;
      colormap(gray) ;
   end ;
   title(['character ', dirs(l,:)]) ;
   figure ;
end ;

% Classification loop (interactive)
% Get a file to classify
while true
   fname = input('filename prefix to classify (enter to end)? ') ;
   if isempty(fname)
       break ;
   end ;
   fname = [fname, '.png'] ;

   % Load the unknown image as a column vector
   % of size (pq x 1)
   x = imread(fname);
   X = x(:);%readpgm(fname,1,1) ;
   colormap(gray) ;
   figure(5) ;
   imagesc(x);%reshape(X,450,112)') ;
   colormap(gray) ;

   % Project it to the principal axis
   % Recall that P is (k x pq), where k is the number of principal
   % components retained from all characters.  The value for k
   % is specified in the load of Pkk above.
   % Thus Y is (k x 1).  This encodes unknown image X in terms
   % of principal components from all training characters.
   Y = (P * double(X)) ;

   % Recall that each template file is (k x 4) because there
   % are 4 training images per character.
   % So replicate to 4 columns for an easy diff operation.
   Y = repmat(Y, 1, 4) ;

   % Find the best average template match
   for l=1:4
      % Load the template
      tname=['T', dirs(l,:)] ;
      load(tname) ;
      
      % Compute the difference
      msdiff(l) = sqrt( mean(mean((Y-T).^2)) ) ; 
   end ;

   % Find smallest index
   disp(['smallest rms differences = ', num2str(msdiff)]) ;
   [val,index]=min(msdiff) ;
   disp(['smallest is index ', num2str(index)]) ;
   disp(['which is character ', dirs(index,:)]) ;
end ;

clear all ; close all ;
