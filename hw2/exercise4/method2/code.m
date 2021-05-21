%load images
venice3 = im2double(imread("../inputs/venice3.jpg"));
snow3 = im2double(imread("../inputs/snow3.jpg"));
%web: https://www.lynda.com/Photoshop-tutorials/Photoshop-Color-Correction-Low-Contrast/137893-2.html
bull = im2double(imread("../inputs/bull.jpg"));
%personal
dogL = im2double(imread("../inputs/dogL.jpg"));

veq = histeq(venice3);
seq = histeq(snow3);
beq = histeq(bull);
deq = histeq(dogL);

A = figure(1);
subplot(1,2,1);
imshow(veq);
subplot(1,2,2);
imhist(veq);
saveas(A, "outputs/veniceC.jpg");

B = figure(2);
subplot(1,2,1);
imshow(seq);
subplot(1,2,2);
imhist(seq);
saveas(B, "outputs/snowC.jpg");

C = figure(3);
subplot(1,2,1);
imshow(beq);
subplot(1,2,2);
imhist(beq);
saveas(C, "outputs/bullC.jpg");

D = figure(4);
subplot(1,2,1);
imshow(deq);
subplot(1,2,2);
imhist(deq);
saveas(D, "outputs/dogC.jpg");