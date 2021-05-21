%load original images
venice = im2double(imread("inputs/venice1.jpg"));
snow = im2double(imread("inputs/snow1.jpg"));
%personal
dog = im2double(imread("inputs/dog.jpg"));
%web: https://www.freepik.com/photos/background
cherry = im2double(imread("inputs/cherry.jpg"));

%Use the following formulas for creating new red, green and blue components:
%sepia_r = red*0.393 + green*0.769 + blue*0.189;
%sepia_g = red*0.349 + green*0.686 + blue*0.168;
%sepia_b = red*0.272 + green*0.534 + blue*0.131;

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

%scale components by scalars
veniceSR = veniceR*0.393 + veniceG*0.769 + veniceB*0.189;
veniceSG = veniceR*0.349 + veniceG*0.686 + veniceB*0.168;
veniceBG = veniceR*0.272 + veniceG*0.534 + veniceB*0.131;
veniceS = cat(3,veniceSR, veniceSG ,veniceBG);
A = figure(1);
subplot(1,2,1);
imshow(venice);
subplot(1,2,2);
imshow(veniceS);
saveas(A, "outputs/veniceGray.jpg");

snowSR = snowR*0.393 + snowG*0.769 + snowB*0.189;
snowSG = snowR*0.349 + snowG*0.686 + snowB*0.168;
snowBG = snowR*0.272 + snowG*0.534 + snowB*0.131;
snowS = cat(3,snowSR, snowSG ,snowBG);
B = figure(2);
subplot(1,2,1);
imshow(snow);
subplot(1,2,2);
imshow(snowS);
saveas(B, "outputs/snowGray.jpg");

dogSR = dogR*0.393 + dogG*0.769 + dogB*0.189;
dogSG = dogR*0.349 + dogG*0.686 + dogB*0.168;
dogBG = dogR*0.272 + dogG*0.534 + dogB*0.131;
dogS = cat(3,dogSR, dogSG ,dogBG);
C = figure(3);
subplot(1,2,1);
imshow(dog);
subplot(1,2,2);
imshow(dogS);
saveas(C, "outputs/dogGray.jpg");

cherrySR = cherryR*0.393 + cherryG*0.769 + cherryB*0.189;
cherrySG = cherryR*0.349 + cherryG*0.686 + cherryB*0.168;
cherryBG = cherryR*0.272 + cherryG*0.534 + cherryB*0.131;
cherryS = cat(3,cherrySR, cherrySG ,cherryBG);
D = figure(4);
subplot(1,2,1);
imshow(cherry);
subplot(1,2,2);
imshow(cherryS);
saveas(D, "outputs/cherryGray.jpg");