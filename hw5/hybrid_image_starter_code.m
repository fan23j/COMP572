close all; % closes all figures (remaining from previous run)

% read images and convert to single format
im2 = im2double(imread('./set5/set5_far.jpg')); 		% "far" picture
im1 = im2double(imread('./set5/set5_near.jpg')); 			% "near" picture
%im1 = rgb2gray(im1); % convert to grayscale
%im2 = rgb2gray(im2);

% use this if you want to align the two images (e.g., by the eyes) and crop
% them to be of same size
[im2, im1] = align_images(im2, im1);

%% Choose the cutoff frequencies for the low-pass andhigh-pass filters
cutoff_low  = 30              % provide a value for the low-pass filter cutoff frequency (sigma of gaussian)
cutoff_high = 20            % provide a value for the high-pass filter cutoff frequency (sigma of gaussian)


%% Compute the hybrid image (you supply this code)

im_12 = hybridImage(im1, im2, cutoff_low, cutoff_high);
%% Crop resulting image (optional)
%{
figure(1), hold off, imagesc(im12), axis image, colormap gray
disp('input crop points');
[x, y] = ginput(2);  x = round(x); y = round(y);
im12 = im12(min(y):max(y), min(x):max(x), :);
figure(1), hold off, imagesc(im12), axis image, colormap gray
%}

%% For your ONE favorite hybrid result, also show the Gaussian and Laplacian Pyramids
%% (use code from HW3)

levels = 6 % number of pyramid levels (you may use more or fewer, as needed)
% display gaussian pyramid
A = pyr_gaussian(im_12, levels);
display_gaussian(A)
% display laplacian pyramid
B = pyr_laplacian(im_12, levels);
display_laplacian(B)

%% Your functions appear below (or in separate files)
function img = hybridImage(im1, im2, cutoff_low, cutoff_high)
   %fourier transform
    f_im1 = fft2(im1);
    f_im1 = fftshift(f_im1);
    %shift fourier for manual inspection of sigma
    figure(1); imagesc(log(abs(f_im1)))
    %obtain size of fourier transform
    [height, width,dim] = size(f_im1);
    G = fspecial('gaussian',[height,width],cutoff_low);
    G = G/max(G(:));
    f_im1_lpf = f_im1 .*G;
    im1_lpf = real(ifft2(f_im1_lpf));
    
    %fourier transform
    f_im2 = fft2(im2);
    f_im2 = fftshift(f_im2);
    %shift fourier for manual inspection of sigma
    figure(2); imagesc(log(abs(f_im2)))
    %obtain size of fourier transform
    [height, width,dim] = size(f_im2);
    G = fspecial('gaussian',[height,width],cutoff_high);
    G = G/max(G(:));
    H = 1-G;
    f_im2_hpf = f_im2 .*H;
    im2_hpf = real(ifft2(ifftshift(f_im2_hpf)));
   
    img = real(ifft2(ifftshift(f_im1_lpf * 0.4 + f_im2_hpf * 0.6)));
    figure(3);imshow(img)
end

function pyr_G = pyr_gaussian(im, levels)
% Computes Gaussian pyramid of image im over number of levels
    pyr_G = cell([levels, 1]);      % declare cell array of height "levels", and width 1
    
    pyr_G{1} = im;                  % level 1 is the orignal image
    for i=2:levels
        pyr_G{i} = imresize(imgaussfilt(pyr_G{i-1},2),1/2);
    end                             % level i is image at level i-1 filtered with Gaussian(2)
                                    % and then downsampled by factor of 2                            
end

function pyr_L = pyr_laplacian(im, levels)
% Computes Laplacian pyramid of image im over number of levels
    pyr_G = pyr_gaussian(im, levels);   % first compute the Gaussian pyramid

    pyr_L = cell([levels, 1]);      % declare cell array of height "levels", and width 1
    
    pyr_L{levels} = pyr_G{levels};  % top level of Laplacian pyramid is the same as that of Gaussian pyramid
    for i= (levels-1):-1:1
        pyr_L{i} = pyr_G{i} - imresize(pyr_G{i+1},[height(pyr_G{i}),width(pyr_G{i})]);
                                    % level i of Laplacian is the difference of
                                    % Gaussian level i and upsampled level i+1
                                    % equalizes size by upsampling G{i+1}
    end
end

function display_gaussian(pyr)  % code is complete!
% displays the Gaussian pyramid
    montage(pyr);              
end
    
function display_laplacian(pyr) % code is complete!
% displays the Laplacian pyramid
    levels = size(pyr, 1);      
    for i=1:levels-1
        pyr{i} = pyr{i} + 0.5;   % false color all levels except topmost by adding 0.5
    end
    
    montage(pyr);
end

%{
Sources:
Set2
https://highlandcanine.com/six-major-benefits-of-dog-training/
https://denverzoo.org/zootales/wolf-reintroduction-101/

Set3
https://www.callcentrehelper.com/das-cloud-platform-144664.htm
https://nature.desktopnexus.com/wallpaper/414807/

Set4
https://www.photocase.com/photos/2476210-front-view-of-cute-common-brown-frog-beautiful-face-nature-photocase-stock-photo
https://www.leisurepro.com/blog/scuba-gear/best-swimming-goggles-for-adults/

Set5
https://line.17qq.com/articles/fksgpqkky.html
https://www.flickr.com/photos/88520632@N02/9451083541

Set6
https://www.kdef.se/
%}
    