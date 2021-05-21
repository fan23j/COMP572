%load original images
venice = im2double(imread("inputs/venice1.jpg"));
snow = im2double(imread("inputs/snow1.jpg"));
%personal
dog = im2double(imread("inputs/dog.jpg"));
%web: https://www.freepik.com/photos/background
cherry = im2double(imread("inputs/cherry.jpg"));

%rgb2gray()
veniceGray = rgb2gray(venice);
A = figure(1);
subplot(1,2,1);
imshow(venice);
subplot(1,2,2);
imshow(veniceGray);
%write image to outputs folder
saveas(A, "outputs/veniceGray.jpg");

snowGray = rgb2gray(snow);
B = figure(2);
subplot(1,2,1);
imshow(snow);
subplot(1,2,2);
imshow(snowGray);
saveas(B, "outputs/snowGray.jpg");

dogGray = rgb2gray(dog);
C = figure(3);
subplot(1,2,1);
imshow(dog);
subplot(1,2,2);
imshow(dogGray);
saveas(C, "outputs/dogGray.jpg");

cherryGray = rgb2gray(cherry);
D = figure(4);
subplot(1,2,1);
imshow(cherry);
subplot(1,2,2);
imshow(cherryGray);
saveas(D, "outputs/cherryGray.jpg");
