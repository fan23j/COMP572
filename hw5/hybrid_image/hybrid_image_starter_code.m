close all; % closes all figures (remaining from previous run)

% read images and convert to single format
im1 = im2double(imread('./DerekPicture.jpg')); 		% "far" picture
im2 = im2double(imread('./nutmeg.jpg')); 			% "near" picture
im1 = rgb2gray(im1); % convert to grayscale
im2 = rgb2gray(im2);

% use this if you want to align the two images (e.g., by the eyes) and crop
% them to be of same size
[im2, im1] = align_images(im2, im1);


%% Choose the cutoff frequencies for the low-pass andhigh-pass filters
cutoff_low  = ...                % provide a value for the low-pass filter cutoff frequency (sigma of gaussian)
cutoff_high = ...                % provide a value for the high-pass filter cutoff frequency (sigma of gaussian)


%% Compute the hybrid image (you supply this code)

im_12 = hybridImage(im1, im2, cutoff_low, cutoff_high);

%% Crop resulting image (optional)
figure(1), hold off, imagesc(im12), axis image, colormap gray
disp('input crop points');
[x, y] = ginput(2);  x = round(x); y = round(y);
im12 = im12(min(y):max(y), min(x):max(x), :);
figure(1), hold off, imagesc(im12), axis image, colormap gray


%% For your ONE favorite hybrid result, also show the Gaussian and Laplacian Pyramids
%% (use code from HW3)

% levels = 6 % number of pyramid levels (you may use more or fewer, as needed)
% display gaussian pyramid
% display laplacian pyramid


%% Your functions appear below (or in separate files)
