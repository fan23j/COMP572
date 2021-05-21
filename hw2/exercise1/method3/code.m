%load original images
venice = im2double(imread("inputs/venice1.jpg"));
snow = im2double(imread("inputs/snow1.jpg"));
%personal
dog = im2double(imread("inputs/dog.jpg"));
%web: https://www.freepik.com/photos/background
cherry = im2double(imread("inputs/cherry.jpg"));

%separate by RGB component
veniceR = venice(:,:,1);
veniceG = venice(:,:,2);
veniceB = venice(:,:,3);

snowR = snow(:,:,1);
snowG = snow(:,:,2);
snowB = snow(:,:,3);

dogR = dog(:,:,1);
dogG = dog(:,:,2);
dogB = dog(:,:,3);

cherryR = cherry(:,:,1);
cherryG = cherry(:,:,2);
cherryB = cherry(:,:,3);

%using formula: gray = red*0.30 + green*0.59 + blue*0.11
veniceGray = (veniceR*0.30+veniceG*0.59+veniceB*0.11);
A = figure(1);
subplot(1,2,1);
imshow(venice);
subplot(1,2,2);
imshow(veniceGray);
saveas(A, "outputs/veniceGray.jpg");

snowGray = (snowR*0.30+snowG*0.59+snowB*0.11);
B = figure(2);
subplot(1,2,1);
imshow(snow);
subplot(1,2,2);
imshow(snowGray);
saveas(B, "outputs/snowGray.jpg");

dogGray = (dogR*0.30+dogG*0.59+dogB*0.11);
C = figure(3);
subplot(1,2,1);
imshow(dog);
subplot(1,2,2);
imshow(dogGray);
saveas(C, "outputs/dogGray.jpg");

cherryGray = (cherryR*0.30+cherryG*0.59+cherryB*0.11);
D = figure(4);
subplot(1,2,1);
imshow(cherry);
subplot(1,2,2);
imshow(cherryGray);
saveas(D, "outputs/cherryGray.jpg");
