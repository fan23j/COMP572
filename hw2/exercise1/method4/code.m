%load original images
venice = im2double(imread("inputs/venice1.jpg"));
snow = im2double(imread("inputs/snow1.jpg"));
%personal
dog = im2double(imread("inputs/dog.jpg"));
%web: https://www.freepik.com/photos/background
cherry = im2double(imread("inputs/cherry.jpg"));

%hsv2rgb()
%convert to hsv
veniceHSV = rgb2hsv(venice);
%set saturation to 0
veniceHSV(:,:,2) = veniceHSV(:,:,2)*0.0;
%convert back to rgb
veniceRGB = hsv2rgb(veniceHSV);
A = figure(1);
subplot(1,2,1);
imshow(venice);
subplot(1,2,2);
imshow(veniceRGB);
%write image
saveas(A, "outputs/veniceGray.jpg");

snowHSV = rgb2hsv(snow);
snowHSV(:,:,2) = snowHSV(:,:,2)*0.0;
snowRGB = hsv2rgb(snowHSV);
B = figure(2);
subplot(1,2,1);
imshow(snow);
subplot(1,2,2);
imshow(snowRGB);
saveas(B, "outputs/snowGray.jpg");

dogHSV = rgb2hsv(dog);
dogHSV(:,:,2) = dogHSV(:,:,2)*0.0;
dogRGB = hsv2rgb(dogHSV);
C = figure(3);
subplot(1,2,1);
imshow(dog);
subplot(1,2,2);
imshow(dogRGB);
saveas(C, "outputs/dogGray.jpg");

cherryHSV = rgb2hsv(cherry);
cherryHSV(:,:,2) = cherryHSV(:,:,2)*0.0;
cherryRGB = hsv2rgb(cherryHSV);
D = figure(4);
subplot(1,2,1);
imshow(cherry);
subplot(1,2,2);
imshow(cherryRGB);
saveas(D, "outputs/cherryGray.jpg");
