% starter script for HW3

im_bg1 = im2double(imread('./samples/swim.jpg'));        % background image
im_obj1 = im2double(imread('./samples/bear.jpg'));       % source image
%https://inst.eecs.berkeley.edu/~cs194-26/fa17/upload/files/proj3/cs194-26-abo/
im_bg = im2double(imread('./samples/orange.jpg'));
im_obj = im2double(imread('./samples/apple.jpg'));
%https://pixabay.com/photos/palm-hand-finger-bleaching-1701989/
im_bg2 = im2double(imread('./samples/palm.jpg'));
im_obj2 = im2double(imread('./samples/eye.jpg'));
%https://medium.com/@kunalyadav/how-to-use-hands-and-palms-to-communicate-better-22a3d9719c4b
%https://www.technewsworld.com/story/86542.html
im_bg3 = im2double(imread('./samples/hands.jpg'));
im_obj3 = im2double(imread('./samples/earth.jpg'));
%https://www.wyff4.com/article/bigfoot-hunters-spot-legendary-hairy-creature-in-wnc-carolina-group-says/11648633#
%https://standardnews.com/parallel-forest-oklahoma-seriously-creepy-might-just-haunted/
im_bg4 = im2double(imread('./samples/forest.jpg'));
im_obj4 = im2double(imread('./samples/bigfoot.jpg'));

% get source region mask (extracted object) from the user
objmask = getMask(im_obj);
%{
objmask1 = getMask(im_obj1);
objmask2 = getMask(im_obj2);
objmask3 = getMask(im_obj3);
objmask4 = getMask(im_obj4);
%}

% Next, do the following.  1) Align the source object (im_s) and mask (mask_s)
% with the background image.  2) Pad the object by 64 pixels each side to
% allow for feathering/blending overlap.

[im_s, mask_s] = alignSource(im_obj, objmask, im_bg, 8);
mask_s = im2double(mask_s);
%{
[im_s1, mask_s1] = alignSource(im_obj1, objmask1, im_bg1, 64);
mask_s1 = im2double(mask_s1);

[im_s2, mask_s2] = alignSource(im_obj2, objmask2, im_bg2, 64);
mask_s2 = im2double(mask_s2);

[im_s3, mask_s3] = alignSource(im_obj3, objmask3, im_bg3, 64);
mask_s3 = im2double(mask_s3);

[im_s4, mask_s4] = alignSource(im_obj4, objmask4, im_bg4, 64);
mask_s4 = im2double(mask_s4);
%}

% Uncomment the following lines to see the results of getMask() and
% alignSource()

% figure; imshow(objmask);
% figure; imshow(im_s);
% figure; imshow(mask_s);

    % Let us try 3 different methods:
    %
    %   1.  Simple cut-and-paste.
%im_bg = background
%im_s = foreground after scaling to fit to background
%mask_s = mask of foreground to fit background

im_cut_and_paste = cut_and_paste(im_bg, im_s, mask_s);
%{
im_cut_and_paste1 = cut_and_paste(im_bg1, im_s1, mask_s1);
im_cut_and_paste2 = cut_and_paste(im_bg2, im_s2, mask_s2);
im_cut_and_paste3 = cut_and_paste(im_bg3, im_s3, mask_s3);
im_cut_and_paste4 = cut_and_paste(im_bg4, im_s4, mask_s4);
%}


    %   2.  Feathering.
    
blur = 16;     % width of crossfade
im_feather = alpha_blend(im_bg, im_s, mask_s, blur);
%{
im_feather1 = alpha_blend(im_bg1, im_s1, mask_s1, blur);
im_feather2 = alpha_blend(im_bg2, im_s2, mask_s2, blur);
im_feather3 = alpha_blend(im_bg3, im_s3, mask_s3, blur);
im_feather4 = alpha_blend(im_bg4, im_s4, mask_s4, blur);
%}
    
    %   3.  Blending based on Laplacian pyramids.

levels = 6;         % levels in the Laplacian pyramid
im_blend = laplacian_blend(im_bg, im_s, mask_s, levels);
%{
im_blend1 = laplacian_blend(im_bg1, im_s1, mask_s1, levels);
im_blend2 = laplacian_blend(im_bg2, im_s2, mask_s2, levels);
im_blend3 = laplacian_blend(im_bg3, im_s3, mask_s3, levels);
im_blend4 = laplacian_blend(im_bg4, im_s4, mask_s4, levels);
%}

    % Plot the pictures, and comment on the results obtained.

A = figure; imshow(im_cut_and_paste);
saveas(A, "./part1/set2/set2_result.jpg");
%{
B = figure; imshow(im_cut_and_paste1);
saveas(B, "./part1/set2/set2_result.jpg");
C = figure; imshow(im_cut_and_paste2);
saveas(C, "./part1/set3/set3_result.jpg");
D = figure; imshow(im_cut_and_paste3);
saveas(D, "./part1/set4/set4_result.jpg");
E = figure; imshow(im_cut_and_paste4);
saveas(E, "./part1/set5/set5_result.jpg");
%}
F = figure; imshow(im_feather);
saveas(F, "./part2/set2/set2_result.jpg");
%{
G = figure; imshow(im_feather1);
saveas(G, "./part2/set2/set2_result.jpg");
H = figure; imshow(im_feather2);
saveas(H, "./part2/set3/set3_result.jpg");
I = figure; imshow(im_feather3);
saveas(I, "./part2/set4/set4_result.jpg");
J = figure; imshow(im_feather4);
saveas(J, "./part2/set5/set5_result.jpg");
%}
K = figure; imshow(im_blend);
saveas(K, "./part3/set2/set2_result.jpg");
%{

L = figure; imshow(im_blend);
saveas(J, "./part3/set2/set2_result.jpg");
M = figure; imshow(im_blend);
saveas(J, "./part3/set3/set3_result.jpg");
N = figure; imshow(im_blend);
saveas(J, "./part3/set4/set4_result.jpg");
O = figure; imshow(im_blend);
saveas(J, "./part3/set5/set5_result.jpg");
%}

function im_cut_and_paste = cut_and_paste(im_bg, im_s, mask_s)
        %output = foreground*a + background(1-a)
        im_cut_and_paste = im_s.*mask_s + im_bg.*(1-mask_s);
end

function im_feather = alpha_blend(im_bg, im_s, mask_s, blur)
        im_feather = im_s.*imgaussfilt(mask_s,blur) + im_bg.*imgaussfilt(1-mask_s,blur);
end
    
function im_blend = laplacian_blend(im_bg, im_s, mask_s, levels)   
        pyr_G = pyr_gaussian(mask_s,levels);
        pyr_L = pyr_laplacian(im_bg,levels);
        pyr_L1 = pyr_laplacian(im_s, levels);
        L = cell([levels, 1]);
        for i=1: levels
            L{i} = pyr_L1{i}.*pyr_G{i} + pyr_L{i}.*(1-pyr_G{i});
        end
        im_blend = pyr_laplacian_collapse(L);
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
    
function im = pyr_laplacian_collapse(pyr)
% computes the image from its Laplacian pyramid
    levels = size(pyr, 1);
    for i=(levels-1):-1:1
        pyr{i} = pyr{i} + imresize(pyr{i+1},[height(pyr{i}),width(pyr{i})]);
    end
    im = pyr{1};     
end