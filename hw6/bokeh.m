close all;    % close all figure windows

%sources: set1: https://www.photoblog.com/learn/beautiful-couples-poses-for-adorable-photos/
% set2: https://www.scarymommy.com/spotted/best-outdoor-swings-for-kids/
% set3: 
I=im2double(imread('set4/original.jpg'));
%figure(1); imshow(I);


% The following lines can be helpful during debugging
% to avoid having to repeatedly draw the mask.  You can enter
% it once, save it as an image, and then comment the getMask()
% call and simply read the mask in from file.
%
mask = getMask(I);
%imwrite(im2double(mask), 'set1/mask.png');
%mask = im2double(imread('mask.png'));   
figure(2); imshow(mask);

fg = I .* mask;
bg = I .* (1 - mask);
figure(3); imshow(fg);
figure(4); imshow(bg);

radius = 15;            % choose this carefully for each image
disk = fspecial('disk', radius);

figure; imshow(method1(I, mask, disk));
figure; imshow(method2(I, mask, disk));
figure; imshow(method3(I, mask, disk));



function result = method1(I, mask, filter)
    I_blur = imfilter(I, filter, 'replicate');
    result = I_blur .* (1 - mask) + I .* mask;
end

function result = method2(I, mask, filter)
    bg = I .* (1 - mask);
    bg_blur = imfilter(bg, filter, 'replicate');
    result = bg_blur .* (1 - mask) + I .* mask;
end

function result = method3(I, mask, filter)
    bg = imfilter(I .* (1-mask), filter, 'replicate');
    den = imfilter(1-mask, filter, 'replicate');
    bg = bg ./ den;
    bg(isnan(bg))=0;
    result = bg .* (1-mask) + I .* mask;
end



function [mask, poly] = getMask(im)
% [mask, poly] = getMask(im)
% Asks user to draw polygon around input image.  Provides binary mask of
% polygon and a chain of all interior boundary points.

disp('Draw polygon around source object in clockwise order, q to stop')
figure(1), hold off, imagesc(im), axis image;
sx = [];
sy = [];
while 1
    figure(1)
    [x, y, b] = ginput(1);
    if b=='q'
        break;
    end
    sx(end+1) = x;
    sy(end+1) = y;
    hold on, plot(sx, sy, '*-');
end

mask = poly2mask(sx, sy, size(im, 1), size(im, 2));
if nargout>1
    [poly.x, poly.y] = mask2chain(mask);
end
end
