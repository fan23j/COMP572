%https://pixabay.com/photos/search/guava/
fruits = im2double(imread("../inputs/fruits.jpg"));
%rbms.info
books = im2double(imread("../inputs/books.jpg"));
%personal photo
orchids = im2double(imread("../inputs/orchids.jpg"));

%vignette for fruits
vignettef = fspecial('gaussian', [340 510], 200);
vignettef = vignettef/max(vignettef(:));

%turn to hsv for tuning
fruitsHSV = rgb2hsv(fruits);
%reduce hue by 40%
fh = fruitsHSV(:,:,1)*0.6;
%reduce saturation by 40%
fs = fruitsHSV(:,:,2)*0.6;
%reduce value by 10%
fv = fruitsHSV(:,:,3)*0.9;
fruitf = hsv2rgb(cat(3, fh, fs, fv));

A = figure(1);
subplot(1,2,1);
imshow(fruits);
subplot(1,2,2);
imshow(fruitf .* vignettef);
saveas(A, "outputs/fruitf.jpg");

vignetteb = fspecial('gaussian', [300 640], 200);
vignetteb = vignetteb/max(vignetteb(:));


booksHSV = rgb2hsv(books);
bh = booksHSV(:,:,1)*0.6;
bs = booksHSV(:,:,2)*0.6;
bv = booksHSV(:,:,3)*0.9;
bookf = hsv2rgb(cat(3, bh, bs, bv));

B = figure(2);
subplot(1,2,1);
imshow(books);
subplot(1,2,2);
imshow(bookf .* vignetteb);
saveas(B, "outputs/bookf.jpg");

vignetteo = fspecial('gaussian', [4608 3456], 2500);
vignetteo = vignetteo/max(vignetteo(:));

orchidsHSV = rgb2hsv(orchids);
oh = orchidsHSV(:,:,1)*0.6;
os = orchidsHSV(:,:,2)*0.6;
ov = orchidsHSV(:,:,3)*0.9;
orchidf = hsv2rgb(cat(3, oh, os, ov));

C = figure(3);
subplot(1,2,1);
imshow(orchids);
subplot(1,2,2);
imshow(orchidf .* vignetteo);
saveas(C, "outputs/orchidf.jpg");