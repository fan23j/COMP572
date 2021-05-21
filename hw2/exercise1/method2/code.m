%load original images
venice = im2double(imread("inputs/venice1.jpg"));
snow = im2double(imread("inputs/snow1.jpg"));
%personal
dog = im2double(imread("inputs/dog.jpg"));
%web: https://www.freepik.com/photos/background
cherry = im2double(imread("inputs/cherry.jpg"));

%using formula: gray=(red+blue+green)/3

%separate by RGB component
veniceR = venice(:,:,1);
veniceG = venice(:,:,2);
veniceB = venice(:,:,3);
%average
veniceGr = (veniceR+veniceG+veniceB)/3;
A = figure(1);
subplot(1,2,1);
imshow(venice);
subplot(1,2,2);
imshow(veniceGr);
%write image
saveas(A, "outputs/veniceGray.jpg");

snowR = snow(:,:,1);
snowG = snow(:,:,2);
snowB = snow(:,:,3);
snowGr = (snowR+snowG+snowB)/3;
B = figure(2);
subplot(1,2,1);
imshow(snow);
subplot(1,2,2);
imshow(snowGr);
saveas(B, "outputs/snowGray.jpg");

dogR = dog(:,:,1);
dogG = dog(:,:,2);
dogB = dog(:,:,3);
dogGr = (dogR+dogG+dogB)/3;
C = figure(3);
subplot(1,2,1);
imshow(dog);
subplot(1,2,2);
imshow(dogGr);
saveas(C, "outputs/dogGray.jpg");

cherryR = cherry(:,:,1);
cherryG = cherry(:,:,2);
cherryB = cherry(:,:,3);
cherryGr = (cherryR+cherryG+cherryB)/3;
D = figure(4);
subplot(1,2,1);
imshow(cherry);
subplot(1,2,2);
imshow(cherryGr);
saveas(D, "outputs/cherryGray.jpg");
