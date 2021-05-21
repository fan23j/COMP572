%https://pixabay.com/photos/search/guava/
fruits = im2double(imread("../inputs/fruits.jpg"));
%rbms.info
books = im2double(imread("../inputs/books.jpg"));
%personal photo
orchids = im2double(imread("../inputs/orchids.jpg"));


%turn to hsv for tuning
fruitsHSV = rgb2hsv(fruits);
fh = fruitsHSV(:,:,1);
%increase saturation by 100%
fs = fruitsHSV(:,:,2)*2;
fv = fruitsHSV(:,:,3);
fruitf = hsv2rgb(cat(3, fh, fs, fv));
%increase contrast through histeq()
fruitf = histeq(fruitf);
%adjust RGB contrast
fruitf = imadjust(fruitf,[.4 .3 0; .9 1 1],[]);

A = figure(1);
subplot(1,2,1);
imshow(fruits);
subplot(1,2,2);
imshow(fruitf);
saveas(A, "outputs/fruitf.jpg");

booksHSV = rgb2hsv(books);
bh = booksHSV(:,:,1);
bs = booksHSV(:,:,2)*2;
bv = booksHSV(:,:,3);
bookf = hsv2rgb(cat(3, bh, bs, bv));
bookf = histeq(bookf);
bookf = imadjust(bookf,[.4 .3 0; .9 1 1],[]);

B = figure(2);
subplot(1,2,1);
imshow(books);
subplot(1,2,2);
imshow(bookf);
saveas(B, "outputs/bookf.jpg");


orchidsHSV = rgb2hsv(orchids);
oh = orchidsHSV(:,:,1);
os = orchidsHSV(:,:,2)*2;
ov = orchidsHSV(:,:,3);
orchidf = hsv2rgb(cat(3, oh, os, ov));
orchidf = histeq(orchidf);
orchidf = imadjust(orchidf,[.4 .3 0; .9 1 1],[]);

C = figure(3);
subplot(1,2,1);
imshow(orchids);
subplot(1,2,2);
imshow(orchidf);
saveas(C, "outputs/orchidf.jpg");
